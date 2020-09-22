HashMap<Integer, Integer> chords = new HashMap<Integer, Integer>();
void setupEvents() {
	dx = de*1.5;
	chords.put(240,0);
	chords.put(244,0);
	chords.put(246,0);
	chords.put(248,0);
	chords.put(252,0);
	chords.put(256,0);
	chords.put(260,0);
	chords.put(262,0);
	chords.put(264,0);
	chords.put(268,0);
	chords.put(272,0);
	chords.put(276,0);
	chords.put(278,0);
	chords.put(280,0);
	chords.put(284,0);
	chords.put(288,0);
	chords.put(292,0);
	chords.put(294,0);
	chords.put(296,0);
	chords.put(300,0);
}

void sequence() {
	dustPattern(0);
	branchPattern(0, 1);
	if (beatInRange(0,16)) {
		if (beatE(.5)) {
			roots.addGrid(roots.addC(-dx,de,-de*.5, dx,de,-de*.5, 48), 0,0,de, 8);
			root2.addGrid(root2.addC(-dx,de,-de*.75, dx,de,-de*.75, 48), 0,0,de*1.5, 8);
		}
		if (beatInRange(0,12)) {
			treePattern(branches, 2, .5);
			treePattern(branch2, 7, .5);
		}
		if (main.beat) {
			if (main.currBeat % 2 == 0) {
				roots.addGrid(roots.addC(-dx,de,-de, -dx,de,de, 1), 0,-de*2,0, 25);
			} else {
				roots.addGrid(roots.addC(dx,de,-de, dx,de,de, 1), 0,-de*2,0, 25);
			}
		}
	}
	if (beatInRange(12,80)) {
		if (beatE(48)) {
			cam.pv.reset(0,0,-de*.013);
		}
		gridUpPattern(branches, 2, .5);
		gridUpPattern(branch2, 12, .5);
		if (beatE(79)) {
			branches.die();
			roots.die();
		}
	}
	if (beatInRange(48,80)) {
		if (main.beat) {
			if (main.currBeat % 2 == 0) {
				roots.addGrid(roots.addC(-dx,de,de*.5, dx,de,de*.5, 4), 0,0,de, 8);
				root2.addGrid(root2.addC(-dx,de,de*.5, dx,de,de*.5, 4), 0,0,de, 8);
			} else if (main.currBeat < 78) {
				roots.addGrid(roots.addC(-dx,de,-de, -dx,de,de, 1), 0,-de*.5,0, 12);
				roots.addGrid(roots.addC(dx,de,-de, dx,de,de, 1), 0,-de*.5,0, 12);
			}
		}
	}
	// Drop A
	if (beatInRange(80,142)) {
		if (beatE(80)) {
			cam.p.reset(0,0,0);
			cam.ang.reset(0,0,0);
			cam.pv.reset(0,0,de*.01);
		}
		cameraBeat();
		if (main.beat) {
			if (main.currBeat % 4 == 0) roots.addGrid(roots.addC(-de,de*.5,0, de,de*.5,0, 1), 0,-de,0, 50);
			if (main.currBeat % 4 == 1) roots.addGrid(roots.addC(-de*.5,-de,0, -de*.5,de,0, 1), de,0,0, 50);
			if (main.currBeat % 4 == 2) roots.addGrid(roots.addC(de,-de*.5,0, -de,-de*.5,0, 1), 0,de,0, 50);
			if (main.currBeat % 4 == 3) roots.addGrid(roots.addC(-de*.5,de,0, -de*.5,-de,0, 1), de,0,0, 50);
			root2.addGrid(root2.addC(de,-de*.5,-de*.25, -de,-de*.5,-de*.25, 1), 0,de,0, 25);
		}
		if (main.currBeat % 8 < 4) {
			diamondPattern(branches, 1 + (frameCount/2)%2, .5);
			diamondPattern(branch2, 7, .5);
		} else {
			gridPattern(branches, 1 + (frameCount/2)%2, .5);
			gridPattern(branch2, 7, .5);
		}
	}
	// Drop B
	if (beatInRange(144,205)) {
		if (beatE(144)) {
			cam.p.reset(0,0,0);
			cam.pv.reset(0,0,-de*.02);
			cam.av.reset(0,0,0);
		}
		cameraBeat();
		if (main.beat) {
			float y = de;
			roots.addGrid(roots.addC(-dx,y,de*.5, dx,y,de*.5, 4), 0,0,de*.5, 3);
			root2.addGrid(root2.addC(-dx,y,de*.5, dx,y,de*.5, 4), 0,0,de*.5, 2);
			if (main.currBeat % 4 == 0) {
				if ((main.currBeat/4) % 2 == 0) roots.addGrid(roots.addC(-dx,y,de*.35, dx,y,de*.35, 1), 0,-de*2,0, 40);
				if ((main.currBeat/4) % 2 == 1) roots.addGrid(roots.addC(-dx,y-de*2,de*.35, -dx,y,de*.35, 1), dx*2,0,0, 40);
				float h;
				int num = (int)random(4,6);
				for (int i = 0 ; i < num ; i ++) {
					h = random(de,de*1.65);
					gridXY2(roots, random(-dx,dx),-h/2+y,random(de*.25,de*.5), random(de*.5,de*.85),h, 2, 12);
				}
			}
		}
		if (main.currBeat % 8 < 4) {
			diagonalUpPattern(branches, 1 + frameCount%2, .5);
			diagonalUpPattern(branch2, 7, .75);
		} else {
			gridUpPattern(branches, 1 + frameCount%2, .5);
			gridUpPattern(branch2, 7, .75);
		}
	}
	// Lyrics, upward
	if (beatInRange(208,240)) {
		if (beatE(208)) {
			cam.p.reset(0,0,0);
			cam.pv.P.set(0,de*.01,0);
			cam.av.P.set(0,0,0);
		}
		cam.ang.P.set(-.3+cos((float)frameCount*.01)*.3,sin((float)frameCount*.01)*.3,0);

		if (main.beat) {
			float y = de*.25;
			roots.addGrid(roots.addC(-de,y,-de, de,y,-de, 1), 0,0,de*2, 50);
			y = de*.5;
			root2.addGrid(root2.addC(-de*1.5,y,-de*1.5, -de*1.5,y,de*1.5, 2), de*.5,0,0, 12);
			root2.addGrid(root2.addC(de*1.5,y,-de*1.5, de*1.5,y,de*1.5, 2), -de*.5,0,0, 12);
			root2.addGrid(root2.addC(-de*1.5,y,-de*1.5, de*1.5,y,-de*1.5, 2), 0,0,de*.5, 12);
			root2.addGrid(root2.addC(-de*1.5,y,de*1.5, de*1.5,y,de*1.5, 2), 0,0,-de*.5, 12);
		}
		gridUpPattern(branches, 2, .65);
		gridPattern(branch2, 9, .65);
	}
	// Lyrics, forward
	if (beatInRange(240,304)) {
		if (beatE(240)) {
			cam.p.v.set(0,0,0);
			cam.p.P.set(cam.p.p);
			cam.pv.reset(0,0,0);
			cam.ang.P.set(0,0,0);
		}
		cam.ang.P.set(cos((float)frameCount*.005)*.15,sin((float)frameCount*.005)*.15,0);
		if (main.beat) {
			if (chords.containsKey((int)main.currBeat)) {
				cam.p.P.add(0,0,-de*.75);
				println(branches.arm + " " + branches.ar.size() + " " + roots.arm + " " + roots.ar.size());
				roots.addGrid(roots.addC(-dx,de,de*.25, dx,de,de*.25, 4), 0,0,de*.5, 6);
				roots.addGrid(roots.addC(-dx,-de,de*.25, -dx,de,de*.25, 4), 0,0,de*.5, 6);
				roots.addGrid(roots.addC(dx,-de,de*.25, dx,de,de*.25, 4), 0,0,de*.5, 6);
				root2.addGrid(root2.addC(-dx,de,de*.25, dx,de,de*.25, 4), 0,0,de*.5, 6);
			}
		}
		gridUpPattern(branches, 2, .5);
		gridPattern(branch2, 9, .65);
	}
	// Build up
	if (beatInRange(304,336)) {
		branchDrift(0,0,de*.01);
		if (beatE(304)) {
			cam.p.reset(0,0,0);
			cam.pv.reset(0,0,0);
			cam.ang.reset(0,0,0);
			roots.addGrid(roots.addC(-de,de*.5,0, de,de*.5,0, 28), 0,-de,0, 12);
			roots.addGrid(roots.addC(de*.5,-de,0, de*.5,de,0, 28), -de,0,0, 12);
		}
		if (main.currBeat < 308) {
			sawPattern(0, branches, .5, 0, 2, 2);
		} else if (main.currBeat < 312) {
			sawPattern(1, branches, .5, 0, 2, 2);
		} else if (main.currBeat < 316) {
			sawPattern(2, branches, .5, 0, 2, 2);
		} else if (main.currBeat < 320) {
			sawPattern(3, branches, .5, 0, 2, 2);
		} else if (main.currBeat < 324) {
			sawPattern(4, branches, .5, 0, 2, 2);
		} else if (main.currBeat < 328) {
			sawPattern(5, branches, .5, 0, 2, 2);
		} else if (main.currBeat < 336) {
			sawPattern(4, branches, .5, 0, 2, 1);
			sawPattern(5, branches, .5, 0, 2, 1);
		}
		if (main.currBeat < 308) {
			sawPattern(0, branch2, .5, 0, 2, 6);
		} else if (main.currBeat < 312) {
			sawPattern(1, branch2, .5, 0, 2, 6);
		} else if (main.currBeat < 316) {
			sawPattern(2, branch2, .5, 0, 2, 6);
		} else if (main.currBeat < 320) {
			sawPattern(3, branch2, .5, 0, 2, 6);
		} else if (main.currBeat < 324) {
			sawPattern(4, branch2, .5, 0, 2, 6);
		} else if (main.currBeat < 328) {
			sawPattern(5, branch2, .5, 0, 2, 6);
		} else if (main.currBeat < 336) {
			sawPattern(4, branch2, .5, 0, 2, 3);
			sawPattern(5, branch2, .5, 0, 2, 3);
		}
	}
	// Drop A
	if (beatInRange(336,400)) {
		if (beatE(336)) {
			cam.ang.reset(0,0,0);
			cam.pv.reset(0,0,de*.01);
		}
		cameraBeat();
		if (main.beat) {
			if (main.currBeat % 4 == 0) roots.addGrid(roots.addC(-de,de*.5,0, de,de*.5,0, 1), 0,-de,0, 50);
			if (main.currBeat % 4 == 1) roots.addGrid(roots.addC(-de*.5,-de,0, -de*.5,de,0, 1), de,0,0, 50);
			if (main.currBeat % 4 == 2) roots.addGrid(roots.addC(de,-de*.5,0, -de,-de*.5,0, 1), 0,de,0, 50);
			if (main.currBeat % 4 == 3) roots.addGrid(roots.addC(-de*.5,de,0, -de*.5,-de,0, 1), de,0,0, 50);
			root2.addGrid(root2.addC(de,-de*.5,-de*.25, -de,-de*.5,-de*.25, 1), 0,de,0, 25);

			if (main.currBeat % 8 == 0) {
				roots.addGrid(roots.addC(-dx,de,-de*2, -dx,de,de*2, 1), 0,-de*2,0, 25);
				roots.addGrid(roots.addC(dx,de,-de*2, dx,de,de*2, 1), 0,-de*2,0, 25);
			} else if (main.currBeat % 8 == 4) {
				roots.addGrid(roots.addC(-dx,-de,-de*2, -dx,-de,de*2, 1), dx*2,0,0, 25);
				roots.addGrid(roots.addC(-dx,de,-de*2, -dx,de,de*2, 1), dx*2,0,0, 25);
			}
		}
		if (main.currBeat % 8 < 4) {
			diamondPattern(branches, 1 + (frameCount/2)%2, .5);
			diamondPattern(branch2, 5, .5);
		} else {
			gridPattern(branches, 1 + (frameCount/2)%2, .5);
			gridPattern(branch2, 5, .5);
		}
	}
	if (beatInRange(400,464)) {
		cameraBeat();
		if (main.beat) {
			if (main.currBeat % 4 == 0) roots.addGrid(roots.addC(-de,de,0, de,de,0, 1), 0,-de,0, 50);
			if (main.currBeat % 4 == 2) roots.addGrid(roots.addC(de,-de,0, de,de,0, 1), -de,0,0, 50);
			if (main.currBeat % 4 == 1) roots.addGrid(roots.addC(de,-de,0, -de,-de,0, 1), 0,de,0, 50);
			if (main.currBeat % 4 == 3) roots.addGrid(roots.addC(-de,de,0, -de,-de,0, 1), de,0,0, 50);
			root2.addGrid(root2.addC(dx,-de*.5,-de*.25, -dx,-de*.5,-de*.25, 1), 0,de,0, 25);

			if (main.currBeat % 8 == 0) {
				roots.addGrid(roots.addC(-dx,de,-de*2, -dx,de,de*2, 4), 0,-de*2,0, 25);
				roots.addGrid(roots.addC(dx,de,-de*2, dx,de,de*2, 4), 0,-de*2,0, 25);
			} else if (main.currBeat % 8 == 4) {
				roots.addGrid(roots.addC(-dx,-de,-de*2, -dx,-de,de*2, 4), dx*2,0,0, 25);
				roots.addGrid(roots.addC(-dx,de,-de*2, -dx,de,de*2, 4), dx*2,0,0, 25);
			}
		}
		float amp = .35;
		if (main.currBeat < 408) {
			sawPattern(0, branches, amp, 0, 2, 2);
		} else if (main.currBeat < 412) {
			sawPattern(1, branches, amp, 0, 2, 2);
		} else if (main.currBeat < 416) {
			sawPattern(2, branches, amp, 0, 2, 2);
		} else if (main.currBeat < 420) {
			sawPattern(3, branches, amp, 0, 2, 2);
		} else if (main.currBeat < 424) {
			sawPattern(4, branches, amp, 0, 2, 2);
		} else if (main.currBeat < 428) {
			sawPattern(5, branches, amp, 0, 2, 2);
		} else if (main.currBeat < 436) {
			sawPattern(4, branches, amp, 0, 2, 1);
			sawPattern(5, branches, amp, 0, 2, 1);
		} else if (main.currBeat < 444) {
			sawPattern(0, branches, amp, 0, 2, 2);
		} else if (main.currBeat < 452) {
			sawPattern(1, branches, amp, 0, 2, 2);
		} else if (main.currBeat < 460) {
			sawPattern(2, branches, amp, 0, 2, 2);
		} else if (main.currBeat < 468) {
			sawPattern(3, branches, amp, 0, 2, 2);
		}
		amp = .5;
		if (main.currBeat < 408) {
			sawPattern(0, branch2, amp, 0, 2, 7);
		} else if (main.currBeat < 412) {
			sawPattern(1, branch2, amp, 0, 2, 7);
		} else if (main.currBeat < 416) {
			sawPattern(2, branch2, amp, 0, 2, 7);
		} else if (main.currBeat < 420) {
			sawPattern(3, branch2, amp, 0, 2, 7);
		} else if (main.currBeat < 424) {
			sawPattern(4, branch2, amp, 0, 2, 7);
		} else if (main.currBeat < 428) {
			sawPattern(5, branch2, amp, 0, 2, 7);
		} else if (main.currBeat < 436) {
			sawPattern(4, branch2, amp, 0, 2, 4);
			sawPattern(5, branch2, amp, 0, 2, 4);
		} else if (main.currBeat < 444) {
			sawPattern(0, branch2, amp, 0, 2, 7);
		} else if (main.currBeat < 452) {
			sawPattern(1, branch2, amp, 0, 2, 7);
		} else if (main.currBeat < 460) {
			sawPattern(2, branch2, amp, 0, 2, 7);
		} else if (main.currBeat < 468) {
			sawPattern(3, branch2, amp, 0, 2, 7);
		}
	}
	if (beatInRange(464,504)) {
		if (beatE(464)) {
			cam.z.X = -de*2.5;
			cam.p.v.set(0,0,0);
			cam.p.P.set(cam.p.p);
			cam.pv.reset(0,0,0);
			cam.ang.P.set(0,0,0);
			cam.av.reset(0,0,0);
			roots.addGrid(roots.addC(-de,-de*1,0, de,-de*1,0, 39), 0,de*.2,0, 12);
			roots.addGrid(roots.addC(-de,-de*.33,0, de,-de*.33,0, 39), 0,de*.2,0, 12);
			roots.addGrid(roots.addC(-de,de*.33,0, de,de*.33,0, 39), 0,de*.2,0, 12);
			roots.addGrid(roots.addC(-de,de*1,0, de,de*1,0, 39), 0,de*.2,0, 12);
			root2.addGrid(root2.addC(-de,-de*1,0, de,de*.33,0, 39), 0,de*.2,0, 35);
			root2.addGrid(root2.addC(-de,-de*.33,0, de,de*1,0, 39), 0,de*.2,0, 35);
		}
		cam.ang.P.set(cos((float)frameCount*.01)*.15,sin((float)frameCount*.01)*.15,0);
		diamondPattern(branches, 2, .25);
		diamondPattern(branch2, 15, .5);
		// float amp = .5;
		// for (int i = 0 ; i < 1 ; i ++) {
		// 	branch2.add(1, amp,-amp,-amp, .25);
		// 	branch2.add(1, -amp,-amp,-amp, .25);
		// 	branch2.add(1, amp,amp,-amp, .25);
		// 	branch2.add(1, -amp,amp,-amp, .25);
		// 	branch2.add(1, amp,-amp,amp, .25);
		// 	branch2.add(1, -amp,-amp,amp, .25);
		// 	branch2.add(1, amp,amp,amp, .25);
		// 	branch2.add(1, -amp,amp,amp, .25);
		// }
	}
}