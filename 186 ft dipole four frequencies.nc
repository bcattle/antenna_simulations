float freq0, freq1, freq2, freq3, height, length, antenna_gauge;

float m2ft(float m) {
	return m*3.28;
}

model("dipole") 
{
	element driven;
	
	driven = wire(0, -length, height, 0, length, height, antenna_gauge, 21);

	voltageFeed(driven, 1.0, 0.0);
	
//	setFrequency(freq); 
	
	// "average" is 13, 0.005
	ground(13.0, 0.004); 
	useSommerfeldGround( 1 ) ;
}

control() {
//	float freqs[18];
	int index;

//	freq0 = 7.15;
//	freq1 = 14.15;
//	freq2 = 28.85;
//	freq3 = 52.0;

	freq0 = 14.15;
	freq1 = 18.110;
	freq2 = 21.2;
	freq3 = 24.93;

//	freqs[0] = 3.5;
//	freqs[1] = 3.7;
//	freqs[2] = 4.0;
//	freqs[3] = 7.0;
//	freqs[4] = 7.15;
//	freqs[5] = 7.3;

//	freqs[6] = 14.0;
//	freqs[7] = 14.175;
//	freqs[8] = 14.35;
//	freqs[9] = 21.0;
//	freqs[10] = 21.225;
//	freqs[11] = 21.45;

//	freqs[12] = 28.0;
//	freqs[13] = 28.85;
//	freqs[14] = 29.7;
//	freqs[15] = 50.0;
//	freqs[16] = 52.0;
//	freqs[17] = 54.0;

//	freqs[0] = 21.225;
	
	height = 145';
	length = 186' / 2;
	antenna_gauge = #14;


	index = 0;
	printf("\n\n");
	printf("Dipole, %.2f ft long, %.2f feet above ground\n", m2ft(2*length), m2ft(height));
//	repeat (18) {
//	repeat (1) {
//		freq = freqs[index];

		setFrequency(freq0);
		addFrequency(freq1);
		addFrequency(freq2);
		addFrequency(freq3);

		runModel();		
//		printf("freq = %.2f\tZ: (%.4f +j %.4f)\teff:%.2f\n", 
//			freq, feedpointImpedanceReal(1), feedpointImpedanceImaginary(1), efficiency);
//		printf("freq = %.2f\tZ: (%.4f +j %.4f)\n", 
//			freq, feedpointImpedanceReal(1), feedpointImpedanceImaginary(1));
		index = index + 1;
//	}
}
