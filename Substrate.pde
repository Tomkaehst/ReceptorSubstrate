class Substrate {
	PVector location;
	PVector velocity;
	PVector acceleration;
	int mass;
	float diffCoef;
	int phosphoState;

	Substrate(int m){
		location = new PVector(random(width), random(height));
	}

	void display(){
		pushMatrix();
		translate(location.x, location.y);
		fill(175, 175, 175);
		rect(0, 0, mass * 5, mass * 5);
		popMatrix();
	}

}