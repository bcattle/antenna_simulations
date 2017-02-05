float freq, height, length, antenna_gauge, feed_spacing, feed_height, feed_gauge;

float m2ft(float m) {
	return m*3.28;
}

model("dipole") 
{
	element driven;

	// Dipole
	wire(0, -length, height, 0, -feed_spacing / 2, height, antenna_gauge, 21);
	wire(0, feed_spacing / 2, height, 0, length, height, antenna_gauge, 21);
	// Feed line
	wire(0, -feed_spacing / 2, height, 0, -feed_spacing / 2, feed_height, feed_gauge, 21);	
	wire(0, feed_spacing / 2, height, 0, feed_spacing / 2, feed_height, feed_gauge, 21);	
	driven = wire(0, -feed_spacing / 2, feed_height, 0, feed_spacing / 2, feed_height, feed_gauge, 3);

	voltageFeed(driven, 1.0, 0.0);
	
	setFrequency(freq); 
	
	// "average" is 13, 0.005
	ground(13.0, 0.004); 
	useSommerfeldGround( 1 ) ;
}

control() {
	int index;
	freq = 7.15;	
//	freq = 14.15;
//	freq = 29.35;	
	
	height = 145';
	length = 186' / 2;
	antenna_gauge = #14;

	feed_height = 1';
	feed_spacing = 0.3';
	feed_gauge = #16;


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
