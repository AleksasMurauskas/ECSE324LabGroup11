#include <stdio.h>

#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/pushbuttons.h"

int main(){
//Questions 1 and 2 


	HEX_flood_ASM(HEX1|HEX2|HEX3|HEX4|HEX5);
	HEX_clear_ASM(HEX4);

	while(1){
		
		int switches_On = read_slider_switches_ASM(); 

		if(0x200 & switches_On){
			HEX_clear_ASM(HEX0|HEX1|HEX2|HEX3|HEX4|HEX5);
		}
		else{
			char switcher = 0xF & switches_On;
			int push = 0xF &read_PB_data_ASM();
			HEX_write_ASM(push,switcher);
		}
	}
	return 0;
}
