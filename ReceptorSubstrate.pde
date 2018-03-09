// This code resembles the first attempt of a simulation of Receptors "phosphorylating" substrates, that randomly walk through the world. The data of the phosphorylation states of the substrates is saved in the data folder of this processing sketch.
// This little program works with three classes: one for the receptor, one for the signaling molecule and one for the inhibitor of the activated signal molecule.
// The signal pathway works like this: 1. Signal molecules diffuse to receptors and are phosphorylated/activated (white); 2. The activated signal can be deactivated/dephosphorylated by the inhibitor and thereby reset to the ground state. 

// Initializing the time and data for writing it to the csv-table.
int time = 0;
int amountPhospho = 0;

//Calling the receptor and substrate object arrays
Signal[] sArray = new Signal[20];
Inhibitor[] iArray = new Inhibitor[10];

//Substrate[] iArray = new Substrate[10]; // substrate phosphorylated by phosphorylated substrate of the sArray
Receptor[] rArray = new Receptor[3];

// Initializing a table object
Table signalTable;

void setup() {
	size(400, 400);
	noSmooth();
	pixelDensity(2);
	frameRate(50);

	//Initializing the substrates and receptors
	for(int i = 0; i < sArray.length; i++){
		sArray[i] = new Signal(12); // Substrate(diameter, identity = 1 or 2), initial location is random, phosphorylation state set to 0!
	}

	for(int i = 0; i < iArray.length; i++){
		iArray[i] = new Inhibitor(20);
	}

	for(int i = 0; i < rArray.length; i++){
		rArray[i] = new Receptor(new PVector(random(0, width), random(height/2, height)), 60); // receptors randomly positioned
	}

	//Configuring the table
	signalTable = new Table();
	signalTable.addColumn("time");
	signalTable.addColumn("[phospho]");
}

void draw() {
	background(20);
	fill(125, 125, 125);

	// Iterating over each element of the substrate array to display the substrates
	for(Signal sub : sArray){
		sub.display();

		// iterating (nested) over each element of the receptor array, display the receptor and check, if the active substrate hit a receptor
		for(Receptor rec : rArray){
			rec.display();
			sub.boundReceptor(rec);
		}
	}

	for(Inhibitor inh : iArray){
		inh.display();
		for(Signal sub : sArray){
			inh.boundReceptor(sub);
			inh.boundSignal(sub);
		}
	}

	// Counting the amount of phosphorylated substrate molecules, if it is phosphorylated and never been counted (indicated by the objects variable counted)
	for(Signal sub : sArray){
		if(sub.phosphoState == 1){
			amountPhospho += sub.phosphoState;
		}
	}

	// Writing the amount of phosphorylated substrates at time t into a table.
	TableRow signalRow = signalTable.addRow();
	signalRow.setInt("time", time);
	signalRow.setInt("[phospho]", amountPhospho);
	saveTable(signalTable, "data/signal.csv");

	time++;
	amountPhospho = 0;

}


