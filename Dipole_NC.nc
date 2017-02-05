model("dipole") 
{
	float height, length, antenna_gauge;
	element driven;
	
	height = 40';
	length = 5.0;
	antenna_gauge = 14#;

	driven = wire(0, -length, height, 0, length, height, antenna_gauge, 21);
	voltageFeed(driven, 1.0, 0.0);
	
	setFrequency( 13.8 ) ; 
	addFrequency( 14.070 ) ; 
	addFrequency( 14.180 ) ; 
	addFrequency( 14.330 ) ; 
	
	averageGround() ; 
	useSommerfeldGround( 1 ) ;
}

control() {
	runModel();
}
