class Substrate {
	PVector location;
	PVector velocity;
	PVector acceleration;
	int mass;
	float diffCoef;
	int phosphoState;

	Substrate(int m){
		location = new PVector(random(0 + 5*mass, width - 5*mass), random(0 + 5*mass, height-5*mass));
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
		if(location.x > width - (5*mass) || location.x < 0 + (5*mass)){
			velocity.x *= -1;
		}
		if(location.y > height - (5*mass) || location.y < 0 + (5*mass)){
			velocity.y *= -1;
		}
	}
}








