abstract class ObjectPoolF<T extends MobF> extends ObjectPool<T> {
	void setFill(boolean which, float r1, float g1, float b1, float a1, float rm1, float gm1, float bm1, float am1) {
		setFill(which, r1,g1,b1,a1, rm1,gm1,bm1,am1, r1,g1,b1,a1, rm1,gm1,bm1,am1);
	}

	void setFill(boolean which, float r1, float g1, float b1, float a1, float rm1, float gm1, float bm1, float am1,
		float r2, float g2, float b2, float a2, float rm2, float gm2, float bm2, float am2) {
		float t;
		if (which) {
			for (int i = 0 ; i < arm ; i ++) {		
				T mob = ar.get(i);
				t = (float)i/arm;
				mob.fillStyle.set(map(t,0,1, r1,r2), map(t,0,1, g1,g2), map(t,0,1, b1,b2), map(t,0,1, a1,a2), 
					map(t,0,1, rm1,rm2), map(t,0,1, gm1,gm2), map(t,0,1, bm1,bm2), map(t,0,1, am1,am2));
				mob.fillStyle.setIndex(t*mob.fillStyle.af.length);
			}
		} else {
			for (int i = 0 ; i < arm ; i ++) {
				T mob = ar.get(i);
				t = (float)i/arm;
				mob.strokeStyle.set(map(t,0,1, r1,r2), map(t,0,1, g1,g2), map(t,0,1, b1,b2), map(t,0,1, a1,a2), 
					map(t,0,1, rm1,rm2), map(t,0,1, gm1,gm2), map(t,0,1, bm1,bm2), map(t,0,1, am1,am2));
				mob.strokeStyle.setIndex(t*mob.strokeStyle.af.length);
			}
		}
	}
}

abstract class ObjectPool<T extends Entity> extends Entity {
	int arm;
	ArrayList<T> ar;

	ObjectPool() {
		arm = 0;
		ar = new ArrayList<T>();
	}

	// void set(Obj obj, [args]);

	// void add(Obj obj, [args]) {
	//   if (arm == ar.size()) {
	//     ar.add(new Mob(p));
	//   } else {
	//     Mob mob = (Mob)ar.get(arm);
	//   }
	//   reset mob
	//   arm ++;
	// }

	T getLast() {
		return ar.get(0);
	}

	void remove(int i) {
		ar.add(ar.remove(i));
		arm --;
	}

	T get(float i) {
		return ar.get((int)i%arm);
	}

	void render() {
		for (int i = 0 ; i < arm ; i ++) {
			ar.get(i).render();
		}
	}

	void update() {
		for (int i = 0 ; i < arm ; i ++) {
			ar.get(i).update();
		}
		for (int i = 0 ; i < arm ; i ++) {
			if (ar.get(i).finished) remove(i);
		}
	}

	void clear() {
		for (int i = 0 ; i < arm ; i ++) {
			ar.get(i).finished = true;
		}
		arm = 0;
	}
}