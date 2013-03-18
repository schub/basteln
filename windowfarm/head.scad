use <modules.scad>;

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

//ring(r1=20, r2=25);
//rotate_extrude(file="circle_20_5.dxf");
//cylinder(h=20, r=15);

//translate([50, 0, 0]) ring(r1=5.5, r2=24);
//rotate_extrude(file="circle_15_9.dxf");
//cylinder(h=20, r=10.5);

_all();

//_rod();
//_head();

// ---------------------------------------------------
// helpers
// ---------------------------------------------------

//translate([-19.5, -50, 0]) cube([2, 100, 100]);


// ---------------------------------------------------
// modules
// ---------------------------------------------------



module _all() {
	difference() {
		translate([0, 0, 28]) _head();
		_rod();
	}
}

module _rod() {
	union() {
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
		//translate([-50, -50, 35.5]) cube([100, 100, 1]);
		hull() {
			cylinder(h=50, r=_rRod/2+1);
			translate([-5, 0, 0]) cylinder(h=50, r=_rRod/2+1);
		}
	}
}




module _head() {
	
	difference() {
		_headBase();
		translate([0, 0, -30]) cylinder(h=30, r=_rRod);
		//translate([-50, -50, -100]) cube([100, 100, 100]);
		//translate([-15-_rWt, 0, -20]) cylinder(h=20, r=_rWt);
	}

	translate([0, 0, -20]) cylinder(h=20, r=15);

}

module _headBase() {
	rotate(a=[90, 0, 0]) {
		difference() {
			union() {
				difference() {
					// rotate_extrude(file="circle_15_9.dxf");
					ring(r1=15, r2=24);
					translate([-50, -100, -50]) cube(100);
				}
				sphere(_rRod+_rWt/2);
				difference() {
					translate([15, 2, 0]) rotate(a=[-90, 0, 0]) cylinder(h=2, r=11);
					translate([-50, -98, -50]) cube(100);
					translate([15+_rWt, -18, 0]) rotate(a=[-90, 0, 0]) cylinder(h=20, r=_rWt);
				}
				translate([15, -18, 0]) rotate(a=[-90, 0, 0]) cylinder(h=20, r1=0.1, r2=11);
				difference() {
					translate([-15, 2, 0]) rotate(a=[-90, 0, 0]) cylinder(h=2, r=11);
					translate([-50, -98, -50]) cube(100);
					translate([-15-_rWt, -18, 0]) rotate(a=[-90, 0, 0]) cylinder(h=20, r=_rWt);
				}
				translate([-15, -18, 0]) rotate(a=[-90, 0, 0]) cylinder(h=20, r1=0.1, r2=11);
			}
			// rotate_extrude(file="circle_20_5.dxf");
			ring(r1=20, r2=25);
		}
	}
}
