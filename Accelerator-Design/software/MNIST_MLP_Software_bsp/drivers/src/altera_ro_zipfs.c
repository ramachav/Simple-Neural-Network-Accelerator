/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2003-2005 Altera Corporation, San Jose, California, USA.      *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
* Author PRR                                                                  *
*                                                                             *
* A simple read only file system which is built by winzip or pkzip.           *
*                                                                             *
* NB This DOES NOT Support compressed files at the moment, make sure you use  *
* the -eo option on the winzip command line to specify no compression         *
*                                                                             *
******************************************************************************/

#include <fcntl.h>
#include <sys/stat.h>
#include <sys/unistd.h>
#include <sys/param.h>
#include <errno.h>
#include <limits.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>

#include "sys/alt_warning.h"
#include "sys/alt_dev.h"
#include "sys/alt_irq.h"
#include "sys/alt_alarm.h"
#include "altera_ro_zipfs.h"
#include "sys/ioctl.h"
#include "alt_types.h"

#define ZIP_FILE_RECORD             0x04034b50
#define ZIP_FILE_HEADER_SIZE        30
#define ZIP_FILE_EXTRA_LEN          28

#define ZIP_DIRECTORY_RECORD        0x02014b50
#define ZIP_DIR_UNCOMPRESSED_LEN    24
#define ZIP_DIR_NAME_LEN            28
#define ZIP_DIR_EXTRA_LEN           30
#define ZIP_DIR_COMMENT_LEN         32
#define ZIP_DIR_OFFSET              42
#define ZIP_DIR_HEADER_SIZE         46

#define ZIP_END_OF_DIRECTORY_RECORD 0x06054b50

/*
* read_word
*
* reads a word from an address in flash
* this is necessary as we can't do 
* unaligned from an unaligned boundary in Nios II
*/
static alt_u32 read_word(alt_u8* current_ptr)
{
  return (alt_u32)(*current_ptr | 
         (*(current_ptr+1) << 8) | 
         (*(current_ptr+2) << 16) |
         (*(current_ptr+3) << 24 ));
}

/*
* read_word_inc
*
* reads a word from an address in flash, and increments the ptr
* this is necessary as we can't do 
* unaligned from an unaligned boundary in Nios II
*/
static alt_u32 read_word_inc(alt_u8** current_ptr)
{
  alt_u32 value = read_word(*current_ptr);
  *current_ptr += 4;
  return value;
}

/*
* read_half_word
*
* reads a half word from an address in flash
* this is necessary as we can't do 
* unaligned from an unaligned boundary in Nios II
*/
static alt_u16 read_half_word(alt_u8* current_ptr)
{
  return (alt_u16)(*current_ptr | 
         (*(current_ptr+1) << 8));
}

/*
* read_half_word_inc
*
* reads a half word from an address in flash, and increment the ptr
* this is necessary as we can't do 
* unaligned from an unaligned boundary in Nios II
*/
static alt_u16 read_half_word_inc(alt_u8** current_ptr)
{
  alt_u16 value = read_word(*current_ptr);
  *current_ptr += 2;
  return value;
}

/*
* check_file_header
*
* Check that this is a file header we can cope with and inrement the current ptr 
* accordingly
*/
static int check_file_header(alt_u8** current_ptr)
{
  int ret_code = -ENOENT;
  alt_u16 name_len, extra_len, version, flags, compression;
  alt_u32 uncompressed_len, compressed_len;

  version = read_half_word_inc(current_ptr);

  /* We can parse files designed for version 10 */
  if (version > 10)
  {
    goto exit;
  }

  /* Read the flags, right now any flags are an error */
  flags = read_half_word_inc(current_ptr);

  if (flags )
  {
    goto exit;
  }

  compression = read_half_word_inc(current_ptr);

  /* Skip the mod times and the CRC */
  *current_ptr += 8;

  /* Read the compressed and uncompressed lengths, these should be the same */
  compressed_len = read_word_inc(current_ptr);
  uncompressed_len = read_word_inc(current_ptr);

  if ((compression) || (compressed_len != uncompressed_len))
  {
    goto exit;
  }

  /* Read the length of the name and extra fields */
  name_len = read_half_word_inc(current_ptr);
  extra_len = read_half_word_inc(current_ptr);

  /* Skip the name and extra fields */
  *current_ptr += name_len;
  *current_ptr += extra_len;

  *current_ptr += compressed_len;

  ret_code = 0;

exit:
  return ret_code;
}

/*
* Sanity check an entry in the directory structure
* 
* returns 0 for success -ENOENT if not
*/
int check_directory_header(alt_u8** current_ptr)
{
  int ret_code = -ENOENT;
  alt_u16 version, flags, compression, name_len, extra_len, comment_len;
  alt_u32 compressed_len, uncompressed_len;

  /* We don't care what version made this file */
  *current_ptr += 2;

  /* We can parse files designed for version 10 */
  version = read_half_word_inc(current_ptr);
  if (version > 10)
  {
    goto exit;
  }

  /* Read the flags, any set are an error */
  flags = read_half_word_inc(current_ptr);

  if (flags )
  {
    goto exit;
  }

  compression = read_half_word_inc(current_ptr);


  /* Skip the mod times and the CRC */
  *current_ptr += 8;

  /* Read the compressed and uncompressed lengths,these should be the same */
  compressed_len = read_word_inc(current_ptr);
  uncompressed_len = read_word_inc(current_ptr);

  if ((compression) || (compressed_len != uncompressed_len))
  {
    goto exit;
  }

  /* Read the length of the name, extra fields and comment fields*/
  name_len = read_half_word_inc(current_ptr);
  extra_len = read_half_word_inc(current_ptr);
  comment_len = read_half_word_inc(current_ptr);

  /* We don't care about the disk number, the file attributes or the offset */
  *current_ptr += 12;

  *current_ptr += (name_len + extra_len + comment_len);

  ret_code = 0;
exit:
  return ret_code;
}

/*
* Sanity check the directory entries i.e. 
* tokens are in the right place, none of the files are compressed etc.
* 
* returns 0 for success -ENOENT if not
*/
static int check_directory_table(alt_ro_zipfs_dev* dev)
{
  int ret_code = 0;
  alt_u8* current_ptr = (alt_u8*)dev->directory;
  alt_u32 token;

  while(1)
  {
    token = read_word_inc(&current_ptr);

    switch(token)
    {
    case ZIP_DIRECTORY_RECORD:
      {
        ret_code = check_directory_header(&current_ptr);
        if (ret_code)
        {
          goto exit;
        }
        break;
      }
    case ZIP_END_OF_DIRECTORY_RECORD:
      {
        ret_code = 0;
        goto exit;
      }
    default:
      {
        ret_code = -ENOENT;
        goto exit;
      }
    }
  }

exit:
  return ret_code;
}

/*
* Scan through the files until we find the central directory structure
* This function also checks that all the file records are valid i.e.
* tokens are in the right place, none of the files are comrpessed etc.
* 
* returns 0 for success -ENOENT if not
*/
static int find_directory_entry(alt_ro_zipfs_dev* dev)
{
  int ret_code = 0;
  alt_u32 token;
  alt_u8* current_ptr = dev->base;

  while(1)
  {
    token = read_word_inc(&current_ptr);

    switch(token)
    {
    case ZIP_FILE_RECORD:
      {
        ret_code = check_file_header(&current_ptr);
        if(ret_code)
        {
          goto exit;
        }
        break;
      }
    case ZIP_DIRECTORY_RECORD:
      {
        dev->directory = current_ptr - 4;
        goto exit;
      }
    default:
      {
        ret_code = -ENOENT;
        goto exit;
      }
    }
  }
exit:
  return ret_code;
}

/*
* find_file_entry_by_name
*
* Check each entry in the central directory to see if this is the file we want
* we can assume that the file system is coherent because the function 
* alt_ro_zipfs_check_valid checks this before the the filesystem was mounted
*
* returns -ENOENT if fails
*/
static int find_file_entry_by_name( alt_ro_zipfs_dev* dev, alt_fd* fd, 
                                    const alt_u8* name)
{
  int ret_code = -ENOENT;
  alt_u32 token;
  alt_u8* current_ptr = dev->directory;
  alt_u16 name_len, extra_len, comment_len, extra_file_len;
  alt_u32 offset;

  current_ptr = dev->directory;

  while(1)
  {
    token = read_word(current_ptr);

    if(token != ZIP_DIRECTORY_RECORD)
    {
      break;
    }

    offset = read_word(current_ptr + ZIP_DIR_OFFSET);
    name_len = read_half_word(current_ptr + ZIP_DIR_NAME_LEN);
    extra_len = read_half_word(current_ptr + ZIP_DIR_EXTRA_LEN);
    comment_len = read_half_word(current_ptr + ZIP_DIR_COMMENT_LEN);

    if ((strlen((const char *)name) == name_len) && 
    (!strncmp((const char *)(current_ptr+ZIP_DIR_HEADER_SIZE), (const char *)name, name_len)))
    {
      extra_file_len = read_half_word(dev->base + offset + ZIP_FILE_EXTRA_LEN); 
      fd->priv = dev->base + ZIP_FILE_HEADER_SIZE 
                  + offset + extra_file_len + name_len;
      ret_code = 0;
      break;
    }
    current_ptr += ZIP_DIR_HEADER_SIZE + name_len + extra_len + comment_len;
  }

  return ret_code;
}

/*
* find_file_entry
*
* Given a file descriptor look through the central directory to find
* which file this is pointing to
*
* returns -EBADF if fails
*/
static int find_file_entry( alt_ro_zipfs_dev* dev, alt_fd* fd, 
                            alt_u8** start, alt_u32* len)
{
  int ret_code = -EBADF;
  alt_u32 token;
  alt_u8* current_ptr = (alt_u8*)dev->directory;
  alt_u8* end;
  alt_u16 name_len, extra_len, comment_len, extra_file_len;
  alt_u32 offset;

  current_ptr = dev->directory;

  while(1)
  {
    token = read_word(current_ptr);

    if(token != ZIP_DIRECTORY_RECORD)
    {
      break;
    }
    
    *len = read_word(current_ptr + ZIP_DIR_UNCOMPRESSED_LEN);
    offset = read_word(current_ptr + ZIP_DIR_OFFSET);
    name_len = read_half_word(current_ptr + ZIP_DIR_NAME_LEN);
    extra_len = read_half_word(current_ptr + ZIP_DIR_EXTRA_LEN);
    comment_len = read_half_word(current_ptr + ZIP_DIR_COMMENT_LEN);
    current_ptr += ZIP_DIR_HEADER_SIZE + name_len + extra_len + comment_len;

    extra_file_len = read_half_word(dev->base + offset + ZIP_FILE_EXTRA_LEN); 

    *start = dev->base + ZIP_FILE_HEADER_SIZE + offset + extra_file_len + name_len;

    /* The plus 1 is for the End of file condition */
    end = *start + *len;
    if ((fd->priv >= *start ) &&
        (fd->priv <= end))
    {
      ret_code = 0;
      break;
    }
  }

  return ret_code;
}


/*
* alt_ro_zipfs_open
*
* Find the Central dircetory and then find the pointer to this file
* from that.
*
*/
int alt_ro_zipfs_open(alt_fd* fd, const char* name, int flags, int mode)
{
  int ret_code = -EROFS;
  alt_ro_zipfs_dev* dev= (alt_ro_zipfs_dev*)fd->dev;

#ifdef ALT_USE_DIRECT_DRIVERS
  ALT_LINK_ERROR("Error: Read-only ZIP filesystem not supported when direct drivers are used.");
#endif

  if (flags == O_RDONLY )
  {
    if (dev->directory != NULL)
    {
      ret_code = find_file_entry_by_name( dev, fd, 
                                          (const alt_u8*)(name+strlen(dev->fs_dev.name)+1));
    }
  }

  return ret_code;
}

/*
* alt_ro_zipfs_read
*
* Read the file
*/
int alt_ro_zipfs_read(alt_fd* fd, char* ptr, int len)
{
  alt_ro_zipfs_dev* dev= (alt_ro_zipfs_dev*)fd->dev;
  alt_u8 *start, *current;
  alt_u32 file_len;
  int amount_to_copy;
  alt_irq_context context;

  find_file_entry(dev, fd, &start, &file_len);

  /* 
  * To make this code multi threaded we disable interrupts around 
  * the read modify write of the file decscriptor private data
  *
  * We could use a Mutex or a binary semaphore, but those would have 
  * a much bigger code footprint and disable interrupts for as many 
  * instructions anyway
  */
  context = alt_irq_disable_all();
  current = fd->priv;
  amount_to_copy = MIN(len, file_len - (current - start));
  fd->priv += amount_to_copy;
  alt_irq_enable_all(context);

  memcpy(ptr, current, amount_to_copy);
  
  return amount_to_copy;
}

/*
* alt_ro_zipfs_seek
*
* Move around within a file
*
* returns -EROFS for a seek beyond the end of the file
*/
int alt_ro_zipfs_seek(alt_fd* fd, int ptr, int dir)
{
  int ret_code;
  alt_ro_zipfs_dev* dev= (alt_ro_zipfs_dev*)fd->dev;
  alt_u8* start;
  alt_u32 len;

  find_file_entry(dev, fd, &start, &len);

  switch(dir)
  {

  case SEEK_CUR:
    {
      /* Seek from current position */
      if ((fd->priv + ptr) > (start +len))
      {
        ret_code = -EINVAL;
        goto exit;
      }

      fd->priv += ptr;
      break;
    }
  case SEEK_SET:
    {
      /* Seek from the beginning */
      if (ptr > len)
      {
        ret_code = -EINVAL;
        goto exit;
      }

      fd->priv = start + ptr;
      break;
    }
  case SEEK_END:
    {
      if(ptr > 0)
      {
        ret_code = -EINVAL;
        goto exit;
      }

      fd->priv = start + ptr + len;
      break;
    }
  }
  ret_code = (int)(fd->priv - start);

exit:
  return ret_code;
}

/*
* alt_ro_zipfs_fstat
* 
* Return the file status information, the only fields we fill in are
* the size and that this really is a file, not a device
*/
int alt_ro_zipfs_fstat(alt_fd* fd, struct stat* buf)
{
  alt_ro_zipfs_dev* dev= (alt_ro_zipfs_dev*)fd->dev;
  alt_u8* start;
  alt_u32 len;
  int ret_code = 0;

  find_file_entry(dev, fd, &start, &len);
  buf->st_mode = S_IFREG;
  buf->st_size = (off_t)len;

  return ret_code;
}

/*
* alt_ro_zipfs_check_valid
*
* check that the file system is a valid zip file
* if so return 1
*
*/
int alt_ro_zipfs_check_valid(alt_ro_zipfs_dev* dev)
{
  int ret_code = 0;
  if (find_directory_entry(dev) != -ENOENT)
  {
    if (check_directory_table(dev) != -ENOENT)
    {
      ret_code = 1;
    }
  }

  return ret_code;
}
