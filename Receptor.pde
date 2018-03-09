class Receptor {

	PVector position;
	int diameter;

	Receptor(PVector pos, int d){
		position = pos.get();
		diameter = d;
	}

	void display(){
		pushMatrix();
		translate(position.x, position.y);
		fill(200, 200, 150);
		ellipse(0, 0, diameter, diameter);
		popMatrix();
	}

	void boundSubstrate(Substrate s){
		
	}
}