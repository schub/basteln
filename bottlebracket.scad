// ---------------------------------------------------
// imports
// ---------------------------------------------------
use <modules.scad>;

// ---------------------------------------------------
// properties
// ---------------------------------------------------

// increase resolution
$fn = 100;

nut_depth=4.05; // nut size for M5
screw_diameter=2.6;
min_border=4;
side_cw=2*min_border+2*nut_depth;
bottle_radius=47;
base_tube_radius=11.5;
base_tube_offset=4;


// ---------------------------------------------------
// shapes
// ---------------------------------------------------

_all();

//_front();
//_back();
//translate([0, 10, 0]) _back();


// test 
// translate([-2, -11.5, 11]) cube(4,4,4);


// ---------------------------------------------------
// modules
// ---------------------------------------------------

module _all() {
	difference() {
		union() {
			_base_fancy();
			translate([0, 23.5, 0]) scale([1.2, 1, 1]) cylinder(h=30, r=6);
		}
		translate([0, 24, 0]) cylinder(h=30, r=4.8);
		translate([-3.2, 24, 0]) cube([6.4, 6, 30]);
	}
}

module _front() {
	difference() {
		_all();
		translate([-50, 0, 0]) cube(100, 50, 40);
	}
}

module _back() {
	difference() {
		_all();
		translate([-50, -100, 0]) cube(100, 50, 40);
	}
}

module _base_fancy() {
	difference() {
		difference() {
			_base();
			_fancy();
			rotate(a=[0, 0, 180]) _fancy();			
		}
		rotate(a=[5, 0, 0]) translate([0, -6.5, 22]) _bottle();
	}
}

module _base(ro, ri, height) {
	difference() {
		union() {
			difference() {
				union() {
					scale([1.1, 0.7, 1]) cylinder(h=30, r=25);
					scale([0.7, 1, 1]) cylinder(h=30, r=25);
				}
				translate([0, base_tube_offset, 0]) cylinder(h=30, r=base_tube_radius);
			}
		}
		_nut(19, 15, -25, 30, 10, 20);
		_nut(-19, 15, -25, 30, 10, 20);
	}
}

module _bottle() {
	rotate(a=[0, 0, 180]) {
		union() {
			translate([0, bottle_radius+9, -25]) cylinder(h=50, r=bottle_radius);
			_nut(0, 0, -10, 40, 6);
		}
	}
}

module _nut(x=0, y=0, z=0, w=30, l=10, sdd=0) {
	rotate(a=[90, 0, 0]) {
		translate([x, y, z]) {
			screwWithNut(nr=nut_depth, nd=10, s=l, sd=sdd, st=screw_diameter, wp=w);
		}
	}
}

module _fancy() {
	translate([0, 0, 12.65]) difference() {
		cylinder(h=30, r=40);
		scale([0.7, 1, 1]) cylinder(h=30, r=25);
		translate([-50, -10, 0]) cube([100, 50, 50]);
	}
}



// ---------------------------------------------------
// trash
// ---------------------------------------------------