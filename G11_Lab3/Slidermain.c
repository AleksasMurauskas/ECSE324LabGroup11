#include <stdio.h>

#include "./drivers/inc/leds.h"
#include "./drivers/inc/slider_switches.h"

int main(){
	while(1){
		/*Simply light up whatever slider is 1*/
		write_LEDs_ASM(read_slider_switches_ASM());
	}
	return 0;
}