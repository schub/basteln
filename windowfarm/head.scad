//$fn=100;





// ---------------------------------------------------
// properties
// ---------------------------------------------------
_rWt=5;		// radius of water tube
_rRod=12.5;	// radius of rod
_hRod=35;		// height of rod head

// ---------------------------------------------------
// model
// ---------------------------------------------------

//_rod();

_head();

// ---------------------------------------------------
// helpers
// ---------------------------------------------------

//translate([-19.5, -50, 0]) cube([2, 100, 100]);


// ---------------------------------------------------
// modules
// ---------------------------------------------------

module _rod() {
	difference() {
		union() {
			translate([0, 0, _hRod-_rRod]) sphere(_rRod);
			cylinder(r=_rRod, h=_hRod-_rRod);
			translate([0, 0, _hRod-_rRod]) { 
				rotate(a=[0, -85, 0]) cylinder(r1=_rRod, r2=_rRod-1, h=_hRod-_rRod);
			}
		}
		translate([-124, -50, 0]) rotate(a=[0, 14, 0]) cube([100, 100, 100]);
	}
}

module _head() {
	
	difference() {
		_headBase();
		translate([0, 0, -30]) cylinder(h=30, r=_rRod);
		//translate([-50, -50, -100]) cube([100, 100, 100]);
	}

	translate([0, 0, -20]) cylinder(h=20, r=15);

}

module _headBase() {
	rotate(a=[90, 0, 0]) {
		difference() {
			union() {
				difference() {
					rotate_extrude(file="circle_15_9.dxf");
					translate([-50, -100, -50]) cube(100);
				}
				sphere(_rRod+_rWt/2);
				translate([-15, 2, 0]) sphere(r=12);
				translate([15, 2, 0]) sphere(r=12);
			}
			rotate_extrude(file="circle_20_5.dxf");
		}
	}

}
