void cameraBeat(float amp) {
	if (main.beat) {
		cam.ang.v.x += -.02*amp;
		cam.z.v += de*amp;
	}
}

void cameraBeat() {
	cameraBeat(1);
}

void sawPattern(int which, BranchPool branches, float amp, float rand, float lifeSpan, int num) {
	switch(which) {
		case 0:
		for (int i = 0 ; i < num ; i ++) {
			branches.add(lifeSpan, amp,amp,0, random(.5-rand,.5+rand));
			branches.add(lifeSpan, -amp,amp,0, random(.5-rand,.5+rand));
		}
		break;
		case 1:
		for (int i = 0 ; i < num ; i ++) {
			branches.add(lifeSpan, amp,-amp,0, random(.5-rand,.5+rand));
			branches.add(lifeSpan, -amp,-amp,0, random(.5-rand,.5+rand));
		}
		break;
		case 2:
		for (int i = 0 ; i < num ; i ++) {
			branches.add(lifeSpan, -amp,amp,0, random(.5-rand,.5+rand));
			branches.add(lifeSpan, -amp,-amp,0, random(.5-rand,.5+rand));
		}
		break;
		case 3:
		for (int i = 0 ; i < num ; i ++) {
			branches.add(lifeSpan, amp,amp,0, random(.5-rand,.5+rand));
			branches.add(lifeSpan, amp,-amp,0, random(.5-rand,.5+rand));
		}
		break;
		case 4:
		for (int i = 0 ; i < num ; i ++) {
			branches.add(lifeSpan, -amp,-amp,0, random(.5-rand,.5+rand));
			branches.add(lifeSpan, amp,-amp,0, random(.5-rand,.5+rand));
			branches.add(lifeSpan, amp,amp,0, random(.5-rand,.5+rand));
			branches.add(lifeSpan, -amp,amp,0, random(.5-rand,.5+rand));
		}
		break;
		case 5:
		for (int i = 0 ; i < num ; i ++) {
			branches.add(lifeSpan, -amp,0,0, random(.5-rand,.5+rand));
			branches.add(lifeSpan, amp,0,0, random(.5-rand,.5+rand));
			branches.add(lifeSpan, 0,-amp,0, random(.5-rand,.5+rand));
			branches.add(lifeSpan, 0,amp,0, random(.5-rand,.5+rand));
		}
		break;
	}
}

void gridXY(RootPool roots, float x, float y, float z, float wx, float wy, float lifeSpan, int num) {
	roots.addGrid(roots.addC(x-wx/2,y-wy/2,z, x+wx/2,y-wy/2,z, lifeSpan), 0,wy,0, num);
}

void gridXY2(RootPool roots, float x, float y, float z, float wx, float wy, float lifeSpan, int num) {
	roots.addGrid(roots.addC(x-wx/2,y-wy/2,z, x-wx/2,y+wy/2,z, lifeSpan), wx,0,0, num);
}

void gridXZ(RootPool roots, float x, float y, float z, float wx, float wz, float lifeSpan, int num) {
	roots.addGrid(roots.addC(x-wx/2,y,z-wz/2, x+wx/2,y,z-wz/2, lifeSpan), 0,0,wz, num);
}

void gridYZ(RootPool roots, float x, float y, float z, float wy, float wz, float lifeSpan, int num) {
	roots.addGrid(roots.addC(x,y-wy/2,z-wz/2, x,y+wy/2,z-wz/2, lifeSpan), 0,0,wz, num);
}

void gridBox(RootPool roots, float x, float y, float z, float wx, float wy, float wz, float lifeSpan, int num) {
	gridXY(roots, x,y,z-wz/2, wx,wy, lifeSpan, num);
	gridXY(roots, x,y,z+wz/2, wx,wy, lifeSpan, num);
	gridYZ(roots, x-wx/2,y,z, wy,wz, lifeSpan, num);
	gridYZ(roots, x+wx/2,y,z, wy,wz, lifeSpan, num);
	gridXZ(roots, x,y-wy/2,z, wx,wz, lifeSpan, num);
	gridXZ(roots, x,y+wy/2,z, wx,wz, lifeSpan, num);
}

void treePattern(BranchPool branches, int num, float amp) {
	for (int i = 0 ; i < num ; i ++) {
		branches.add(1, amp,-amp,0, random(.45,.55));
		branches.add(1, -amp,-amp,0, random(.45,.55));
		branches.add(1, 0, -amp*1.5,0, .5);
	}
}

void tree2Pattern(BranchPool branches, int num, float amp) {
	for (int i = 0 ; i < num ; i ++) {
		branches.add(1, amp,-amp,0, random(1));
		branches.add(1, -amp,-amp,0, random(1));
		branches.add(1, 0, -amp,0, random(1));
	}
}

void gridUpPattern(BranchPool branches, int num, float amp) {
	for (int i = 0 ; i < num ; i ++) {
		branches.add(1, amp,0,0, .5);
		branches.add(1, -amp,0,0, .5);
		branches.add(1, 0,-amp,0, random(1));
		branches.add(1, 0,-amp,0, random(1));
	}
}

void gridPattern(BranchPool branches, int num, float amp) {
	for (int i = 0 ; i < num ; i ++) {
		branches.add(1, amp,0,0, .5);
		branches.add(1, -amp,0,0, .5);
		branches.add(1, 0,amp,0, random(1));
		branches.add(1, 0,-amp,0, random(1));
	}
}

void diamondPattern(BranchPool branches, int num, float amp) {
	for (int i = 0 ; i < num ; i ++) {
		branches.add(1, amp,-amp,0, .5);
		branches.add(1, -amp,-amp,0, .5);
		branches.add(1, amp,amp,0, .5);
		branches.add(1, -amp,amp,0, .5);
	}
}

void diagonalUpPattern(BranchPool branches, int num, float amp) {
	for (int i = 0 ; i < 2 ; i ++) {
		branches.add(1, amp,-amp,0, random(1));
		branches.add(1, -amp,-amp,0, random(1));
		branches.add(1, amp,0,0, random(1));
		branches.add(1, -amp,0,0, random(1));
		branches.add(1, 0,-amp,0, random(1));
	}
}