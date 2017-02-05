float freq, height, length, foldback_height, foldback_length, antenna_gauge;

float m2ft(float m) {
	return m*3.28;
}

float deg2rad(float deg) {
	return deg/180*pi;
}

model("dipole") 
{
	element driven;
	float foldback_x, foldback_y;

	height = 145';
	length = 186' / 2;
	foldback_length = 75';
	foldback_height = 75';
	antenna_gauge = #14;

	driven = wire(0, -length, height, 0, length, height, antenna_gauge, 21);
	// Foldback wire
	foldback_x = foldback_length * cos(deg2rad(40));
	foldback_y = foldback_length * sin(deg2rad(40));
	wire(0, -length, height, foldback_x, foldback_y, foldback_height, antenna_gauge, 21);

	voltageFeed(driven, 1.0, 0.0);
	
	setFrequency(freq); 
	
	// "average" is 13, 0.005
	ground(13.0, 0.004); 
	useSommerfeldGround( 1 ) ;
}

control() {
	// freq = 28.85;
	freq = 7.5;
	runModel();
}
