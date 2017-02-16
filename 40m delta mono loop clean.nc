// 40m Delta Mono Loop
// http://www.dj0ip.de/my-favorite-antennas/my-favorite-40m/

float freq, height_agl, height_apex, perimeter, antenna_gauge;

float m2ft(float m) {
	return m*3.28;
}

model("deltamonoloop") 
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

	voltageFeedAtSegment(driven1, 1.0, 0.0, 21);
	
	// "average" is 13, 0.005
	ground(13.0, 0.004); 
	useSommerfeldGround(1);
}

control() {
	float freqs[3], feed_heights[5], lengths[8];
	int index, feed_index, length_index;

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

	height_agl = 2; // 2.0;
	height_apex = 9; // 9.0;
	perimeter = 44.7;

	antenna_gauge = #14;

	setFrequency(freqs[0]); 
	addFrequency(freqs[1]); 
	addFrequency(freqs[2]); 
	runModel();
}
