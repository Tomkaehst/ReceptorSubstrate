// Definition of the substrate class
// A substrate is a molecule capbale of translocation according to a random walk. It has a certain diameter, and identity. The diffusion coefficient is calculated as the inverse of the substrates diameter and is decisive of its mean displacement over time. The identity indicates if the created substrate is of group 1 or 2. The phosphorylation is initialized to 0 and is changed to 1, if a substrate molecule collides with a receptor molecule, which are randomly spawned in the world. 
// Added later: Molecules of identity 2 are phosphorylated by phosphorylated molecules of identity 1!

class Substrate {
	PVector location;
	PVector velocity;
	PVector acceleration;
	int diameter;
	float diffCoef;
	int phosphoState;
	int identity;

	Substrate(int d, int i){
		location = new PVector(random(0 + diameter, width - diameter), random(0 + diameter, height - diameter)); // Substrates can only be created inside the window
		velocity = new PVector(0, 0);
		acceleration = new PVector(0, 0);
		diameter = d;
		diffCoef = pow(diameter, -1)*5;
		phosphoState = 0;
		identity = i;
	}

	void display(){
		pushMatrix();
		translate(location.x, location.y);

		if(phosphoState == 1) {
			fill(20, 250, 120);	
		}
		else if(phosphoState == 0) {
			fill(125, 125, 125);
		}


		noStroke();
		if(identity == 1){ 
			ellipse(0, 0, diameter, diameter);
		}
		else if(identity == 2) {
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

	// Checks if the boundaries of a receptor objects overlap with the substrate. If it does it's phosphorylated (but only once!).
	void boundReceptor(Receptor r){
		float minDistance = r.diameter/2 + diameter/2;
		PVector distance = PVector.sub(location, r.position);
		float distanceMag = distance.mag();

		if(phosphoState == 0 && distanceMag <= minDistance){
			phosphoState++;
		}
	}
}








