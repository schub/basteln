


// properties

$fn=100;

edgeLength=5;


// programm

translate([0, 0, 0]) holder2();
translate([50, 0, 0]) holder3();
translate([100, 0, 0]) holder4();



// modules

module holder3() {
	difference() {
		union() {
			invader2();
			translate([0, 0, 0.5*edgeLength]) {
				_cube(3, -1);
			}
			_cube(0, -1);
			_cube(1, -1);
			_cube(5, -1);
			_cube(6, -1);
			hull() {
				translate([0, 0, 1.5*edgeLength]) {
					_cube(3,-1);
				}
				translate([0, 0.5*edgeLength, 2*edgeLength]) {
					_cube(3,-1);
				}
			}
		}
		translate([3.5*edgeLength, 2*edgeLength, 0]) {
			cylinder(h=edgeLength, r=1.5);
		}
	}
}

module holder4() {
	difference() {
		union() {
			invader2();
			translate([0, 0, 0.5*edgeLength]) {
				_cube(3, -1);
			}
			hull() {
				translate([0, 0, 1.5*edgeLength]) {
					_cube(3,-1);
				}
				translate([0, 0.5*edgeLength, 2*edgeLength]) {
					_cube(3,-1);
				}
			}
		}
		translate([3.5*edgeLength, 2*edgeLength, 0]) {
			cylinder(h=edgeLength, r=1.5);
		}
	}
}

module holder2() {
	difference() {
		union() {
			invader2();
			hull() {
				translate([0, 0, 1*edgeLength]) {
					_cube(3,-0.5);
				}
				translate([0, 0.5*edgeLength, 2*edgeLength]) {
					_cube(3,-0.5);
				}
			}
		}
		translate([3.5*edgeLength, 2*edgeLength, 0]) {
			cylinder(h=edgeLength, r=1.5);
		}
		translate([0, -1.5*edgeLength, 0]) cube([50, edgeLength, edgeLength]);
	}
}

module _cube(x, y) {
	translate([x*edgeLength, y*edgeLength, 0]) {
		cube([edgeLength, edgeLength, edgeLength]);
	}
}



module invader1() {
	union() {
		_cube(0, 0);
		_cube(0, 1);
		_cube(0, 2);
		_cube(1, 2);
		_cube(1, 3);
		_cube(1, 4);
		_cube(2, 1);
		_cube(2, 2);
		_cube(2, 4);
		_cube(2, 5);
		_cube(3, 2);
		_cube(3, 3);
		_cube(3, 4);
		_cube(4, 1);
		_cube(4, 2);
		_cube(4, 4);
		_cube(4, 5);
		_cube(5, 2);
		_cube(5, 3);
		_cube(5, 4);
		_cube(6, 0);
		_cube(6, 1);
		_cube(6, 2);
	}	
}

module invader2() {
	union() {
		_cube(0, 0);
		_cube(0, 1);
		_cube(0, 2);
		_cube(1, 2);
		_cube(1, 3);
		_cube(1, 4);
		_cube(2, 1);
		_cube(2, 2);
		_cube(2, 4);
		_cube(2, 5);
		_cube(3, -1);
		_cube(3, 0);
		_cube(3, 1);
		_cube(3, 2);
		_cube(3, 3);
		_cube(3, 4);
		_cube(4, 1);
		_cube(4, 2);
		_cube(4, 4);
		_cube(4, 5);
		_cube(5, 2);
		_cube(5, 3);
		_cube(5, 4);
		_cube(6, 0);
		_cube(6, 1);
		_cube(6, 2);
	}	
}