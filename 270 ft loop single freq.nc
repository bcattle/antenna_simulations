float freq, freq0, freq1, freq2, freq3, height, length, antenna_gauge;

float m2ft(float m) {
	return m*3.28;
}

float deg2rad(float deg) {
	return deg*pi/180;
}

model("dipole") 
{
	element driven;
	float theta, hyp, corner_x, corner_y;

	theta = deg2rad(45);
	hyp = 100';
	corner_x = hyp * cos(theta);
	corner_y = hyp * sin(theta); 
	
	//					\/ height
	driven = wire(0, 0, 140, 0, 95, 140, antenna_gauge, 21);
	wire(0, 95, 140, corner_x, corner_y, 75, antenna_gauge, 21);
	wire(corner_x, corner_y, 75, 0, 0, 140, antenna_gauge, 21);

	voltageFeedAtSegment(driven, 1.0, 0.0, 1);
	
	setFrequency(freq); 
	
	// "average" is 13, 0.005
	ground(13.0, 0.004); 
	useSommerfeldGround( 1 ) ;
}

control() {
	int index;
	freq = 52;	
//	freq = 14.15;
//	freq = 29.35;	
	
	height = 145';
	length = 156' / 2;
	antenna_gauge = #14;


	index = 0;
	printf("\n\n");
	printf("Dipole, %.2f ft long, %.2f feet above ground\n", m2ft(2*length), m2ft(height));
	// repeat (18) {
//	repeat (1) {
		// freq = freqs[index];

		// setFrequency(freq0);
		// addFrequency(freq1);
		// addFrequency(freq2);
		// addFrequency(freq3);

		runModel();		
//		printf("freq = %.2f\tZ: (%.4f +j %.4f)\teff:%.2f\n", 
//			freq, feedpointImpedanceReal(1), feedpointImpedanceImaginary(1), efficiency);
		printf("freq = %.2f\tZ: (%.4f +j %.4f)\n", 
			freq, feedpointImpedanceReal(1), feedpointImpedanceImaginary(1));
		index = index + 1;
	// }
}
