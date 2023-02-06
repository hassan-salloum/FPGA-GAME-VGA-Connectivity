# FPGA Spartan 3A (Shooting Game)

This project will guide step by step to build your first FPGA game:

 - First this is the FPGA board i used:                                                                               
 https://numato.com/product/elbert-v2-spartan-3a-fpga-development-board

 - Second we need to install on our PC the USB driver for the FPGA:                                                           
 https://productdata.numato.com/assets/downloads/common/numato_lab_usb_cdc_driver.zip

 - Third we need to install the Xilinx program which in my case (Xilinx\14.7 ISE design Suite):                                         
 https://www.xilinx.com/member/forms/download/xef.html?filename=Xilinx_ISE_S6_Win10_14.7_ISE_VMs_0206_1.zip

 - Then, we need to install the ElbertV2Config.exe:                                                           
 https://productdata.numato.com/assets/downloads/fpga/elbertv2/ElbertV2Config.exe                                                         

 - I recommended you to get more information about the Elbert V2 board and about the ISE  design suite to initialize your first project directory.                                                                    
 *https://docs.numato.com/doc/elbert-v2-spartan-3a-fpga-development-board/*


**A- VGA functionality:**

![First image it will show you how VGA controller work.](https://github.com/hassan-salloum/FPGA_VGA/blob/master/Documentation/VGACONTROLLER.png)

![Second image it will show you how Horizontal and vertical syncronization work, and how i can use it to draw an image in the 
VGA_sync module.](https://github.com/hassan-salloum/FPGA_VGA/blob/master/Documentation/HVSYNC.png)


**B- The main code:**

Code have 4 initial module:

        Topmodule: responsible of the declaration of the VGA system (input and output).
        U1 - IN_CLOCK_OUT: Take a 12 MHz from the Topmodule and generate a 25 MHz clock as output.
        U2 - counter: this counter use 25 MHz as input clock and his output it will be used for the synchronization time of VGA_sync and Topmodule modules.  
        U3 - VGA_sync: this module responsible of the vertical and horizontal synchronization and for the video output.


    
