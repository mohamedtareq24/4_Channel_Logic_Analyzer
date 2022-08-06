Design and implantation of an FPGA based 4 channel Logic analyzer on the ALTERA Cyclone IV FPGA, integrating ALTERA’s IPs and M9K BRAMs and outputting the analyzed data to a VGA
monitor via a designed VGA interface on the XGA mode
The design contains 3 blocks  that are 
 - VGA interface to interface with a VGA monitor on the resolution 1024 x 768
 - 4 M9K blocks in the data path for acquiring the sampled data and outputting the data on the monitor 
 - ALTERA PLL for genrating the sampling frequnicies 250KHz,1MHz,25MHz,50MHz
 the design can capture up to 32K samples for single channel
