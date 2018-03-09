Substrate[] sArray = new Substrate[50];
Receptor[] rArray = new Receptor[5];

void setup() {
	size(600, 600);
	noSmooth();
	pixelDensity(2);
	frameRate(200);

	for(int i = 0; i < sArray.length; i++){
		sArray[i] = new Substrate(10, 2);
	}

	for(int i = 0; i < rArray.length; i++){
		rArray[i] = new Receptor(new PVector(random(width), random(height)), 60);
	}
}

void draw() {
	background(255);
	fill(125, 125, 125);

	for(Substrate sub : sArray){
		sub.display();

		for(Receptor rec : rArray){
			rec.display();
			sub.boundReceptor(rec);
		}
	}
}