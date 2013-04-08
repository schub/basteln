$fn=100;

_r1=36.85;
_r2=26.15;
_h=39;
_d=2;

difference() {
	translate([0, 0, -20]) _foo();
	_cut1();
}

module _foo() {
	difference() {
		difference() {
			cylinder(h=_h, r1=_r1+_d, r2=_r2+_d);
			cylinder(h=_h, r1=_r1, r2=_r2);
		}
		translate([-50, 20, -20]) rotate(a=[10, 0, 0]) cube([100, 50, 70]);
		translate([-50, -50, 45]) cube(100);
		translate([-50, -50, -80]) cube(100);
	}
}

module _cut1() {
	for (i=[-3:3]) {
		rotate(a=[70, 0, i*25]) cylinder(h=50, r=2);
	}
}

module invader1() {
	
}
