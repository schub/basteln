
$fn=100;

dOuterSmall=12.5/2;
dOuterBig=13.5/2;

dInnerSmall=9.5/2;
dInnerBig=10.5/2;

dDepth=3/2;
dHeight=10;


//tFitting_10_2x13();
terminator_13();


module tFitting_10_2x13() {
	translate([0, 0, dOuterSmall]) _all();
}

module terminator_13() {
	terminator(dHeight, dOuterSmall, dOuterBig);
}




module terminator(height, small, big) {
	cylinder(h=height, r1=small, r2=big);
	translate([0, 0, height]) cylinder(h=height, r1=small, r2=big);
	translate([0, 0, 2*height]) cylinder(h=height, r1=small, r2=big);
	translate([0, 0, 3*height]) cylinder(h=3, r1=big, r2=big+3);
	translate([0, 0, 3*height+3]) cylinder(h=1.5, r=big+3);
}


module _all() {
	difference() {
		_connections();
		translate([-100, -100, -200-dOuterSmall]) cube(200);
		_star();
		translate([-100, -100, dOuterBig]) cube(200);
	}
}

module _star() {
	union() {
		hull() {
			translate([0, 0, 0]) sphere(r=dOuterSmall-dDepth);
			translate([-5*dHeight, 0, dInnerSmall-dOuterSmall]) sphere(r=dInnerSmall-dDepth);
		}
		rotate(a=[0, 90, 135+180]) cylinder(r=dOuterSmall-dDepth, h=100);
		rotate(a=[0, 90, 225+180]) cylinder(r=dOuterSmall-dDepth, h=100);
	}
}

module _connections() {
	union() {
		scale([1.4, 1, 1]) sphere(r=20);
		translate([-5*dHeight, 0, dInnerSmall-dOuterSmall]) _fitting(dHeight, dInnerSmall, dInnerBig);
		rotate(a=[0, 0, 135]) translate([-5*dHeight, 0, 0]) _fitting(dHeight, dOuterSmall, dOuterBig);
		rotate(a=[0, 0, 225]) translate([-5*dHeight, 0, 0]) _fitting(dHeight, dOuterSmall, dOuterBig);
	}
}

module _fitting(height, small, big) {
	rotate(a=[0, 90, 0]) {
		union() {
			cylinder(h=height, r1=small, r2=big);
			translate([0, 0, 1*height]) cylinder(h=height, r1=small, r2=big);
			translate([0, 0, 2*height]) cylinder(h=height, r1=small, r2=big);
			translate([0, 0, 3*height]) cylinder(h=height, r1=small, r2=big);
		}
	}
}
