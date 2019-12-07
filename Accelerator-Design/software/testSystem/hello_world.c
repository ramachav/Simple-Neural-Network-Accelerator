/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>

#include <system.h>

#include <altera_avalon_performance_counter.h>
#include <altera_avalon_dma_regs.h>
#include <sys/alt_cache.h>
#include <sys/alt_dma.h>

#include "MacAcceleratorDriver.h"


int main()
{
	printf("Hello from Nios II!\n");

	unsigned char a[] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
	
	float floatCoeff[NumMacCoeffs];
	for (int i = 0; i < NumMacCoeffs; ++i)
	{
		floatCoeff[i] = 2;
	}

	float floatData[]		= { 2.0, -2.0, 1.5, 4.5, 1.0, 3.2, 2.8, 6.3 };

	alt_dcache_flush( (void*)floatCoeff, (NumMacCoeffs*4) );
	printf("Flush Coeffs\n");
	alt_dcache_flush( (void*)floatData, 32 );
	printf("Flush Data\n");
	// alt_dcache_flush_all();
	printf("Flush Done! \n");

	
	sendCoeffsToMacDma( NumMacCoeffs*sizeof(float), floatCoeff );
	sendPixelsToMacDma( 8*sizeof(float), floatData );
	sendPixelsToMacDma( 8*sizeof(float), floatData );
	sendPixelsToMacDma( 8*sizeof(float), floatData );
	sendPixelsToMacDma( 8*sizeof(float), floatData );

	/*

	alt_dma_txchan macDmaTxChannel;
	macDmaTxChannel = alt_dma_txchan_open ("/dev/dma_0");

 	if (macDmaTxChannel == NULL)
	{
		printf ("Error: failed to open device\n");
		exit (1);
	}
	else
	{
		alt_dma_txchan_reg(macDmaTxChannel);
		if (alt_dma_txchan_send (macDmaTxChannel, floatCoeff, NumMacCoeffs, macDmaTxComplete, NULL) < 0 )
		{
			printf ("Error: failed to post coeff send request\n");
		}
		else
		{
			if (alt_dma_txchan_send (macDmaTxChannel, floatData, 8, macDmaTxComplete, NULL) < 0 )
			{
				printf ("Error: failed to post data send request\n");
			}
			else
			{
				printf("%d\n", macDmaTxStatus);
				// alt_dma_txchan_ioctl(macDmaTxChannel, ALT_DMA_SET_MODE_32, NULL );
				// alt_dma_txchan_ioctl(macDmaTxChannel, ALT_DMA_RX_ONLY_OFF, NULL);
				printf("Waiting ... ");
				// IOWR_ALTERA_AVALON_DMA_CONTROL( DMA_0_BASE, ALTERA_AVALON_DMA_CONTROL_SOFTWARERESET_MSK );
				// IOWR_ALTERA_AVALON_DMA_CONTROL( DMA_0_BASE, ( ALTERA_AVALON_DMA_CONTROL_WCON_MSK | ALTERA_AVALON_DMA_CONTROL_LEEN_MSK | ALTERA_AVALON_DMA_CONTROL_GO_MSK | ALTERA_AVALON_DMA_CONTROL_WORD_MSK ) );
				// while(!macDmaTxStatus);
				printf("%d\n", macDmaTxStatus);
			}
		}
	}
	*/

 	/*
 	 *	alt_dma_txchan tx_chan;
		alt_dma_rxchan rx_chan;
		int rc;
		rx_done = 0;
		float *tx_data = (float *) send_value;
		float *rx_buffer = (float *) receive_value;
		if((tx_chan = alt_dma_txchan_open("/dev/dma_0")) == NULL) {
		printf("Failed to open transmit channel \n");
		exit(1);
		}
		alt_dma_txchan_ioctl(tx_chan, ALT_DMA_SET_MODE_32, NULL);
		alt_dma_txchan_ioctl(tx_chan, ALT_DMA_RX_ONLY_OFF, NULL);
		alt_dma_txchan_ioctl(tx_chan, ALT_DMA_TX_ONLY_ON, rx_buffer);
		if((rc = alt_dma_txchan_send(tx_chan, tx_data, 4, done, NULL)) < 0) {
		printf("Failed to post transmit request. Reason: %d\n", rc);
		exit(1);
		}
		while(!rx_done);
		printf("\nTransfer done!\n"); //Sanity check
		printf("\nValue Received: %f %f %f\n", *(0x80000000 + receive_value), *(receive_value + 1), *(receive_value + 2));
 	 */

	unsigned int count = 16;
	unsigned char* data = a;
	unsigned long b;



	// IOWR_32DIRECT(MAC_ACCELERATOR_BASE_ADDRESS, 0x0100, 0xABCD1234);

	//b = getMACFromAcceleratorDma( count, floatCoeff );
	printf("%d\n", macDmaTxStatus);
	printf("Done!");
	return 0;
}



