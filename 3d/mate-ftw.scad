$fn=100;

_r1=36.85;
_r2=26.15;
_h=39;
_d=1.3;

difference() {
	translate([0, 0, -20]) _foo();
	_cut1();
}

module _foo() {
	difference() {
		difference() {
			cylinder(h=_h, r1=_r1/2+_d, r2=_r2/2+_d);
			cylinder(h=_h, r1=_r1/2, r2=_r2/2);
		}
		translate([-50, 12, -20]) rotate(a=[7, 0, 0]) cube([100, 50, 70]);
		translate([-50, -50, 45]) cube(100);
		translate([-50, -50, -80]) cube(100);
	}
}

module _cut1() {
	for (i=[-2:2]) {
		rotate(a=[55, 0, i*40]) cylinder(h=54, r=2);
	}
}
