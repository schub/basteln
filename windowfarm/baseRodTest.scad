// testing different diameters for the base rod

$fn=100;

difference() {
	union() {
		_test(11.5);
		translate([28, 0, 0]) _test(11.75);
		translate([56, 0, 0]) _test(12);
		translate([84, 0, 0]) _test(12.25);
	}
	translate([-30, 0, 0]) cube([150, 60, 5]);
}

module _test(ir) {
	difference() {
		cylinder(h=3, r=ir + 4);
		cylinder(h=3, r=ir);
	}
}
