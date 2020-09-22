DustPool dust = new DustPool();

void dustPattern(int which) {
	float x,y,z,t;
	switch(which) {
		default:
		for (int i = 0 ; i < dust.arm ; i ++) {
			Dust mob = dust.ar.get(i);
			t = (float)i/dust.arm*100;
			mob.a.v.add(
				(noise(tRate,t)-.5)*de*.03,
				(noise(tRate*1.5,t+10)-.5)*de*.03,
				(noise(tRate*2,t+99)-.5)*de*.03
			);
		}
		break;
	}
}

class Dust extends Entity {
	Point p = new Point();
	Point v = new Point();
	Point a = new Point();
	int lifeSpan, dieSpan, id;
	SpringValue w = new SpringValue();

	void update() {
		p.P.add(v.p);
		v.P.add(a.p);
		p.update();
		v.update();
		a.update();
		w.update();
		if (alive && lifeSpan > 0) {
			lifeSpan --;
			if (lifeSpan == 0) die();
		}
		if (!alive) {
			if (dieSpan > 0) {
				dieSpan --;
			} else {
				dead();
			}
		}
	}

	void render() {
		strokeWeight(w.x);
		point(p.p.x,p.p.y,p.p.z);
	}

	void die() {
		alive = false;
		w.X = 0;
	}

	void dead() {
		finished = true;
	}
}

class DustPool extends ObjectPool<Dust> {
	Dust add(float x, float y, float z) {
		if (arm == ar.size()) ar.add(new Dust());
		Dust mob = ar.get(arm);

		mob.p.reset(x,y,z);
		mob.v.reset();
		mob.a.reset();
		mob.w.reset(3.5);
		mob.finished = false;
		mob.alive = true;
		mob.lifeSpan = 15;
		mob.dieSpan = 15;

		arm ++;
		return mob;
	}

	// void render() {
	// 	stroke(360);
	// 	noFill();
	// 	int i = 0;
	// 	int currID = 0;
	// 	Dust mob;
	// 	if (arm > 0) currID = ar.get(0).id;
	// 	while (i < arm-1) {
	// 		beginShape();
	// 		mob = ar.get(i);
	// 		while (i < arm - 1 && mob.id == currID) {
	// 			vertex(mob.p.p.x, mob.p.p.y, mob.p.p.z);
	// 			i ++;
	// 			mob = ar.get(i);
	// 		}
	// 		endShape();
	// 		currID = mob.id;
	// 	}
	// }
}