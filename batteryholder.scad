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

width=83;				// inner width
height=25;				// inner height
depth=35;				// inner depth
strength=3;			// strength of the case
screw_diameter=2.6;	// screw diameter
angle=10;				// cut angle

// ---------------------------------------------------
// shapes
// ---------------------------------------------------

_saveMaterial();

module _saveMaterial() {
	difference() {

		_base();

		// cut out left material
		for (i=[0:3]) translate([0, 3.5+i*9, 3]) _cutOutY(size=height-8);

		// cut out front material
		for (i=[0:8]) translate([5+i*9, 0, 3]) _cutOutX(size=(height-8-i*tan(angle)*9));

		// cut out right material
		for (i=[0:3]) translate([width+strength, 3.5+i*9, 3]) _cutOutY(size=height-8-tan(angle)*width);

		// cut out back material
		for (i=[0:8]) translate([5+i*9, depth+strength, 3]) _cutOutX(size=height-8);

		// cut out bottom material
		for (x=[0:2]) for (y=[0:3]) translate([4+x*28, 4+y*9, 0]) _cutOutZ(size=20);
	}
}

module _base() {
	difference() {
		difference() {
			cube([width + 2*strength, depth + 2*strength, height+strength]);
			translate([strength, strength, strength]) cube([width, depth, height]);
		}
		_cut();
	}
}

module _cutOutX(he=strength+2, size=20) {
	translate([0, strength, 0]) rotate(a=[0, 0, -90]) {
		_cutOutY(he, size);
	}
}

module _cutOutZ(he=strength+2, size=width-2*strength-1) {
	translate([size+strength+2, 0, 0]) rotate(a=[0, -90, 0]) {
		_cutOutY(he, size);
	}
}

module _cutOutY(he=strength+2, size=20) {
	translate([-1, screw_diameter, size+screw_diameter]) {
		rotate(a=[0, 90, 0]) {
			union() {
				cylinder(h=he, r=screw_diameter);
				translate([size, 0, 0]) cylinder(h=he, r=screw_diameter);
				translate([0, -screw_diameter, 0]) cube([size, screw_diameter*2, strength+2]);
			}
		}
	}
}

module _cut() {
	translate([strength, -strength, height+strength]) {
		rotate(a=[0, angle, 0]) cube([2*width, depth + strength*2 ,2*height]);
	}
}

