/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2003 Altera Corporation, San Jose, California, USA.           *
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

#ifndef __ALTERA_RO_ZIPFS_H__
#define __ALTERA_RO_ZIPFS_H__

#include <stddef.h>
#include "sys/alt_dev.h"
#include "sys/alt_llist.h"

typedef struct alt_ro_zipfs alt_ro_zipfs_dev;

extern int alt_ro_zipfs_open(alt_fd* fd, const char* name, int flags, int mode);
extern int alt_ro_zipfs_close(alt_fd* fd);
extern int alt_ro_zipfs_read(alt_fd* fd, char* ptr, int len);
extern int alt_ro_zipfs_seek(alt_fd* fd, int ptr, int dir);
extern int alt_ro_zipfs_fstat(alt_fd* fd, struct stat* buf);
extern int alt_ro_zipfs_check_valid(alt_ro_zipfs_dev* dev);

struct alt_ro_zipfs
{
  alt_dev  fs_dev;
  alt_u8* base; /* Base address of the flash file system in ROM */
  alt_u8* directory; /* Location of the directory in ROM */
};


#define ALTERA_RO_ZIPFS_INSTANCE(name, dev) static alt_ro_zipfs_dev dev = \
{                                                                         \
  {                                                                       \
    ALT_LLIST_ENTRY,                                                      \
    name##_NAME,                                                          \
    alt_ro_zipfs_open,                                                    \
    NULL, /* close */                                                     \
    alt_ro_zipfs_read,                                                    \
    NULL, /* write */                                                     \
    alt_ro_zipfs_seek,                                                    \
    alt_ro_zipfs_fstat,                                                   \
    NULL, /* ioctl */                                                     \
  },                                                                      \
 (void*)(name##_BASE + name##_OFFSET),                                             \
 (void*)0,                                                                       \
}    


/*
* Mount the filesystem,
* but only if it's valid
*/
#define ALTERA_RO_ZIPFS_INIT(name, dev) \
if (alt_ro_zipfs_check_valid(&dev))\
  alt_fs_reg (&dev.fs_dev)



#endif /* __ALT_AVALON_RO_ZIPFS__ */

