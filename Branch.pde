RootPool roots = new RootPool();
BranchPool branches = new BranchPool(roots);
Root2Pool root2 = new Root2Pool();
Branch2Pool branch2 = new Branch2Pool(root2);
int maxDepth = 16;
float minSize = 1;
int branchID = 0;

float getAmp(Branch mob) {
	//return main.af[(int)(abs(mob.p1.p.x + mob.p1.p.y + mob.p1.p.z)/de*main.af.length)%main.af.length]/main.avg;
	//return main.af[mob.id%main.af.length];
	return mob.strokeStyle.x;
}

void renderRootLine(ArrayList<Branch> ar, int arm) {
	for (int i = 0 ; i < arm ; i ++) {
		Branch mob = ar.get(i);
		float amp = 360;
		stroke(180);
		strokeWeight(amp/360+.5);
		line(mob.p1.p.x,mob.p1.p.y,mob.p1.p.z, mob.p2.p.x,mob.p2.p.y,mob.p2.p.z);
	}
}

void renderBranchLine(ArrayList<Branch> ar, int arm) {
	for (int i = 0 ; i < arm ; i ++) {
		Branch mob = ar.get(i);
		//float amp = mob.strokeStyle.x;
		float amp = getAmp(mob);
		stroke(0,0,100,amp);
		strokeWeight(amp/360+.5);
		line(mob.p1.p.x,mob.p1.p.y,mob.p1.p.z, mob.p2.p.x,mob.p2.p.y,mob.p2.p.z);
	}
}

void renderBranchRibbon(ArrayList<Branch> ar, int arm) {
	for (int i = 0 ; i < arm ; i ++) {
		Branch mob = ar.get(i);
		//float amp = mob.strokeStyle.x;
		float amp = getAmp(mob);
		stroke(0,0,100,amp*3);
		strokeWeight(amp/360+.5);
		beginShape();
		fill(0, 0, min(amp,75)+25, amp*3+25);
		vertex(mob.p1.p.x,mob.p1.p.y,mob.p1.p.z);
		fill(0, 0, min(amp,25)+25, amp*2+25);
		vertex(mob.p2.p.x,mob.p2.p.y,mob.p2.p.z);
		fill(0, 0, min(amp,5)+25, amp*2+25);
		vertex(mob.p2.p.x+35,mob.p2.p.y+50,mob.p2.p.z+20);
		fill(0, 0, min(amp,75)+25, amp*2+25);
		vertex(mob.p1.p.x+35,mob.p1.p.y+50,mob.p1.p.z+20);
		endShape(CLOSE);
		// beginShape();
		// fill(amp*3, amp*2, min(amp*3,75)+50, amp*3+25);
		// vertex(mob.p1.p.x,mob.p1.p.y,mob.p1.p.z);
		// fill(amp*3+100, amp*2, min(amp*3,25)+50, amp*3+25);
		// vertex(mob.p2.p.x,mob.p2.p.y,mob.p2.p.z);
		// fill(amp*3+180, amp*2, min(amp*3,5)+50, amp*3+25);
		// vertex(mob.p2.p.x+35,mob.p2.p.y+50,mob.p2.p.z+20);
		// fill(amp*3+240, amp*2, min(amp*3,75)+50, amp*3+25);
		// vertex(mob.p1.p.x+35,mob.p1.p.y+50,mob.p1.p.z+20);
		// endShape(CLOSE);
	}
}

void renderRootRibbon(ArrayList<Branch> ar, int arm) {
	for (int i = 0 ; i < arm ; i ++) {
		Branch mob = ar.get(i);
		float amp = getAmp(mob) + 10;
		stroke(0,0,100,amp*3);
		strokeWeight(amp/360+.5);
		beginShape();
		fill(0, 0, min(amp,75)+25, amp*3+25);
		vertex(mob.p1.p.x,mob.p1.p.y,mob.p1.p.z);
		fill(0, 0, min(amp,25)+25, amp*2+25);
		vertex(mob.p2.p.x,mob.p2.p.y,mob.p2.p.z);
		fill(0, 0, min(amp,5)+25, amp*2+25);
		vertex(mob.p2.p.x+35,mob.p2.p.y+50,mob.p2.p.z+20);
		fill(0, 0, min(amp,75)+25, amp*2+25);
		vertex(mob.p1.p.x+35,mob.p1.p.y+50,mob.p1.p.z+20);
		endShape(CLOSE);
	}
}

void branchPattern(int which, float amp) {
	float x,y,z,t;
	switch(which) {
		default:
		amp *= de*.03 + main.avg;
		for (int i = 0 ; i < branches.arm ; i ++) {
			Branch mob = branches.ar.get(i);
			t = (float)i/branches.arm*100;
			
			mob.p1.P.add(
				(noise(tRate,t)-.5)*amp,
				(noise(tRate*1.5,t+10)-.5)*amp,
				(noise(tRate*2,t+99)-.5)*amp
			);
			mob.p2.P.add(
				(noise(tRate,t)-.5)*amp,
				(noise(tRate*1.5,t+25)-.5)*amp,
				(noise(tRate*2,t+33)-.5)*amp
			);
		}
		break;
	}
}

void branchDrift(float x, float y, float z) {
	for (int i = 0 ; i < branches.arm ; i ++) {
		Branch mob = branches.ar.get(i);
		mob.p1.P.add(x,y,z);
		mob.p2.P.add(x,y,z);
	}
}

class Branch extends Entity {
	ArrayList<Branch> children = new ArrayList<Branch>();
	int depth = 0;
	Point p1,p2;
	Branch parent;

	int lifeSpan, dieSpan;
	int id;

	SpringValue strokeStyle = new SpringValue();

	Branch() {
		strokeStyle.xm = .2;
		strokeStyle.mass = .1;
		strokeStyle.vMult = .07;
	}

	void update() {
		p1.update();
		p2.update();
		strokeStyle.update();
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

	void render() {}

	void die() {
		alive = false;
		p1.P.set(p2.p);
		strokeStyle.X = 0;

		if (dust.arm < 6000 && random(1) < .1) {
			float d = dist(p1.p.x,p1.p.y,p1.p.z, p2.p.x,p2.p.y,p2.p.z);
			float dx = p2.p.x-p1.p.x;
			float dy = p2.p.y-p1.p.y;
			float dz = p2.p.z-p1.p.z;
			float t;
			int num = (int)(d*.6);
			for (int i = 0 ; i < num ; i ++) {
				t = (float)i/num;
				dust.add(p1.p.x+t*dx, p1.p.y+t*dy, p1.p.z+t*dz).id = id;
			}
		}
	}

	void dead() {
		finished = true;
		for (Branch child : children) {
			child.die();
		}
		p1.finished = true;
		p2.finished = true;
		children.clear();
	}
}

class RootPool extends ObjectPool<Branch> {
	Branch add(float x1, float y1, float z1, float x2, float y2, float z2, float lifeSpan) {
		if (arm == ar.size()) ar.add(new Branch());
		Branch mob = ar.get(arm);

		mob.p1 = points.add(x1,y1,z1);
		mob.p2 = points.add(x2,y2,z2);
		mob.p2.p.set(mob.p1.p);

		mob.strokeStyle.reset(0,360);
		mob.strokeStyle.setIndex(abs(mob.p1.p.x + mob.p1.p.y + mob.p1.p.z)/de*main.af.length);
		if (lifeSpan == -1) {
			mob.lifeSpan = -1;
		} else {
			mob.lifeSpan = toBeat(lifeSpan);
		}
		mob.dieSpan = 15;
		mob.finished = false;
		mob.alive = true;
		mob.id = branchID;
		branchID ++;
		
		arm ++;
		return mob;
	}

	Branch addC(float x1, float y1, float z1, float x2, float y2, float z2, float lifeSpan) {
		return add(x1 -cam.p.p.x,y1 - cam.p.p.y,z1 - cam.p.p.z, x2 - cam.p.p.x,y2-cam.p.p.y,z2-cam.p.p.z, lifeSpan);
	}

	void addGrid(Branch mob, float dx, float dy, float dz, int num) {
		float x1 = mob.p1.P.x;
		float y1 = mob.p1.P.y;
		float z1 = mob.p1.P.z;
		float x2 = mob.p2.P.x;
		float y2 = mob.p2.P.y;
		float z2 = mob.p2.P.z;
		for (float i = 0 ; i < num ; i ++) {
			add(x1,y1,z1, x2,y2,z2, (float)mob.lifeSpan/main.fpb);
			x1 += dx/num; y1 += dy/num; z1 += dz/num;
			x2 += dx/num; y2 += dy/num; z2 += dz/num;
		}
	}

	void render() {
		renderRootRibbon(ar, arm);
	}

	void die() {
		for (int i = 0 ; i < arm ; i ++) {
			ar.get(i).die();
		}
	}
}

class BranchPool extends ObjectPool<Branch> {
	RootPool root;

	BranchPool(RootPool roots) {
		this.root = roots;
	}

	Branch add(Branch parent, float lifeSpan, float sx, float sy, float sz, float ss) {
		if (parent.depth == maxDepth) return null;
		if (arm == ar.size()) ar.add(new Branch());
		Branch mob = ar.get(arm);

		float dx = parent.p2.P.x - parent.p1.P.x;
		float dy = parent.p2.P.y - parent.p1.P.y;
		float dz = parent.p2.P.z - parent.p1.P.z;
		float d = dist(parent.p1.p.x, parent.p1.p.y, parent.p1.p.z, parent.p2.p.x, parent.p2.p.y, parent.p2.p.z);
		d = max(d,minSize*de);
		mob.p1 = new Point(parent.p1.p.x + dx*ss, parent.p1.p.y + dy*ss, parent.p1.p.z + dz*ss);
		mob.p2 = new Point(mob.p1.p.x + d*sx, mob.p1.p.y + d*sy, mob.p1.p.z + d*sz);
		mob.p2.p.set(mob.p1.p);

		mob.strokeStyle.setIndex(abs(mob.p1.p.x + mob.p1.p.y + mob.p1.p.z)/de*main.af.length);

		mob.depth = parent.depth + 1;
		mob.parent = parent;
		parent.children.add(mob);
		if (lifeSpan == -1) {
			mob.lifeSpan = -1;
		} else {
			mob.lifeSpan = toBeat(lifeSpan);
		}
		mob.dieSpan = 8;
		mob.finished = false;
		mob.alive = true;
		mob.id = branchID;
		branchID ++;

		arm ++;
		return mob;
	}

	Branch add(float lifeSpan, float sx, float sy, float sz, float ss) {
		if (arm + root.arm == 0) return null;
		int index = (int)random(arm + root.arm);
		if (index < arm) return add(ar.get(index), lifeSpan, sx, sy, sz, ss);
		return add(root.ar.get(index - arm), lifeSpan, sx, sy, sz, ss);
	}

	void render() {
		renderBranchRibbon(ar, arm);
	}

	void die() {
		for (int i = 0 ; i < arm ; i ++) {
			ar.get(i).die();
		}
	}
}

class Root2Pool extends RootPool {
	void render() {
		renderRootLine(ar, arm);
	}
}

class Branch2Pool extends BranchPool {
	Branch2Pool(RootPool root) {
		super(root);
	}

	void render() {
		renderBranchLine(ar, arm);
	}
}