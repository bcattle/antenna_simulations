float freq, height, length, antenna_gauge, feed_spacing, feed_height, feed_gauge,
	freq1, freq2;

float m2ft(float m) {
	return m*3.28;
}

model("dipole") 
{
	element driven1, driven2;
	
	// Dipole 1
	wire(0, -length, height, 0, -feed_spacing / 2, height, antenna_gauge, 21);
	wire(0, length, height, 0, feed_spacing / 2, height, antenna_gauge, 21);
	// driven1 = wire(0, -length, height, 0, length, height, antenna_gauge, 21);
	// Dipole 2
	// driven2 = wire(0, -length, height - 30', 0, length, height - 30', antenna_gauge, 21);
	// Feed line
	wire(0, -feed_spacing / 2, height, 0, -feed_spacing / 2, feed_height, feed_gauge, 21);	
	wire(0, feed_spacing / 2, height, 0, feed_spacing / 2, feed_height, feed_gauge, 21);	
	driven1 = wire(0, -feed_spacing / 2, feed_height, 0, feed_spacing / 2, feed_height, feed_gauge, 3);

	voltageFeed(driven1, 1.0, 0.0);
	// voltageFeed(driven2, 1.0, 0.0);	
	
	// "average" is 13, 0.005
	ground(13.0, 0.004); 
	useSommerfeldGround(1);
}

control() {
	float freqs[27], feed_heights[5], lengths[8];
	int index, feed_index, length_index;
	float Z_real, Z_complex, min_real, max_real, max_complex, min_complex,
		min_real_freq, max_real_freq, max_complex_freq, min_complex_freq;

	freqs[0] = 1.8;
	freqs[1] = 1.9;
	freqs[2] = 2.0;
	freqs[3] = 3.5;
	freqs[4] = 3.7;
	freqs[5] = 4.0;
	freqs[6] = 7.0;
	freqs[7] = 7.15;
	freqs[8] = 7.3;
	freqs[9] = 10.1;
	freqs[10] = 10.15;

	freqs[11] = 14.0;
	freqs[12] = 14.175;
	freqs[13] = 14.35;
	freqs[14] = 18.068;
	freqs[15] = 18.168;
	freqs[16] = 21.0;
	freqs[17] = 21.225;
	freqs[18] = 21.45;
	freqs[19] = 24.89;
	freqs[20] = 24.99;

	freqs[21] = 28.0;
	freqs[22] = 28.85;
	freqs[23] = 29.7;
	freqs[24] = 50.0;
	freqs[25] = 52.0;
	freqs[26] = 54.0;

//	freqs[0] = 21.225;
	
//	lengths[0] = 186' / 2;
//	lengths[1] = 176' / 2;
//	lengths[2] = 166' / 2;
//	lengths[3] = 156' / 2;
//	lengths[4] = 146' / 2;

	lengths[0] = 176' / 2;
	lengths[1] = 171' / 2;
	lengths[2] = 166' / 2;
	lengths[3] = 161' / 2;
	lengths[4] = 156' / 2;
	lengths[5] = 151' / 2;
	lengths[6] = 146' / 2;
	lengths[7] = 141' / 2;

	// feed_heights[0] = 1';
	// feed_heights[1] = 5';
	// feed_heights[2] = 10';
	// feed_heights[3] = 15';
	// feed_heights[4] = 20';

	height = 145'; 
	length = 161' / 2;
	antenna_gauge = #14;
	feed_spacing = .3';
	feed_height = 1';
	feed_gauge = #16;

	length_index = 0;
	// feed_index = 0;
	repeat (8) {
		length = lengths[length_index];
		length_index = length_index + 1;
		// feed_height = feed_heights[feed_index];
		// feed_index = feed_index + 1;		
		max_real = 0;
		max_complex = 0;
		min_real = 100000;
		min_complex = 100000;

		index = 0;
		printf("\n\n");
		printf("Dipole, %.2f ft long, %.2f feet above ground, feed height %.2f feet\n", m2ft(2*length), m2ft(height), m2ft(feed_height));
		// index = 19;
		// repeat (3) {		
		repeat (27) {
			freq = freqs[index];
			// freq1 = freqs[index + 1];
			// freq2 = freqs[index + 2];

			setFrequency(freq); 
			// addFrequency(freq1); 
			//addFrequency(freq2); 

			runModel();	
			Z_real = feedpointImpedanceReal(1);
			Z_complex = feedpointImpedanceImaginary(1);

			if (Z_real < min_real) {
				min_real = Z_real;
				min_real_freq = freq;
			}
			if (Z_real > max_real) {
				max_real = Z_real;
				max_real_freq = freq;
			}
			if (Z_complex > max_complex) {
				max_complex = Z_complex;
				max_complex_freq = freq;
			}
			if (Z_complex < min_complex) {
				min_complex = Z_complex;
				min_complex_freq = freq;
			}

//			printf("freq = %.2f\tZ: (%.4f +j %.4f)\tgain max: %.2f avg %.2f\n", 
//				freq, feedpointImpedanceReal(1), feedpointImpedanceImaginary(1),
//				maxGain, averageGain);
			index = index + 1;
		}
		printf("\nMin real impedance: %.2f at %.2f MHz", min_real, min_real_freq);		
		printf("\nMax real impedance: %.2f at %.2f MHz", max_real, max_real_freq);
		printf("\nMax complex impedance: %.2f at %.2f MHz", max_complex, max_complex_freq);
		printf("\nMin complex impedance: %.2f at %.2f MHz", min_complex, max_complex_freq);
		printf("\nScore: %.2f", max_real + max_complex - min_complex);
		printf("\n");
	}
}
