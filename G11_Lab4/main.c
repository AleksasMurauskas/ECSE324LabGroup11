#include <stdio.h> 


#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/VGA.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/audio.h"

void test_char() {
	int x, y;
	char c = 0;

	for (y = 0; y < 59; y++)
		for (x = 0; x <= 79; x++)
			VGA_write_char_ASM(x, y, c++);
	
}

void test_byte() {
	int x, y;
	char c = 0;

	for (y = 0; y < 59; y++)
		for (x = 0; x <= 79; x+=3)
			VGA_write_byte_ASM(x, y, c++);

}

void test_pixel() {
	int x, y;
	unsigned short colour = 0;

	for (y = 0; y < 239; y++)
		for (x = 0; x <= 319; x++)
			VGA_draw_point_ASM(x,y,colour++);

}

void VGA_Test(){
	while(true){
		if(read_PB_data_ASM()!=0){
			if(read_slider_switches_ASM()==0){
				VGA_clear_charbuff_ASM();
			}
			else if(read_slider_switches_ASM()=1){
				VGA_clear_pixelbuff_ASM();
			}
			else if(read_slider_switches_ASM()=2){
				test_char();
			}
			else if(read_slider_switches_ASM()=3){
				test_char();
			}
			else if(read_slider_switches_ASM()=4){
				test_char();
			}
		}
	}
}

void ps2_Test(){
	VGA_clear_charbuff_ASM();
	VGA_clear_pixelbuff_ASM();

	char val;
	int x=0;
	int y=0;
	int[] maximum = {78, 59};

	while(true){
		if(read_PS2_data_ASM(&val)!=0){
			VGA_write_byte_ASM(x,y,val);
			x+=3;
			if(x>maximum[0]){ // Checks if row is completed
				x=0; 
				y++;
				if(y>maximum[1]){
					y=0
					VGA_clear_charbuff_ASM();
				}
			}
		}
	}

}

void audio_Test(){
	int a=0;
	while(true){
		for(a=0;a<240;a++){
			if(write_audio_FIFO_ASM(0x00FFFFFF)!=1){
				a--;
			}
		}
	}
}


int main(){
	VGA_clear_charbuff_ASM();
	VGA_clear_pixelbuff_ASM();

	//VGA_Test();
	//ps2_Test();
	//audio_Test();

	return 0;
}