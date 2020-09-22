class Camera {
	Point p;
	Point pv = new Point();
	Point ang;
	Point av = new Point();
	SpringValue z = new SpringValue();
	PVector dp;
	PVector dang;
	boolean lock = true;

	Camera(float x, float y, float z, float ax, float ay, float az) {
		this.p = new Point(x, y, z);
		this.dp = this.p.p.copy();
		this.ang = new Point(ax, ay, az);
		this.dang = new PVector(ax, ay, az);
		this.ang.mass = 10;
		this.ang.vMult = .5;
		this.p.mass = 10;
		this.p.vMult = .1;
		this.z.reset(-de*2);
	}

	Camera(float x, float y, float z) {
		this(x,y,z,0,0,0);
	}

	void update() {
		if (keyP == 'w') p.P.z += 10;
		if (keyP == 's') p.P.z -= 10;
		if (keyP == 'a') p.P.x += 10;
		if (keyP == 'd') p.P.x -= 10;
		if (keyP == 'q') p.P.y -= 10;
		if (keyP == 'e') p.P.y += 10;
		if (keyP == 'i') z.X += 15;
		if (keyP == 'o') z.X -= 15;
		if (keyP == 'r') z.X = de;
		if (!lock) {
			ang.P.y = (float)mouseX/width*2*PI - PI;
			ang.P.x = -(float)mouseY/height*2*PI - PI;
		} else {
			ang.P.add(av.p);
		}
		p.P.add(pv.p);
		p.update();
		pv.update();
		ang.P.add(av.p);
		ang.update();
		av.update();
		z.update();
	}

	void render() {
		translate(width/2,height/2,z.x);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		translate(p.p.x,p.p.y,p.p.z);
	}
}