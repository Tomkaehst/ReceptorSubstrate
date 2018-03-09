class Receptor {

	PVector position;
	int diameter;

	Receptor(PVector pos, int d){
		position = pos.get();
		diameter = d;
	}

	void display(){
		checkEdges();
		pushMatrix();
		translate(position.x, position.y);
		fill(200, 200, 150);
		ellipse(0, 0, diameter, diameter);
		popMatrix();
	}

	void checkEdges(){
		if (position.x > width - diameter){
			position.x = width - diameter;
		}
		else if (position.x < diameter){
			position.x = diameter;
		}
		else if (position.y > height - diameter){
			position.y = height - diameter;
		}
		else if (position.y < diameter){
			position.y = diameter;
		}
	}
}