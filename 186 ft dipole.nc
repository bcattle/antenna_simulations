float freq, height, length, antenna_gauge;

float m2ft(float m) {
	return m*3.28;
}

model("dipole") 
{
	element driven;
	
	driven = wire(0, -length, height, 0, length, height, antenna_gauge, 21);

	voltageFeed(driven, 1.0, 0.0);
	
	setFrequency(freq); 
	
	// "average" is 13, 0.005
	ground(13.0, 0.004); 
	useSommerfeldGround( 1 ) ;
}

control() {
	float freqs[6];
	int index;

	freqs[0] = 3.5;
	freqs[1] = 3.7;
	freqs[2] = 4.0;
	freqs[3] = 7.0;
	freqs[4] = 7.15;
	freqs[5] = 7.3;

	
	height = 145';
	length = 186' / 2;
	antenna_gauge = #14;


	index = 0;
	printf("\n\n");
	printf("Dipole, %.2f ft long, %.2f feet above ground\n", m2ft(2*length), m2ft(height));
	repeat (6) {
		freq = freqs[index];
		runModel();		
//		printf("freq = %.2f\tZ: (%.4f +j %.4f)\teff:%.2f\n", 
//			freq, feedpointImpedanceReal(1), feedpointImpedanceImaginary(1), efficiency);
		printf("freq = %.2f\tZ: (%.4f +j %.4f)\n", 
			freq, feedpointImpedanceReal(1), feedpointImpedanceImaginary(1));
		index = index + 1;
	}
}
