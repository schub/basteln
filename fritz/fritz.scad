// fritz robo


// screws and nuts
include <polyScrewThread.scad>


$fn=50;

// AAA
_aaaD=10.3;
_aaaH=45;

// 1/2 AA
_05aaD=14.5;
_05aaH=24;

_l = [100, 106, 120, 135, 111, 80];
_w = [120, 125, 130, 133, 127, 100];
_ow = [0,  0, -4, -9, 1, 7];
_dw = 1.1; // 20 percent
_h = [0, 13, 36, 65, 145, 162];
_n = [false, false, true, true, true];
_slope = 5;
_num = 5;
_sr = 3;
_dNeck = 70;
_hNeck = 12;

_hHead = 65;
_wHead = 90;
_lHead = 125;

_dArm = 15;


_all();
//_roboHead();
//_armR();


module _all() {
	union() {
		_roboBody();
		translate([-_wHead/2, 6, _h[5]+_hNeck]) {
			_roboHead();
		}
		_con1();
		translate([-95, 0, 100]) {
			rotate(a=[-90, 0, -90]) _armR();
		}
	}
}

module _con1() {
	translate([0, 6, 0]) {
		cylinder(h=200, r=_dNeck/2);
	}
}

module _roboBody() {
	union() {
		for ( i = [0 : _num-1] ) {
			_baseCube(i);
		}
	}
}

module _baseCube(i) {
	union() {
		if (_n[i]) {
			hull() {
				translate([0, _ow[i], _h[i]]) { 
					_basePlate(_w[i], _w[i]*_dw, _l[i], _sr);
				}
				translate([0, _ow[i+1], _h[i+1]] ) {
					_basePlate(_w[i+1], _w[i+1]*_dw, _l[i+1], _sr);
				}
			}
		} else {
			hull() {
				translate([0, _ow[i], _h[i]]) { 
					_basePlate(_w[i], _w[i]*_dw, _l[i], _sr);
				}
				translate([0, _ow[i], _h[i+1]]) { 
					_basePlate(_w[i], _w[i]*_dw, _l[i], _sr);
				}
			}
			hull() {
				translate([0, _ow[i], _h[i+1]-_slope]) { 
					_basePlate(_w[i], _w[i]*_dw, _l[i], _sr);
				}
				translate([0, _ow[i+1], _h[i+1]] ) {
					_basePlate(_w[i+1], _w[i+1]*_dw, _l[i+1], _sr);
				}
			}
		}
	}
}

module _basePlate(w1, w2, l1, sr=1) {
	translate([-w1/2, -l1/2]) {
		hull() {
			translate([0,  0, 0]) sphere(r=sr);
			translate([w1, 0, 0]) sphere(r=sr);
			translate([0,  l1, 0]) sphere(r=sr);
			translate([w1, l1, 0]) sphere(r=sr);
			translate([0-(w2-w1)/2, l1/2, 0]) sphere(r=sr);
			translate([w2-(w2-w1)/2, l1/2, 0]) sphere(r=sr);
		}
	}
}

module _accu1() {
	cylinder(h=_aaaH, r=_aaaD/2);
}

module _accu2() {
	cylinder(h=_05aaH, r=_05aaD/2);
}

/* head
 *
 *
 */

module _roboHead() {
	union() {
		hull() {
			_roboHeadSide1();
			translate([_wHead, 0, 0]) _roboHeadSide1();
		}
		translate([_wHead/4, -65, 35]) {
			rotate(a=[-90, 0, 0]) _eye(13, 17, 50);
		}
		translate([3*_wHead/4, -65, 35]) {
			rotate(a=[-90, 0, 0]) _eye(13, 17, 50);
		}
		hull() {
			translate([-5, 0, 0]) _roboHeadSide2();
			translate([_wHead+5, 0, 0]) _roboHeadSide2();
		}
		hull() {
			translate([-5, 0, 0]) _roboHeadSide3();
			translate([_wHead+5, 0, 0]) _roboHeadSide3();
		}
	}
}

module _roboHeadSide1() {
	hull() {
		sphere(r=_sr);
		translate([0, -42, 0]) sphere(r=_sr);
		translate([0, -57, 15]) sphere(r=_sr);
		translate([0, -42, 60]) sphere(r=_sr);
		translate([0, 0, 66]) sphere(r=_sr);
		translate([0, 50, 3]) sphere(r=_sr);
		translate([0, 37, 63]) sphere(r=_sr);
		translate([0, 48, 41]) sphere(r=_sr);
	}
}

module _roboHeadSide2() {
	hull() {
		translate([0, -24, 15]) sphere(r=_sr);
		translate([0, 53, 15]) sphere(r=_sr);
		translate([0, 0, 66]) sphere(r=_sr);
		translate([0, 48, 41]) sphere(r=_sr);
		translate([0, 37, 63]) sphere(r=_sr);
		translate([0, -37, 56]) sphere(r=_sr);
	}
}

module _roboHeadSide3() {
	hull() {
		translate([0, -32, 52]) sphere(r=_sr);
		translate([0, -53, 60]) sphere(r=_sr);
		translate([0, 0, 66]) sphere(r=_sr);
	}
}

module _eye(r1, r2, l) {
	difference() {
		union() {
			difference() {
				cylinder(h=l, r=r2);
				cylinder(h=l, r=r1);
			}
			rotate_extrude(convexity = 10) {
				translate([r1 + (r2-r1)/2, 0, 0]) {
					circle(r = (r2-r1)/2);
				}
			}
			translate([0, 0, r1*2-4]) sphere(r=r1*2);
			cylinder(h=l, r=r1);
		}
		translate([0, 0, -l]) difference() {
			cylinder(h=3*l, r=r2*10);
			cylinder(h=3*l, r=r2);
		}
	}
}


module _armR() {
	difference() {
		union() {
			cylinder(r=28, h=_dArm);
			translate([61, 17, 0]) cylinder(r=21, h=_dArm);
			hull() {
				translate([0, 0, 0]) cylinder(r=16, h=_dArm);
				translate([61, 17, 0]) cylinder(r=16, h=_dArm);
			}
			hull() {
				translate([61, 17, 0]) cylinder(r=16, h=_dArm);
				translate([126, 0, 0]) cylinder(r=16, h=_dArm);
			}
			translate([126, 0, 0]) cylinder(r=28, h=_dArm);
			cylinder(h=12, r=24);
			cylinder(h=20, r=20);
		}
		translate([126, 0, 0]) {
			cylinder(r=21, h=_dArm);
			hull() {
				cylinder(h=_dArm, r=1);
				translate([50, -45, 0]) cylinder(h=_dArm, r=1);
				translate([50, 15, 0]) cylinder(h=_dArm, r=1);
			}
		}
	}
}



