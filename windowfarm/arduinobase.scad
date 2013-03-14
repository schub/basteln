// increase resolution
//$fn = 100;


// ---------------------------------------------------
// properties
// ---------------------------------------------------

hCon=3;	// height of the connectors
hSockel=8;	// height of the sockel
radius=3;
strength=10;
radiusScrew=1;

b1=[[15,5],[50,50]];
b2=[[50,5],[5,50]];

// ---------------------------------------------------
// preprocessing
// ---------------------------------------------------

_dx1=b1[1][0]-b1[0][0];
_dy1=b1[1][1]-b1[0][1];

_dx2=b2[1][0]-b2[0][0];
_dy2=b2[1][1]-b2[0][1];

_l1=sqrt(pow(_dx1, 2) + pow(_dy1, 2));
_l2=sqrt(pow(_dx2, 2) + pow(_dy2, 2));

_a1=90-asin(_dx1/_l1);
_a2=90-asin(_dx2/_l2);

// compute straight function for first two points

//     y2 - y1
// a = ———————
//     x2 - x1
//
// b  =  y2 - a·x2

_sa1=(b1[1][1]-b1[0][1])/(b1[1][0]-b1[0][0]);
_sb1=b1[0][1]-b1[0][0]*_sa1;

echo(_sa1, _sb1);

for(i=[-5:20]) {
	translate([i*5, i*_sa1+_sb1, 0]) cylinder(h=8, r=0.8);
}

for(i=[-5:20]) {
	translate([i*5, i*5, 0]) cylinder(h=12, r=1.2);
}

// ---------------------------------------------------
// shapes
// ---------------------------------------------------

_con(b1, _l1, _a1);
_con(b2, _l2, _a2);


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
