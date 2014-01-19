use <3rdparty.scad>;

// module library

// tube - make a tube
//
// ro = outer radius
// ri = inner radius
// height = height
//
module tube(ro, ri, height) {
	difference() {
		cylinder(h=height, r=ro);
		cylinder(h=height, r=ri);
	}
}

module nutDummy(nr=5, nd=6.5) {
	translate([0, 0, nd/2]) hexagon(length=nr, depth=nd);
}

// screwWithNut - draws a screw with nut. the object is placed
//                in z-direction centered at the origin
// 
// nr: radius of the nut
// nd: nut depth
// s:  space between nut and screen head
// sd: srew depth
// sr: screwRadius
// wp: with projection
// 
module screwWithNut(nr=5, nd=6.5, s=4, sd=6.5, sr=2.6, wp=0) {
	union() {
		translate([0, 0, sd/2]) hexagon(length = nr, depth = sd);
		translate([0, 0, sd]) cylinder(h=s, r=sr);
		translate([0, 0, s + nd/2 + sd]) hexagon(length = nr, depth = nd);
		if (wp > 0) {
			translate([-nr, 0, 0]) cube([2*nr, wp, sd]);
			translate([-nr, 0, s + sd]) cube([2*nr, wp, nd]);
		}
	}
}

module ring(r1, r2) {
	rotate_extrude(convexity = 10) {
		translate([r1+((r2-r1)/2), 0, 0]) circle((r2-r1)/2);
	}
}

module rCube(v, r=3) {
	hull() {
		translate([r, r, r]) sphere(r);
		translate([v[0]-r, r, r]) sphere(r);
		translate([v[0]-r, v[1]-r, r]) sphere(r);
		translate([r, v[1]-r, r]) sphere(r);
		translate([r, r, v[2]-r]) sphere(r);
		translate([v[0]-r, r, v[2]-r]) sphere(r);
		translate([v[0]-r, v[1]-r, v[2]-r]) sphere(r);
		translate([r, v[1]-r, v[2]-r]) sphere(r);
	}
}

module rCylinder(radius, height, rounding) {
	hull() {
		translate([0, 0, rounding]) {
			rotate_extrude(convexity = 10) {
				translate([radius, 0, 0]) { 
					circle(rounding/2);
				}
			}
		}
		translate([0, 0, 5-rounding]) {
			rotate_extrude(convexity = 10) {
				translate([radius, 0, 0]) { 
					circle(rounding/2);
				}
			}
		}
	}
}


// ----------------------------------------------------------------------------------
// batteries
// ----------------------------------------------------------------------------------


bAARadius=14.3/2;
bAAHeight=51;
bAAARadius=14.3/2;
bAAAHeight=51;
bConRadius=2;
bConHeight=2;

module battery(radius, height) {
	cylinder(r=radius, h=height-bConHeight);
	translate([0, 0, height-bConHeight]) cylinder(r=bConRadius, h=bConHeight);
}

module batteryAA() {
	battery(r=bAARadius, h=bAAHeight);
}

module batteryAAA() {
	battery(r=bAAARadius, h=bAAAHeight);
}

