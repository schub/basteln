
_h=1.55;
_d=23.2;
_s=3;

_outer();

module _outer() {
	union() {
		difference() {
			cylinder(h=_h, r=_d/2);
			cylinder(h=_h, r=_d/2-_s);
			for (i=[0:19]) {
				rotate(a=[0, 0, i*18]) translate([_d/2-_s/2, 0, _h-0.5]) _star(0.3, 1.1, 0.5);
			}
		}
	}
}

module _star(r1, r2, h) {
	union() {
		for(i=[0:4]) {
			rotate(a=[0, 0, i*72]) _ray(r1, r2, h);
		}
	}
}

module _ray(r1, r2, h) {
	translate([0, 0, h/2]) {
		linear_extrude(height=h, center=true) {
			rotate(-90) polygon([[0,r2], [-r1,0], [r1,0]]);
		}
	}
}
