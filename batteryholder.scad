// increase resolution
$fn = 100;


// ---------------------------------------------------
// original size of battery pack:
// width = 7.83
// height = 5.83
// depth = 3.1
// ---------------------------------------------------


// ---------------------------------------------------
// properties
// ---------------------------------------------------

width=60;				// inner width
height=25;				// inner height
depth=30;				// inner depth
strength=3;			// strength of the case
screw_diameter=2.6;	// screw diameter
angle=20;				// cut angle


// ---------------------------------------------------
// shapes
// ---------------------------------------------------

difference() {
	base();
	cut();
}

module base() {
	difference() {
		cube([width + 2*strength, depth + 2*strength, height+strength]);
		translate([strength, strength, strength]) cube([width, depth, height]);
	}
}

module cut() {
	union() {
		translate([strength, 0, height+strength]) {
			rotate(a=[0, angle, 0]) cube([2*width, depth + strength ,2*height]);
		}
		translate([width/2, 1.5*depth, height-2*screw_diameter]) { 
			rotate(a=[90, 0, 0]) cylinder(h=depth, r=screw_diameter);
		}
		translate([width-2*screw_diameter, 1.5*depth, height-2*screw_diameter]) { 
			rotate(a=[90, 0, 0]) cylinder(h=depth, r=screw_diameter);
		}
	}
}