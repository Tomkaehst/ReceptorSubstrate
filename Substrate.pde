class Substrate {
	PVector location;
	PVector velocity;
	PVector acceleration;
	int mass;
	float diffCoef;
	int phosphoState;

	Substrate(int m){
		location = new PVector(random(0, width), random(0, height));
		velocity = new PVector(0, 0);
		acceleration = new PVector(0, 0);
		mass = m;
		diffCoef = pow(m, -1) * 0.2;
		phosphoState = 0;
	}

	void display(){
		pushMatrix();
		translate(location.x, location.y);
		fill(120, 50, 175);
		rect(0, 0, mass * 5, mass * 5);
		popMatrix();

		diffuse();
		checkEdges();
	}

	void diffuse(){
		PVector dir = diffusion();
		acceleration.add(dir);
		velocity.add(acceleration);
		location.add(velocity);
		acceleration.mult(0);
		velocity.mult(0.95);
	}

	PVector diffusion(){
		PVector diff = new PVector(randomGaussian() * diffCoef, randomGaussian() * diffCoef);
		return diff;
	}

	void checkEdges(){
		if(location.x > width || location.x < 0){
			velocity.x *= -1;
		}
		if(location.y > height || location.y < 0){
			velocity.y *= -1;
		}
	}

	void bindReceptor(Receptor r){

	}
}








