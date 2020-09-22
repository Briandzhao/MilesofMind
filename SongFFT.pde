import ddf.minim.analysis.*;
import ddf.minim.*;

static float beatThreshold = 100;
class SongFFT {
	AudioPlayer song;
	ddf.minim.analysis.FFT fft;

	String songName;
	int binCount = 144;

	int fpb;
	int fpqb;
	float bpm;

	float offset = 100;

	boolean beat = false;
	boolean beatAlready = true;
	boolean beatQ = false;

	float currBeat = 0;
	int currFrame = 0;

	float volume = -27;

	float[] raw;
	float[] af;

	float avg,max;
	float temp;
	float power = 2;
	float threshold = .5;
	float amp = .2; // LOWER AMP VALUES -> HIGHER af[] VALUES
	float amp2 = .1;

	SongFFT(String songName, float bpm, float offset, float volume, float power, float threshold, float amp, float amp2) {
		raw = new float[binCount];
		af = new float[binCount];
		this.songName = songName;
		this.bpm = bpm;
		this.offset = offset;
		this.volume = volume;
		this.power = power;
		this.threshold = threshold;
		this.amp = amp;
		this.amp2 = amp2;

		song = mim.loadFile(songName, 1024);
		fft = new FFT(song.bufferSize(), song.sampleRate());

		fpb = (int)(60.0*60/bpm);
		fpqb = (int)((60.0*60/bpm)/4);
	}

	void start(float gain) {
		song.setGain(gain);
		song.play();
		currBeat = 0;
		currFrame = 0;
	}

	void start() {
		start(volume);
	}

	void update() {
		calcBeat();
		calcFFT();
	}

	void calcFFT() {
		fft.forward(song.mix);
		for (int i = 0 ; i < binCount ; i ++) {
			raw[i] = fft.getBand(i);
		}
		avg = 0;
		max = 0;
		for (int i = 0 ; i < af.length ; i ++) {
			temp = 0;
			for (int k = i ; k < af.length ; k += i + 1) temp += raw[k];
			temp /= af.length / (i + 1);
			temp = pow(temp,power);
			avg += temp;
			af[i] = temp;
			if (af[i] > max) max = af[i];
		}
		avg /= af.length;

		for (int i = 0 ; i < af.length ; i ++) {
			if (af[i] < avg*threshold) {
				af[i] /= amp;
			} else {
				af[i] += (af[i] - avg * threshold) / amp2;
			}
			if (af[i] > 100) af[i] = 100 + pow(af[i]-100,.8);
			if (af[i] > 300) af[i] = 300 + pow(af[i]-300,.5);
		}
	}

	void calcBeat() {
		float currMil = (song.position() + offset) % (60000.0/bpm);
		if (!beatAlready && currMil < beatThreshold) {
			beat = true;
			beatAlready = true;
		} else {
			beat = false;
		}
		if (currMil > beatThreshold) {
			beatAlready = false;
		}

		beatQ = beat;
		if (beat) {
			currFrame = 0;
			currBeat += 0.25;
		}
		currFrame ++;
		if (currFrame == fpqb || currFrame == fpqb*2 || currFrame == fpqb*3) {
			currBeat += 0.25;
			beatQ = true;
		}
	}

	void setTime(float newBeat, float time) {
		song.cue((int)time);
		currBeat = newBeat;
		beat = true;
		beatAlready = true;
	}
}