Design and implantation of an FPGA based 4 channel Logic analyzer on the ALTERA Cyclone IV EP4CE FPGA, integrating ALTERA’s IPs and M9K BRAMs and outputting the analyzed data to a VGA
![image](https://user-images.githubusercontent.com/90535558/203135718-b510fb1c-3a33-413d-a978-f83fcdbbdb74.png)
![image](https://user-images.githubusercontent.com/90535558/203135761-aceb8854-42a1-45e0-a22b-fab35c93e2aa.png)

![image](https://user-images.githubusercontent.com/90535558/183300181-34f18d92-01a3-44e1-b301-abb639dbbd16.png)

monitor via a designed VGA interface on the XGA mode
The design contains 3 blocks that are 
 - VGA interface to interface with a VGA monitor on the resolution 1024 x 768
 - 4 M9K blocks in the data path for acquiring the sampled data and outputting the data on the monitor 
 - ALTERA PLL for generating the sampling frequencies 250KHz,1MHz,25MHz,50MHz,the design can captures up to 32K samples for single channel
 ![image](https://user-images.githubusercontent.com/90535558/183296629-6293befa-b53e-4828-8a09-deafad8da8e1.png)

you can use the .sof file to program your FPGA with intel FPGA programmer tool
--------------------------------------------------------------------------------------------------
The design is seprated into 3 folder Data_Path , Logic_analyzler_ctrl , VGA_Interface, 
containig the following files :

in the VGA _Interface folder :
- H_SYNC : for generating the horizontal sync pulse of the VGA interface
- V_SYNC : for generating the vertical sync pulse of the VGA interface 
- dispaly_FSM : this module reads the sampled data from the memory and controls the Green and blue pins of the interface 
- VGA_interface wraps the previous files and adds a controller for the R pin
![image](https://user-images.githubusercontent.com/90535558/183296203-020f8a83-7a2d-4029-9211-a507683aa289.png)

--------------------------------------------------------------------------------------------------
in the Data_path folder:
- single_port_ram : contains 4 M9K blocks that writes the sampled data either sequentially or concurrently depending on the number of operating channels.
- write_organzier : controls the writing of the  4 M9K  blocks depending on the number of channels 
- read_organzier : controls the reading of the sampled data from the 4 M9K blocks 
- edge_det : edge detector for rising and falling edges works as a trigger, channel 1 is the one triggering the whole system it should always be used  for the triggering signal 
- RA_CTRL: controls zooming and offset of the display
- glitch_free_clock_mux : used to multiplex  the sampling clock and the main 65 MHz clock as the memory is written with sampling clock and read with sampling clock
![image](https://user-images.githubusercontent.com/90535558/183295985-6cddfa79-dde1-4ead-af25-9ca54d2ae94c.png)
use the ALTERA PLL IP for genrating diffrent sampling frequnicies and multiplex them using a regualar multiplixer no problem 
![image](https://user-images.githubusercontent.com/90535558/183296341-b685d9fc-839f-40db-b07d-caf49794f49a.png)
-----------------------------------------------------------------------------------------------
in the logic_analyzer_ctrl folder:
- Debounce_filter : used to debounce the evalution board switches 
- zoom_ctrl, offset_Ctrl and smpl_clk_control used to control dispaly offset, zooming and choosing the sample clock 
------------------------------------------------------------------------------------------------
Pin assigmnets:
---------------------------------------------------------------------------------------------
![image](https://user-images.githubusercontent.com/90535558/183298775-c73a999a-8986-47b0-bf4c-fce4b4ffe49d.png)

the design needs 6 switches for 1 for channel mode (mode), 2 for zoom,  2 for offset and  1 for sample clock select  I only had 5 
also you will need to use a jumper wire for reset and start pins.
- sample_clock_sel switch controls the LEDs you have 4 sampling frequnices indicated by the  4 LEDs
- reset pin is active high make sure it's grounded when not in use 
- datain [3:0] are the data input pins of every channel data[0] is the triggring channel that triggers the whole system
- start pin is used to start sampling if the pin is high level if not datain[0] data won't trigger the system 
![image](https://user-images.githubusercontent.com/90535558/183300027-8856b9b8-05ef-430f-8fa2-bc7e882ccaa6.png)
---------------------------------------------------------------------------------------------------------------------------------------------------------

