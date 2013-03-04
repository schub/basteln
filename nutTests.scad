// ---------------------------------------------------
// imports
// ---------------------------------------------------
use <modules.scad>;

$fn = 100;

difference() {
	cube([80, 10, 13]);
	rotate(a=[90, 0, 0]) translate([8, 8, -10]) screwWithNut(nr=5, nd=7.5, s=3.5, sd=0, wp=10);
	rotate(a=[90, 0, 0]) translate([22, 8, -10]) screwWithNut(nr=5.05, nd=7.5, s=3.5, sd=0, wp=10);
	rotate(a=[90, 0, 0]) translate([36, 8, -10]) screwWithNut(nr=5.1, nd=7.5, s=3.5, sd=0, wp=10);
	rotate(a=[90, 0, 0]) translate([49, 8, -10]) screwWithNut(nr=4, nd=7.5, s=3.5, sd=0, wp=10);
	rotate(a=[90, 0, 0]) translate([61, 8, -10]) screwWithNut(nr=4.05, nd=7.5, s=3.5, sd=0, wp=10);
	rotate(a=[90, 0, 0]) translate([73, 8, -10]) screwWithNut(nr=4.1, nd=7.5, s=3.5, sd=0, wp=10);
}
