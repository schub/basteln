$fn=100;

os=25;	// offset

union() {
	cube([200, 170, 15]);
	translate([15, -os, 15+os]) cube([170, 15, 155]);
	translate([15, 155-22+os, 15+os]) cube([170, 15, 155]);
	translate([-os, 0, 15+os]) cube([15, 170, 155]);
	translate([185+os, 0, 15+os]) cube([15, 170, 155]);
}
