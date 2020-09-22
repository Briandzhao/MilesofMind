int toBeat(float num) {
	return (int)(num*main.fpb);
}

boolean beatInRange(float minBeat, float maxBeat) {
	return main.currBeat >= minBeat && main.currBeat < maxBeat;
}

boolean beatE(float beat) {
	return main.beatQ && main.currBeat == beat;
}

void pitches(float x, float y, float[] af) {
	push();
	fill(255);
	for (int i = 0 ; i < af.length ; i ++) {
		rect(x + (float)i/af.length*de*2-de,y, de*2/af.length,af[i]*de/af.length);
	}
	pop();
}

void pitches(float[] af) {
	pitches(0,0,af);
}

void watermark() {
	push();
	fill(0);
	text("@cube.animations", 0, sin(frameCount*.01)*de);
	pop();
}

float randomS(float minR, float maxR, float seg) {
	return random(minR/seg, maxR/seg)*seg;
}

int randomI(int[] list) {
	return list[(int)random(list.length)];
}

float randomR(float minR, float maxR) {
	if (random(1) < 0.5) {
		return random(-maxR,-minR);
	} else {
		return random(minR,maxR);
	}
}

float randomR(float r) {
	if (random(1) < .5) {
		return r;
	} else {
		return -r;
	}
}

int randomD() {
	if (random(1) > 0.5) {
		return 1;
	}
	return -1;
}