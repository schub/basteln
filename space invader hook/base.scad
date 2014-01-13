/* ********************************************************************
 * Space Invader Hooks
 * 
 * Generate your own cloth hooks. Tweak parameters, create your own
 * hooks or use the predefined modules.
 *
 * ******************************************************************** */


// ------------------------------------------------------------------
// --- parameter ----------------------------------------------------
// ------------------------------------------------------------------

// resolution
$fn=100;

// edge length of one cube that builds the space invader
edgeLength=6;
strength=4;

// radius of the holes
wholeRadius=1.5;


// ------------------------------------------------------------------
// --- space invader versions ---------------------------------------
// --- a vector of 2d coordinates -----------------------------------
// ------------------------------------------------------------------

sp1=[[0,0],[0,1],[0,2],[1,2],[1,3],[1,4],[2,1],[2,2],[2,4],[2,5],[3,2],[3,3],[3,4],[4,1],[4,2],[4,4],[4,5],[5,2],[5,3],[5,4],[6,0],[6,1],[6,2]];

sp2=[[0,0],[0,1],[0,2],[1,2],[1,3],[1,4],[2,1],[2,2],[2,4],[2,5],[3,-1],[3,0],[3,1],[3,2],[3,3],[3,4],[4,1],[4,2],[4,4],[4,5],[5,2],[5,3],[5,4],[6,0],[6,1],[6,2]];

sp3=[[0,-1],[0,0],[0,1],[0,2],[1,-1],[1,2],[1,3],[1,4],[2,1],[2,2],[2,4],[2,5],[3,-1],[3,0],[3,1],[3,2],[3,3],[3,4],[4,1],[4,2],[4,4],[4,5],[5,-1],[5,2],[5,3],[5,4],[6,-1],[6,0],[6,1],[6,2]];

sp4=[[0,0],[0,3],[0,4],[1,0],[1,1],[1,3],[1,4],[1,5],[1,6],[2,1],[2,2],[2,3],[2,6],[2,7],[3,2],[3,3],[3,6],[3,7],[4,2],[4,3],[4,4],[4,5],[4,6],[5,2],[5,3],[5,6],[5,7],[6,1],[6,2],[6,3],[6,6],[6,7],[7,0],[7,1],[7,3],[7,4],[7,5],[7,6],[8,0],[8,3],[8,4]];


// ------------------------------------------------------------------
// --- programm -----------------------------------------------------
// ------------------------------------------------------------------

invader4();


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


// builds a complete towel hook with space invader base, 
// holes and noses.
//
module _invader(data, nose, hole) {
	difference() {
		union() {
			for (i = [0:len(data)]) {
				_cube(data[i][0], data[i][1], 0);
			}
			_hook(nose[0], nose[1]);
		}
		translate([hole[0]*edgeLength+edgeLength/2, hole[1]*edgeLength+edgeLength/2, 0]) {
			cylinder(h=edgeLength, r=1.5);
			hull() {
				translate([0, 0, strength-1.5]) cylinder(h=0.1, r=1.5);
				translate([0, 0, strength]) cylinder(h=0.1, r=3);
			}
		}
	}
}

// builds a cube at specified position
//
module _cube(x, y) {
	translate([x*edgeLength, y*edgeLength, 0]) {
		cube([edgeLength, edgeLength, strength]);
	}
}

// builds the hook at specified position
//
module _hook(x, y) {
	translate([x*edgeLength, y*edgeLength, 0]) {
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
