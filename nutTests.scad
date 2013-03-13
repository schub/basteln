// ---------------------------------------------------
// imports
// ---------------------------------------------------
use <modules.scad>;

$fn = 100;

difference() {
	cube([80, 10, 13]);
	_nutHole(8, 5);
	_nutHole(22, 5.05);
	_nutHole(36, 5.1);
	_nutHole(49, 4);
	_nutHole(61, 4.05);
	_nutHole(73, 4.1);
}

module _nutHole(dx=0, r=5) {
	rotate(a=[90, 0, 0]) {
		translate([dx, 8, -10]) {
			screwWithNut(nr=r, nd=7.5, s=3.5, sd=0, wp=10);
		}
	}
}

// this thing was printed and best Result:
// M5 => r=4.1
// M6 => r=5.05