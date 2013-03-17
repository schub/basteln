use <modules.scad>;

// increase resolution
$fn = 100;


// ---------------------------------------------------
// properties
// ---------------------------------------------------

hCon=3;	// height of the connectors
hSockel=8;	// height of the sockel
radius=3;
strength=8;
radiusScrew=0.8;
radiusScrew2=1.2;

// these values are based on arduino leonardo
// 
// values in mil:
// 		p1=[600, 2000]		// top left
// 		p2=[2600, 300];	// bottom right
// 		p3=[550, 100];		// bottom left
// 		p4=[2600, 1400];	// top right
// values in mm:
// 		p1=[15.24, 50.8]
// 		p2=[66.04, 7.62];
// 		p3=[13.97, 2.54];
// 		p4=[66.04, 35.56];


b1=[[15.24, 50.8], [66.04, 7.62]];
b2=[[13.97, 2.54],[66.04, 35.56]];


// ---------------------------------------------------
// preprocessing
// ---------------------------------------------------

_dx1=b1[1][0]-b1[0][0];
_dy1=b1[1][1]-b1[0][1];

_dx2=b2[1][0]-b2[0][0];
_dy2=b2[1][1]-b2[0][1];

_l1=sqrt(pow(_dx1, 2) + pow(_dy1, 2));
_l2=sqrt(pow(_dx2, 2) + pow(_dy2, 2));

_a1=270+asin(_dx1/_l1);
_a2=90-asin(_dx2/_l2);

// compute straight function for first two points

//     y2 - y1
// a = ———————
//     x2 - x1
//
// b  =  y2 - a·x2

_sa1=(b1[1][1]-b1[0][1])/(b1[1][0]-b1[0][0]);
_sb1=b1[0][1]-b1[0][0]*_sa1;

_m1=[47.371,23.622];	// guessing... => somehow I screwd up the calculation


// ---------------------------------------------------
// model
// ---------------------------------------------------


_all();

// ---------------------------------------------------
// shapes
// ---------------------------------------------------

module _all() {
	difference() {
		union() {
			_cons();
			translate([_m1[0], _m1[1], 0]) cylinder(r=strength+2, h=hCon);
		}
		translate([_m1[0], _m1[1], 0]) cylinder(r=radiusScrew2, h=hCon);
		translate([_m1[0], _m1[1], hCon-1.5]) cylinder(r1=radiusScrew2, r2=7, h=hCon);
	}
}

module _cons() {
	union() {
		_con(b1, _l1, _a1);
		_con(b2, _l2, _a2);
	}
}

module _con(p, l, a) {
	union() {
		_conBase(p, l, a);
		_conPins(p);
	}
}

module _conBase(p, l, a) {
	translate([p[0][0], p[0][1], 0]) {
		rotate(a=[0, 0, a]) {
			union() {
				cylinder(h=hCon, r=strength/2);
				translate([0, -strength/2, 0]) cube([l, strength, hCon]);
				translate([l, 0, 0]) cylinder(h=hCon, r=strength/2);
			}
		}
	}
}

module _conPins(p) {
	union() {
		difference() {
			translate([p[0][0], p[0][1], 0]) cylinder(h=hSockel, r=radius);
			translate([p[0][0], p[0][1], 0]) cylinder(h=hSockel, r=radiusScrew);
		}
		difference() {
			translate([p[1][0], p[1][1], 0]) cylinder(h=hSockel, r=radius);
			translate([p[1][0], p[1][1], 0]) cylinder(h=hSockel, r=radiusScrew);
		}
	}
}
