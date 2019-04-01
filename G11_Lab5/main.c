#include "./drivers/inc/vga.h"
#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/LEDs.h"
#include "./drivers/inc/audio.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/wavetable.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/slider_switches.h"




	float freq[] = {130.813, 146.832, 164.814, 174.614, 195.998, 220.000, 246.942, 261.626};
	//8 Keys   
	char keys[8] ={}; 


	double produce_simple_sample(float freq, int time){
		int index = ((int) freq *t) %48000;
		double sample = sine[index];
		return sample;
 	}


	double produce_sample(float freq, int time){
		double sample;
		int truncate = ((int) freq *t);
		double frac = (freq*t) - truncate;
		sample = linear_interpolate(freq, index);
		return sample;
	}

	double linear_interpolate(float freq, int index, frac){
		double signal = ((1- frac)* sine[index]) + ((1+frac)* sine[index]);
		return signal 
	}

	



	int main() {


		while(1) {
			//	MAKE PROJECT!
		}



	return 0;
	}
