use <modules.scad>;

$fn=100;

difference() {
	union() {
		translate([0, 0, 40]) sphere(10);
		cylinder(h=40, r=10);
	}
	translate([43, 0, 35]) rotate(a=[45, 0, 0]) ring(r1=40, r2=51);
	translate([49, -75, 0]) tube(ro=91, ri=89, height=15);
	translate([10, -14, 7.5]) rotate(a=[0, 90, 124]) cylinder(h=30, r=2.6);
}
