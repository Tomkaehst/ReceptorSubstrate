// This code resembles the first attempt of a simulation of Receptors "phosphorylating" substrates, that randomly walk through the world. The data of the phosphorylation states of the substrates is saved in the data folder of this processing sketch.
// This little program works with two classes, one for the receptor and one for the substrate. 

// Initializing the time for writing it to the csv-table.
float time = 0;

//Calling the receptor and substrate object arrays
Substrate[] sArray = new Substrate[50];
Receptor[] rArray = new Receptor[5];

void setup() {
	size(600, 800);
	noSmooth();
	pixelDensity(2);
	frameRate(60);

	//Initializing the substrates and receptors
	for(int i = 0; i < sArray.length; i++){
		sArray[i] = new Substrate(10, 1); // Substrate(diameter, identity = 1 or 2), initial location is random, phosphorylation state set to 0!
	}

	for(int i = 0; i < rArray.length; i++){
		rArray[i] = new Receptor(new PVector(random(width), random(height)), 60); // receptors randomly positioned
	}
}

void draw() {
	background(255);
	fill(125, 125, 125);

	// Iterating over each element of the substrate array to display the substrates
	for(Substrate sub : sArray){
		sub.display();

		// iterating (nested) over each element of the receptor array, display the receptor and check, if the active substrate hit a receptor
		for(Receptor rec : rArray){
			rec.display();
			sub.boundReceptor(rec);
		}
	}
}

// Function, that counts the phosphorylated substrates over time by taking in the array holding the substrate objects and the time. The output is a Vector with the respective time and amount of phosphorylated substrates
void countPhospho(Substrate s, float time){
	
}


