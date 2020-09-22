abstract class MobF extends Mob {
	IColor fillStyle = new IColor();
	IColor strokeStyle = new IColor();

	void update() {
		super.update();
		fillStyle.update();
		strokeStyle.update();
	}

	void setDraw() {
		push();
		if (fillStyle.a.x > 1) {
			fillStyle.fillStyle();
		} else {
			noFill();
		}
		if (strokeStyle.a.x > 1) {
		strokeStyle.strokeStyle();
		} else {
			noStroke();
		}
		translate(p.p.x, p.p.y, p.p.z);
		rotateX(rang.p.x);
		rotateY(rang.p.y);
		rotateZ(rang.p.z);
		translate(r.p.x,r.p.y,r.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		if (sca.x != 1) scale(sca.x);
	}

	void setMass(float mass) {
		super.setMass(mass);
		fillStyle.setMass(mass);
		strokeStyle.setMass(mass);
	}

	void setVMult(float vMult) {
		super.setVMult(vMult);
		fillStyle.setVMult(vMult);
		strokeStyle.setVMult(vMult);
	}

	void setIndex(float[] af, float index) {
		super.setIndex(af, index);
		fillStyle.setIndex(af, index);
		strokeStyle.setIndex(af, index);
	}

	void setIndex(float index) {
		super.setIndex(index);
		fillStyle.setIndex(index);
		strokeStyle.setIndex(index);
	}
}

abstract class Mob extends Entity {
	Point p;
	Point pv = new Point(0,0,0);
	Point r = new Point(0,0,0);
	Point rv = new Point(0,0,0);
	SpringValue sca = new SpringValue(1);
	SpringValue scav = new SpringValue(0);
	Point ang;
	Point rang = new Point(0,0,0);
	Point rav = new Point(0,0,0);
	Point av = new Point(0,0,0);
	Point w;
	float[] af = defaultAf;

	void reset() {
		p.reset();
		pv.reset();
		r.reset();
		rv.reset();
		sca.reset(1);
		ang.reset();
		rang.reset();
		rav.reset();
		av.reset();
		w.reset();
		scav.reset(0);
		finished = false;
		draw = true;
		alive = true;
	}

	void setMass(float mass) {
		p.mass = mass;
		pv.mass = mass;
		ang.mass = mass;
		av.mass = mass;
		r.mass = mass;
		rv.mass = mass;
		rang.mass = mass;
		rav.mass = mass;
		sca.mass = mass;
		scav.mass = mass;
		w.mass = mass;
	}

	void setVMult(float vMult) {
		p.vMult = vMult;
		pv.vMult = vMult;
		ang.vMult = vMult;
		av.vMult = vMult;
		r.vMult = vMult;
		rv.vMult = vMult;
		rang.vMult = vMult;
		rav.vMult = vMult;
		sca.vMult = vMult;
		w.vMult = vMult;
		scav.vMult = vMult;
	}

	void setIndex(float k) {
		p.setIndex(k);
		pv.setIndex(k);
		ang.setIndex(k);
		av.setIndex(k);
		r.setIndex(k);
		rv.setIndex(k);
		rang.setIndex(k);
		rav.setIndex(k);
		sca.setIndex(k);
		scav.setIndex(k);
		w.setIndex(k);
	}

	void setIndex(float[] af, float index) {
		this.af = af;
		p.setIndex(af,index);
		pv.setIndex(af,index);
		ang.setIndex(af,index);
		av.setIndex(af,index);
		r.setIndex(af,index);
		rv.setIndex(af,index);
		rang.setIndex(af,index);
		rav.setIndex(af,index);
		sca.setIndex(af,index);
		scav.setIndex(af,index);
		w.setIndex(af,index);
	}

	void setIndex(float[] af) {
		this.af = af;
		p.setIndex(af,p.index);
		pv.setIndex(af,pv.index);
		ang.setIndex(af,ang.index);
		av.setIndex(af,av.index);
		r.setIndex(af,r.index);
		rv.setIndex(af,rv.index);
		rang.setIndex(af,rang.index);
		rav.setIndex(af,rav.index);
		sca.setIndex(af,sca.index);
		scav.setIndex(af,scav.index);
		w.setIndex(af,w.index);
	}

	void update() {
		p.P.add(pv.p);
		ang.P.add(av.p);
		r.P.add(rv.p);
		rang.P.add(rav.p);
		p.update();
		pv.update();
		r.update();
		rv.update();
		ang.update();
		rang.update();
		rav.update();
		av.update();
		sca.X += scav.x;
		sca.update();
		scav.update();
		w.update();
		if (w.p.x < 0) w.p.x = 0;
		if (w.p.y < 0) w.p.y = 0;
		if (w.p.z < 0) w.p.z = 0;
	}

	void setDraw() {
		push();
		translate(p.p.x, p.p.y, p.p.z);
		rotateX(rang.p.x);
		rotateY(rang.p.y);
		rotateZ(rang.p.z);
		translate(r.p.x,r.p.y,r.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		if (sca.x != 1) scale(sca.x);
	}

	abstract void render();
}

abstract class Entity {
	boolean finished = false;
	boolean alive = true;
	boolean draw = true;

	abstract void render();

	abstract void update();
}