// This code resembles the first attempt of a simulation of Receptors "phosphorylating" substrates, that randomly walk through the world. The data of the phosphorylation states of the substrates is saved in the data folder of this processing sketch.
// This little program works with three classes: one for the receptor, one for the signaling molecule and one for the inhibitor of the activated signal molecule.
// Signal Pathway: signal 1 is phosphorylated the receptor, phosphorylated signal 1 phosphorylates signal 2 which is dephosphorylated by the receptor, signal 2 phosphorylates inhibitor 1 which dephosphorylates signal 1 (back to ground state)

// Initializing the time and data for writing it to the csv-table.
int time = 0;
int amountPhospho = 0;

//Calling the receptor and substrate object arrays
Signal[] s1Array = new Signal[700];
Signal[] s2Array = new Signal[30];
Inhibitor[] iArray = new Inhibitor[15];

//Substrate[] iArray = new Substrate[10]; // substrate phosphorylated by phosphorylated substrate of the sArray
Receptor[] rArray = new Receptor[5];

// Initializing a table object
Table signalTable;

void setup() {
	size(800, 800);
	noSmooth();
	frameRate(50);

	//Initializing the substrates and receptors
	for(int i = 0; i < s1Array.length; i++){
		s1Array[i] = new Signal(12); // Substrate(diameter, identity = 1 or 2), initial location is random, phosphorylation state set to 0!
	}

	for(int i = 0; i < s2Array.length; i++){
		s2Array[i] = new Signal(20);
	}

	for(int i = 0; i < iArray.length; i++){
		iArray[i] = new Inhibitor(5);
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
	background(15);
	//clip(0, 0, 0, 0);
	fill(125, 125, 125);

	for(Signal s1 : s1Array) {
		s1.display();

		for(Receptor r : rArray) {
			r.display();
			s1.boundReceptor(r, 1);
		}
	}

	for(Signal s2 : s2Array){
		s2.display();
		for(Signal s1 : s1Array){
			s2.boundReceptor(s1, 1);
		}
		for(Receptor r : rArray){
			r.dephosphorylate(s2);
		}
	}

	for(Inhibitor i1 : iArray) {
		i1.display();
		for(Signal s2 : s2Array) {
			i1.boundReceptor(s2);
		}
		for(Signal s1: s1Array) {
			i1.dephosphorylate(s1);
		}
		for(Receptor r : rArray){
			r.dephosphorylate(i1);
		}
	}

	// Counting the amount of phosphorylated substrate molecules, if it is phosphorylated and never been counted (indicated by the objects variable counted)
	for(Signal s1 : s1Array){
		if(s1.phosphoState == 1){
			amountPhospho += s1.phosphoState;
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
