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
	float time;

	Substrate(int d, int i){
		location = new PVector(random(0 + diameter, width - diameter), random(0 + diameter, height/5)); // Substrates can only be created inside the window
		velocity = new PVector(0, 0);
		acceleration = new PVector(0, 0);
		diameter = d;
		diffCoef = pow(diameter, -1)*5;
		phosphoState = 0;
		identity = i;
		time = 0;
	}

	void display(){
		pushMatrix();
		translate(location.x, location.y);

		if(phosphoState == 1 && identity == 2) {
			fill(255, 52, 61);	
		}
		else if(phosphoState == 0 && identity == 2) {
			fill(50);
		} else if(phosphoState == 1 && identity == 1){
			fill(26, 172, 255);
		} else if(phosphoState == 0 && identity == 1){
			fill(40);
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
		PVector dir = new PVector(randomGaussian() * diffCoef, randomGaussian() * diffCoef);
		acceleration.add(dir);
		velocity.add(acceleration);
		location.add(velocity);
		acceleration.mult(0);
		velocity.mult(0.98);
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

	// Function, that inactivates a substrate after a specified amount of frames
	void activityDecay(int eventTime) {
		time++;

		if(time > eventTime) {
			phosphoState = 0;
			time = 0;
		}
	}


	void phosphorylate(Substrate s){
		float minDistance = s.diameter/2 + diameter / 2;
		PVector distance = PVector.sub(location, s.location);
		float distanceMag = distance.mag();
		int contact = 0;

		if(phosphoState == 1 && s.phosphoState == 0 && distanceMag <= minDistance && contact == 0){
			s.phosphoState++;
			contact++;
		} else if(contact == 1 && distanceMag <= minDistance){
			contact = 0;
		}
	}

	void dephosphorylate(Substrate s){
		float minDistance = s.diameter/2 + diameter / 2;
		PVector distance = PVector.sub(location, s.location);
		float distanceMag = distance.mag();
		int contact = 0;

		if(phosphoState == 1 && s.phosphoState == 1 && distanceMag <= minDistance && contact == 0){
			s.phosphoState = 0;
			phosphoState = 0;
			contact = 1;
		} else if(contact == 1 && distanceMag <= minDistance){
			contact = 0;
		}
	}
}


class Signal extends Substrate {

	Signal(int d){
		super(d, 1);
	}
}




class Inhibitor extends Substrate {
	Inhibitor(int diam){
		super(diam, 2);
	}
}





class Receptor extends Substrate {
	Receptor(PVector p, int d){
		super(d, 1);
		location = p.get();
		diameter = d;
		phosphoState = 1;
	}

	void display(){
		checkEdges();
		pushMatrix();
		translate(location.x, location.y);
		fill(200, 200, 150);
		ellipse(0, 0, diameter, diameter);
		popMatrix();
	}
}





