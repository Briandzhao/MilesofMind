// DIMENSIONS
static float de, dx, dy;
PVector front; // Positive xyz corner of bounding box
PVector back; // Negative xyz corner of bounding box

// CAMERA
Camera cam;

// FFT
Minim mim;
SongFFT main;
float[] defaultAf;

// KEYBOARD
char keyR;
char keyP;
boolean paused = false;

// COLOR
static float colorHMax = 360;
static float colorSMax = 100;
static float colorBMax = 100;
static float colorAMax = 100;

// SPECIAL VALUES
static float PI2 = PI * 2;
static float GR = 1.61803398875;
static float GR2 = 1.0/GR;

// BACKGROUND
IColor backFill;

void setup() {
	size(1300,740,P3D);
	de = (width + height)/2;
	dx = width;
	dy = height;
	front = new PVector(dx,dy,de);
	back = new PVector(-dx,-dy,-de);
	//cam = new Camera(width/2,height*0.5,-de*1.7, 0,0,0);
	cam = new Camera(0,0,0, 0,0,0);
	backGrid = new BackGrid();

	textSize(de/10);
	textAlign(CENTER);
	rectMode(CENTER);
	colorMode(HSB, colorHMax, colorSMax, colorBMax, colorAMax);

	mim = new Minim(this);

	setupSketch();
}

void draw() {
	backFill.update();
	background(backFill.r.x, backFill.g.x, backFill.b.x);
	cam.update();
	cam.render();
	render();
}

void keyPressed() {
	keyP = key;
	// Camera control
	if (key == 'f') {
		if (!cam.lock) {
			cam.lock = true;
			cam.ang.P.set(cam.dang.x, cam.dang.y, cam.dang.z);
		} else {
			cam.lock = false;
		}
		println("Cam lock: " + cam.lock);
	}
	// Pause control
	if (key == ' ') {
		if (paused) {
			loop();
		} else {
			noLoop();
		}
		paused = !paused;
	}
	// Seek to song section
	switch(key) {
		case '0':
		break;
		case '1':
		break;
		case '2':
		break;
	}

	println(key + " " + (int)frameRate + " " + frameCount + " " + cam.z.x);
}

void keyReleased() {
	keyR = key;
	if (key == keyP) keyP = 0;
}

void mousePressed() {
	if (!paused)seekToMouseX();
}

void seekToMouseX() {
	float temp = ((float)mouseX / width) * main.song.length();
	float tempBeat = ((temp+main.offset)/60000.0*main.bpm);
	tempBeat = tempBeat - tempBeat%0.5;
	main.song.cue((int)temp);
	main.currBeat = tempBeat;
}

void stop() {
  mim.stop();
  super.stop();
}