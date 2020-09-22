float defaultMass = .5;
float defaultVMult = .1;
float fillMass = .1;
float fillVMult = .1;

float tRate = 0;
BackGrid backGrid;

void render() {
	points.update();
	main.update();
	tRate += main.avg*.0002 + .015;
	sequence();

	strokeWeight(1);
	stroke(360);
	root2.update();
	branch2.update();
	roots.update();
	branches.update();

	dust.update();
	root2.render();
	branch2.render();
	roots.render();
	branches.render();
	stroke(180+main.avg*5);
	dust.render();
	backGrid.render();

	if (main.beat) println(main.currBeat + ", " + main.song.position() + " " + (int)frameRate);
}

void setupSketch() {
	main = new SongFFT("../Music/milesofmind.mp3", 125,
		-50, // Offset
		-4, // Volume
		2, // Power
		2, // Threshold
		.09, // Amp
		.03 // Amp2
	);
	main.start();
	defaultAf = main.af;
	backFill = new IColor(0,0,0,100);
	setupEvents();

	//main.setTime(47.0, 22616);
	//main.setTime(78.0, 37500);
	//main.setTime(141.0, 67755);
	//main.setTime(203.0, 97500);
	//main.setTime(238.0, 114311);
	//main.setTime(302.0, 145031);
	//main.setTime(334.0, 160380);
	//main.setTime(398.0, 191100);
	//main.setTime(462.0, 221820);
}

/*

More piano chords

Map drop B at 400-464

Map outro at 464-500

*/