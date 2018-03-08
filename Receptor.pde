class Receptor {

	PVector position;
	int radius;

	Receptor(PVector pos, int r){
		position = pos.get();
		radius = r;
	}

	void display(){
		pushMatrix();
		translate(position.x, position.y);
		fill(200, 200, 150);
		ellipse(0, 0, radius, radius);
		popMatrix();
	}

	void boundSubstrate(Substrate s){
		
	}
}