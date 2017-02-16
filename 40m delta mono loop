// 40m Delta Mono Loop
// http://www.dj0ip.de/my-favorite-antennas/my-favorite-40m/

float freq, height_agl, height_apex, perimeter, antenna_gauge;

float m2ft(float m) {
	return m*3.28;
}

model("deltamonoloop40m") 
{
	float a, b, cc, x, y, alpha;
	element driven1;
	
	b = height_apex;
	a = ((perimeter * perimeter) - (4 * b * b)) / (4 * perimeter);
	cc = sqrt(a * a + b * b);

	alpha = atan(b / a);
	x = cos(alpha) * (cc - 10.3);
	y = sin(alpha) * (cc - 10.3);

	// Base leg
	wire(0, 0, height_agl, 0, 2*a, height_agl, antenna_gauge, 21);
	// Unfed hypoteneuse
	wire(0, 2*a, height_agl, 0, a, height_agl + height_apex, antenna_gauge, 21);
	// Fed hypoteneuse upper
	driven1 = wire(0, a, height_agl + height_apex, 0, x, height_agl + y, antenna_gauge, 21);
	// Fed hypoteneuse lower
	wire(0, x, height_agl + y, 0, 0, height_agl, antenna_gauge, 21);

	voltageFeed(driven1, 1.0, 0.0);
	
	// "average" is 13, 0.005
	ground(13.0, 0.004); 
	useSommerfeldGround(1);
}

control() {
	float freqs[3], feed_heights[5], lengths[8];
	int index, feed_index, length_index;
	float Z_real, Z_complex, min_real, max_real, max_complex, min_complex,
		min_real_freq, max_real_freq, max_complex_freq, min_complex_freq;

	freqs[0] = 7.0;
	freqs[1] = 7.15;
	freqs[2] = 7.3;
	
//	lengths[0] = 186' / 2;
//	lengths[1] = 176' / 2;
//	lengths[2] = 166' / 2;
//	lengths[3] = 156' / 2;
//	lengths[4] = 146' / 2;

	// lengths[0] = 176' / 2;
	// lengths[1] = 171' / 2;
	// lengths[2] = 166' / 2;
	// lengths[3] = 161' / 2;
	// lengths[4] = 156' / 2;
	// lengths[5] = 151' / 2;
	// lengths[6] = 146' / 2;
	// lengths[7] = 141' / 2;

	// feed_heights[0] = 1';
	// feed_heights[1] = 5';
	// feed_heights[2] = 10';
	// feed_heights[3] = 15';
	// feed_heights[4] = 20';

	height_agl = 2.0;
	height_apex = 9.0;
	perimeter = 42.2;

	antenna_gauge = #14;

	setFrequency(freq[0]); 
	runModel();

// 	// length_index = 0;
// 	// feed_index = 0;
// 	repeat (8) {
// 		length = lengths[length_index];
// 		length_index = length_index + 1;
// 		// feed_height = feed_heights[feed_index];
// 		// feed_index = feed_index + 1;		
// 		max_real = 0;
// 		max_complex = 0;
// 		min_real = 100000;
// 		min_complex = 100000;

// 		index = 0;
// 		printf("\n\n");
// 		printf("Dipole, %.2f ft long, %.2f feet above ground, feed height %.2f feet\n", m2ft(2*length), m2ft(height), m2ft(feed_height));
// 		// index = 19;
// 		// repeat (3) {		
// 		repeat (27) {
// 			freq = freqs[index];
// 			// freq1 = freqs[index + 1];
// 			// freq2 = freqs[index + 2];

// 			setFrequency(freq); 
// 			// addFrequency(freq1); 
// 			//addFrequency(freq2); 

// 			runModel();	
// 			Z_real = feedpointImpedanceReal(1);
// 			Z_complex = feedpointImpedanceImaginary(1);

// 			if (Z_real < min_real) {
// 				min_real = Z_real;
// 				min_real_freq = freq;
// 			}
// 			if (Z_real > max_real) {
// 				max_real = Z_real;
// 				max_real_freq = freq;
// 			}
// 			if (Z_complex > max_complex) {
// 				max_complex = Z_complex;
// 				max_complex_freq = freq;
// 			}
// 			if (Z_complex < min_complex) {
// 				min_complex = Z_complex;
// 				min_complex_freq = freq;
// 			}

// //			printf("freq = %.2f\tZ: (%.4f +j %.4f)\tgain max: %.2f avg %.2f\n", 
// //				freq, feedpointImpedanceReal(1), feedpointImpedanceImaginary(1),
// //				maxGain, averageGain);
// 			index = index + 1;
// 		}
// 		printf("\nMin real impedance: %.2f at %.2f MHz", min_real, min_real_freq);		
// 		printf("\nMax real impedance: %.2f at %.2f MHz", max_real, max_real_freq);
// 		printf("\nMax complex impedance: %.2f at %.2f MHz", max_complex, max_complex_freq);
// 		printf("\nMin complex impedance: %.2f at %.2f MHz", min_complex, max_complex_freq);
// 		printf("\nScore: %.2f", max_real + max_complex - min_complex);
// 		printf("\n");
	// }
}
