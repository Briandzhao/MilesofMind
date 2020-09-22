class IColor {
	SpringValue r;
	SpringValue g;
	SpringValue b;
	SpringValue a;
	float rm;
	float gm;
	float bm;
	float am;
	int rc;
	int gc;
	int bc;
	int ac;
	int index;
	float af[] = defaultAf;

	IColor(float rc, float gc, float bc, float ac, float rm, float gm, float bm, float am, float index) {
		this.r = new SpringValue(rc, fillVMult, fillMass);
		this.g = new SpringValue(gc, fillVMult, fillMass);
		this.b = new SpringValue(bc, fillVMult, fillMass);
		this.a = new SpringValue(ac, fillVMult, fillMass);
		this.rm = rm; this.gm = gm; this.bm = bm; this.am = am;
		this.rc = (int)rc; this.gc = (int)gc; this.bc = (int)bc; this.ac = (int)ac;
		setIndex(index);
	}

	IColor(float rc, float gc, float bc, float ac) {
		this(rc,gc,bc,ac, 0,0,0,0, 0);
	}

	IColor() {
		this(125,125,125,125, 0,0,0,0, -1);
	}

	IColor copy() {
		return new IColor(rc, gc, bc, ac, rm, gm, bm, am, index);
	}

	void copySettings(IColor other) {
		rc = other.rc; bc = other.bc; gc = other.gc; ac = other.ac;
		rm = other.rm; bm = other.bm; gm = other.gm; am = other.am;
		index = other.index;
		r.x = other.r.x; r.X = other.r.X; r.mass = other.r.mass; r.vMult = other.r.vMult;
		g.x = other.g.x; g.X = other.g.X; g.mass = other.g.mass; g.vMult = other.g.vMult;
		b.x = other.b.x; b.X = other.b.X; b.mass = other.b.mass; b.vMult = other.b.vMult;
		a.x = other.a.x; a.X = other.a.X; a.mass = other.a.mass; a.vMult = other.a.vMult;
	}

	void update() {
		while (rc > colorHMax) {
			rc -= colorHMax;
		}
		while (rc < 0) {
			rc += colorHMax;
		}
		while (r.X > colorHMax) {
			r.X -= colorHMax;
		}
		while (r.X < 0) {
			r.X += colorHMax;
		}
		if (abs(r.X - r.x) > colorHMax) {
			r.a *= -1;
		}
		if (index != -1) {
		r.X = rm * af[index] + rc;
		g.X = gm * af[index] + gc;
		b.X = bm * af[index] + bc;
		a.X = am * af[index] + ac;
		}
		r.update();
		g.update();
		b.update();
		a.update();
	}

	void fillStyle() {
		fill(r.x, g.x, b.x, a.x);
	}

	void strokeStyle() {
		stroke(r.x, g.x, b.x, a.x);
	}

	void setx(float r, float g, float b, float a) {
		this.r.x = r;
		this.g.x = g;
		this.b.x = b;
		this.a.x = a;
	}

	void setv(float r, float g, float b, float a) {
		this.r.v = r;
		this.g.v = g;
		this.b.v = b;
		this.a.v = a;
	}

	void setX(float r, float g, float b, float a) {
		this.r.X = r;
		this.g.X = g;
		this.b.X = b;
		this.a.X = a;
	}

	void setVMult(float vMult) {
		this.r.vMult = vMult;
		this.g.vMult = vMult;
		this.b.vMult = vMult;
		this.a.vMult = vMult;
	}

	void setMass(float mass) {
		this.r.mass = mass;
		this.g.mass = mass;
		this.b.mass = mass;
		this.a.mass = mass;
	}

	void setIndex(float[] af, float index) {
		this.af = af;
		this.setIndex(index);
	}

	void setIndex(float index) {
		this.index = (int)abs(index%af.length);
	}

	void setIndex(float[] af) {
		this.af = af;
		this.setIndex(index);
	}

	void setM(float rm, float gm, float bm, float am) {
		this.rm = rm;
		this.gm = gm;
		this.bm = bm;
		this.am = am;
	}

	void setM(float r, float g, float b, float a, float i) {
		this.setM(r,g,b,a);
		setIndex(i);
	}

	void setC(float rc, float gc, float bc, float ac) {
		this.rc = (int)rc; r.X = rc;
		this.gc = (int)gc; g.X = gc;
		this.bc = (int)bc; b.X = bc;
		this.ac = (int)ac; a.X = ac;
	}

	void set(float rc, float gc, float bc, float ac, float rm, float gm, float bm, float am, float index) {
		setC(rc,gc,bc,ac);
		setM(rm,gm,bm,am);
		setIndex(index);
	}

	void set(float rc, float gc, float bc, float ac, float rm, float gm, float bm, float am) {
		set(rc,gc,bc,ac,rm,gm,bm,am,index);
	}

	void reset(float rc, float gc, float bc, float ac, float rm, float gm, float bm, float am, float index) {
		set(rc,gc,bc,ac,rm,gm,bm,am,index);
		r.x = rc; g.x = gc; b.x = bc; a.x = ac;
	}

	void reset(float rc, float gc, float bc, float ac, float rm, float gm, float bm, float am) {
		set(rc,gc,bc,ac,rm,gm,bm,am);
		r.x = rc; g.x = gc; b.x = bc; a.x = ac;
	}

	void reset(float rc, float gc, float bc, float ac) {
		setC(rc,gc,bc,ac);
		r.x = rc; g.x = gc; b.x = bc; a.x = ac;
	}

	void reset(IColor other) {
		reset(other.r.x, other.g.x, other.b.x, other.a.x, other.rm, other.gm, other.bm, other.am, other.index);
	}
}