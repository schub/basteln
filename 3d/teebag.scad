$fn=100;

_w=8;
_h=5;
_r=1.5;
_sl=20;
_do=115;
_di=80;
_wf=2;
_hf=4;
_lf=20;

translate([_sl, _sl, 0]) rotate(a=[0, 0, 45]) _f();

module _f() {
	difference() {
		_base();
		translate([-100, -100, -50]) cube([200, 200, 50]);
		_ecke();
	}
}

module _holder() {
	translate([-23, -15, 0]) {
		difference() {
			cylinder(h=2, r=7);
			cylinder(h=2, r=5);
		}
	}
}

module _base() {
	union() {
		_con([0, 0], [_do, 0]);
		_con([0, 0], [-_sl, -_sl]);
		_con([_do, 0], [_do+_sl, -_sl]);
		_middle();
		translate([_do/2 , 2.5, 0]) _fixation();
		_con([_do/2-_di/2+_h/2, 0], [_do/2-_di/2+_h/2, -25]);
		_con([_do/2+_di/2-_h/2, 0], [_do/2+_di/2-_h/2, -25]);
		_holder();
	}
}


module _con(a, b, h=_w, r=_h/2) {
	hull() {
		translate([a[0], a[1], 0]) cylinder(h=h, r=r);
		translate([b[0], b[1], 0]) cylinder(h=h, r=r);
	}
}

module _middle() {
	translate([_do/2, _h/2, _w/2]) rotate(a=[90, 0, 0]) cylinder(h=_h, r=_w);
}

module _fixation() {
	union() {
		_con([-2, -2], [4, 4], _hf, _wf);
		cylinder(h=_hf, r=_wf);
		translate([4, 4, 0]) rotate(a=[0, 0, 2]) {
			union() {
				_con([0, 0], [_lf, 0], _hf, _wf/2);
				for ( i = [0 : 4] ) {
					translate([i * _lf/4, 0, 0]) 
					cylinder(h=_hf, r=_wf);
				}
			}
		}
	}
}

module _ecke() {
	translate([_do/2, _h/2+1, _w/2]) rotate(a=[90, 0, 0]) {
		union() {
			_con([-1, 3], [-3.5, 10], _h+2, _r);
			_con([-1, 3], [-10, 10], _h+2, _r);
		}
	}
}