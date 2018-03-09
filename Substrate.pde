class Substrate {
	PVector location;
	PVector velocity;
	PVector acceleration;
	int diameter;
	float diffCoef;
	int phosphoState;
	int identity;

	Substrate(int d, int i){
		location = new PVector(random(0 + diameter, width - diameter), random(0 + diameter, height - diameter));
		velocity = new PVector(0, 0);
		acceleration = new PVector(0, 0);
		//mass = m;
		diameter = d;
		diffCoef = pow(diameter, -1) * 0.3;
		phosphoState = 0;
		identity = i;
	}

	void display(){
		pushMatrix();
		translate(location.x, location.y);

		if(phosphoState == 1){
			fill(20, 250, 120);	
		} else if(phosphoState == 0){
			fill(125, 125, 125);
		}
		noStroke();

		if(identity == 1){
			ellipse(0, 0, diameter, diameter);
		} else if(identity == 2){
			rect(0, 0, diameter, diameter);
		}
		
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
		velocity.mult(0.99);
	}

	PVector diffusion(){
		PVector diff = new PVector(randomGaussian() * diffCoef, randomGaussian() * diffCoef);
		return diff;
	}

	void checkEdges(){
		if(location.x > width - diameter){
			location.x = width - diameter;
			velocity.x *= -1;
		} else if(location.x < diameter){
			location.x = diameter;
			velocity.x *= -1;
		} else if(location.y > height - diameter){
			location.y = height - diameter;
			velocity.y *= -1;
		} else if(location.y < diameter){
			location.y = diameter;
			velocity.y *= -1;
		}
	}

	void boundReceptor(Receptor r){
		float minDistance = r.diameter/2 + diameter/2;
		PVector distance = PVector.sub(location, r.position);
		float distanceMag = distance.mag();

		if(phosphoState == 0 && distanceMag <= minDistance){
			phosphoState++;
		}
	}
}








