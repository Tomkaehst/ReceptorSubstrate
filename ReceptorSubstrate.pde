Substrate[] sArray = new Substrate[25];
Receptor rec;

void setup() {
	size(600, 600);
	smooth();
	pixelDensity(displayDensity());

	for(int i = 0; i < sArray.length; i++){
		sArray[i] = new Substrate(int(random(2, 5)));
	}

	rec = new Receptor(new PVector(width/2, height/2), 20);
}

void draw() {
	background(255);

	for(int i = 0; i < sArray.length; i++){
		Substrate substrate = sArray[i];
		substrate.display();
	}

	rec.display();
}