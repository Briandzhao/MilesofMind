PointPool points = new PointPool();
class PointPool {
	int arm = 0;
	ArrayList<Point> ar = new ArrayList<Point>();

	Point add(float x, float y, float z) {
		if (arm == ar.size()) ar.add(new Point());
		Point p = ar.get(arm);
		p.reset(x,y,z);
		p.finished = false;

		arm ++;
		return p;
	}

	Point add() {
		return add(0,0,0);
	}

	void remove(int i) {
		ar.add(ar.remove(i));
		arm --;
	}

	Point get(float i) {
		return ar.get(max((int)i,arm-1));
	}

	void update() {
		for (int i = 0 ; i < arm ; i ++) {
			ar.get(i).update();
		}
		for (int i = 0 ; i < arm ; i ++) {
			if (ar.get(i).finished) remove(i);
		}
	}

	void buffer(int num) {
		for (int i = 0 ; i < num ; i ++) {
			add(0,0,0).finished = true;
		}
	}

	void clear() {
		for (int i = 0 ; i < arm ; i ++) {
			ar.get(i).finished = true;
		}
		arm = 0;
	}
}