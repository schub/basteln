/* ********************************************************************
 * Space Invader Hooks
 * 
 * Generate your own cloth hooks. Tweak parameters, create your own
 * hooks or use the predefined modules.
 *
 * ******************************************************************** */

// preview[view:south, tilt:top]

// ------------------------------------------------------------------
// --- parameter ----------------------------------------------------
// ------------------------------------------------------------------

/* [Global] */

// choose a space invader
spaceInvader = 5; // [1,2,3,4,5,6]

// pixel size
edgeLength = 5;

// thickness of the hook
strength = 4;

// radius of the hole
holeRadius = 1.5;


/* [Advanced] */

// resolution
$fn=50;

// make a hole or not
make_hole = "yes"; // [yes,no]

// make a hook or just the base space invader
make_hook = "yes"; // [yes,no]

// use to avoid loonely pixel
minkowski_factor=10;



/* [Hidden] */

// ------------------------------------------------------------------
// --- space invader versions ---------------------------------------
// --- a vector of 2d coordinates; hole and hook position -----------
// ------------------------------------------------------------------

// space invader 1 parameter
si_1=[[0,0,1,0,1,0,0],[0,1,1,1,1,1,0],[0,1,0,1,0,1,0],[1,1,1,1,1,1,1],[1,0,1,0,1,0,1],[1,0,0,0,0,0,1]];
si_1_hole=[3,2];
si_1_hook=[3,4];

// space invader 2 parameter
si_2=[[0,0,1,0,1,0,0],[0,1,1,1,1,1,0],[0,1,0,1,0,1,0],[1,1,1,1,1,1,1],[1,0,1,1,1,0,1],[1,0,0,1,0,0,1]];
si_2_hole=[3,3];
si_2_hook=[3,5];

// space invader 3 parameter
si_3=[[0,0,1,0,1,0,0],[0,1,1,1,1,1,0],[0,1,0,1,0,1,0],[1,1,1,1,1,1,1],[1,0,1,1,1,0,1],[1,0,0,1,0,0,1],[0,0,0,1,0,0,0]];
si_3_hole=[3,3];
si_3_hook=[3,6];

// space invader 5 parameter
si_4=[[0,0,1,0,1,0,0],[0,1,1,1,1,1,0],[0,1,0,1,0,1,0],[1,1,1,1,1,1,1],[1,0,1,1,1,0,1],[1,0,0,1,0,0,1],[1,1,0,1,0,1,1]];
si_4_hole=[3,3];
si_4_hook=[3,6];

// space invader 5 parameter
si_5=[[0,0,1,1,0,1,1,0,0],[0,1,1,1,1,1,1,1,0],[0,1,0,0,1,0,0,1,0],[1,1,0,0,1,0,0,1,1],[1,1,1,1,1,1,1,1,1],[0,0,1,1,1,1,1,0,0],[0,1,1,0,1,0,1,1,0],[1,1,0,0,0,0,0,1,1]];
si_5_hole=[4,4];
si_5_hook=[4,6];

si_6=[[0,0,1,0,0,0,0,0,1,0,0],[0,0,0,1,0,0,0,1,0,0,0],[0,0,1,1,1,1,1,1,1,0,0],[0,1,1,0,1,1,1,0,1,1,0],[1,1,1,1,1,1,1,1,1,1,1],[1,0,1,1,1,1,1,1,1,0,1],[1,0,1,0,0,0,0,0,1,0,1],[0,0,0,1,1,0,1,1,0,0,0]];
si_6_hole=[5,3];
si_6_hook=[5,5];

// ------------------------------------------------------------------
// --- programm -----------------------------------------------------
// ------------------------------------------------------------------

if (spaceInvader == 1) {
	complete_hook(si_1, si_1_hole, si_1_hook);
} else if (spaceInvader == 2) {
	complete_hook(si_2, si_2_hole, si_2_hook);
} else if (spaceInvader == 3) {
	complete_hook(si_3, si_3_hole, si_3_hook);
} else if (spaceInvader == 4) {
	complete_hook(si_4, si_4_hole, si_4_hook);
} else if (spaceInvader == 5) {
	complete_hook(si_5, si_5_hole, si_5_hook);
} else if (spaceInvader == 6) {
	complete_hook(si_6, si_6_hole, si_6_hook);
}


// ------------------------------------------------------------------
// --- invader modules ----------------------------------------------
// ------------------------------------------------------------------


module invader1() {
	_invader(sp1, [3,2], [3,4]);
}

module invader2() {
	_invader(sp2, [3,-1], [3,2]);
}

module invader3() {
	_invader(sp3, [3,-1], [3,2]);
}

module invader4() {
	_invader(sp4, [4,1], [4,3]);
}



// ------------------------------------------------------------------
// --- modules ------------------------------------------------------
// ------------------------------------------------------------------



module complete_hook(matrix, hole, hook) {
	difference() {
		union() {
			hook_base(matrix);
			if (make_hook == "yes") {
				hook(hook[0], hook[1]);
			}
		}
		if (make_hole == "yes") {
			hook_hole_positive(hole[0], hole[1], 1);
		}
	}
}


module hook_base(data) {
	for (y = [0:len(data)]) {
		for(x = [0:len(data[y])]) {
			_cube(x,y,data[y][x]);
		}
	}
}

// builds a cube at specified position
//
module _cube(x, y, h) {
	translate([x*edgeLength, -y*edgeLength, 0]) {
		if (h > 0) {
			cube([edgeLength, edgeLength, strength*h]);
			/*
			minkowski()
			{
				cube([edgeLength, edgeLength, strength*h-(strength/5)]);
 				cylinder(r=strength/10,h=strength*h-(strength/5));
			}
			*/
		}
	}
}

// make the positives for the holes
//
module hook_hole_positive(x,y,h) {
	translate([x*edgeLength+edgeLength/2, -y*edgeLength+edgeLength/2, 0]) {
		cylinder(h=strength*h, r=1.5);
		hull() {
			translate([0, 0, strength*h-holeRadius]) cylinder(h=0.1, r=holeRadius);
			translate([0, 0, strength*h]) cylinder(h=0.1, r=2.3);
		}
	}
}

// builds the hook at specified position
//
module hook(x, y) {
	translate([x*edgeLength, -y*edgeLength, 0]) {
		union() {
			cube([edgeLength, edgeLength, 0.5*edgeLength+strength]);
			hull() {
				translate([0, 0, 0.5*edgeLength+strength]) {
					cube([edgeLength, edgeLength, 0.5*edgeLength]);
				}
				translate([0, 0.5*edgeLength, 0.5*edgeLength+2*strength]) {
					cube([edgeLength, edgeLength, 0.5*edgeLength]);
				}
			}
		}
	}
}
