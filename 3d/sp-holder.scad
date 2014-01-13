

$fn=100;

// ------------------------------------------------------------------
// --- parameter ----------------------------------------------------
// ------------------------------------------------------------------

// resolution
$fn=100;

// edge length of one cube that builds the space invader
edgeLength=6;

// radius of the holes
wholeRadius=1.5;


// ------------------------------------------------------------------
// --- space invader versions ---------------------------------------
// --- a vector of 2d coordinates -----------------------------------
// ------------------------------------------------------------------

sp1=[[0,0],[0,1],[0,2],[1,2],[1,3],[1,4],[2,1],[2,2],[2,4],[2,5],[3,2],[3,3],[3,4],[4,1],[4,2],[4,4],[4,5],[5,2],[5,3],[5,4],[6,0],[6,1],[6,2]];

sp2=[[0,0],[0,1],[0,2],[1,2],[1,3],[1,4],[2,1],[2,2],[2,4],[2,5],[3,-1],[3,0],[3,1],[3,2],[3,3],[3,4],[4,1],[4,2],[4,4],[4,5],[5,2],[5,3],[5,4],[6,0],[6,1],[6,2]];

sp3=[[0,-1],[0,0],[0,1],[0,2],[1,-1],[1,2],[1,3],[1,4],[2,1],[2,2],[2,4],[2,5],[3,-1],[3,0],[3,1],[3,2],[3,3],[3,4],[4,1],[4,2],[4,4],[4,5],[5,-1],[5,2],[5,3],[5,4],[6,-1],[6,0],[6,1],[6,2]];




// ------------------------------------------------------------------
// --- programm -----------------------------------------------------
// ------------------------------------------------------------------

invader2();


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




// ------------------------------------------------------------------
// --- modules ------------------------------------------------------
// ------------------------------------------------------------------


// builds a complete towel holder with space invader base, 
// holes and noses.

module _invader(data, nose, hole) {
	difference() {
		union() {
			for (i = [0:len(data)]) {
				_cube(data[i][0], data[i][1], 0);
			}
			_holder(nose[0], nose[1]);
		}
		translate([hole[0]*edgeLength+edgeLength/2, hole[1]*edgeLength+edgeLength/2, 0]) {
			cylinder(h=edgeLength, r=1.5);
			hull() {
				translate([0, 0, edgeLength-1.5]) cylinder(h=0.1, r=1.5);
				translate([0, 0, edgeLength]) cylinder(h=0.1, r=3);
			}
			//translate([0, 0, 1.3*edgeLength]) sphere(r=3);
		}
	}
}

module _cube(x, y) {
	translate([x*edgeLength, y*edgeLength, 0]) {
		cube([edgeLength, edgeLength, edgeLength]);
	}
}

module _holder(x, y) {
	translate([x*edgeLength, y*edgeLength, 0]) {
		union() {
			cube([edgeLength, edgeLength, edgeLength]);
			translate([0, 0, edgeLength]) {
				cube([edgeLength, edgeLength, edgeLength]);
			}
			hull() {
				translate([0, 0, 1.5*edgeLength]) {
					cube([edgeLength, edgeLength, edgeLength]);
				}
				translate([0, 0.5*edgeLength, 2*edgeLength]) {
					cube([edgeLength, edgeLength, edgeLength]);
				}
			}
		}
	}
}



// ------------------------------------------------------------------
// --- trash --------------------------------------------------------
// ------------------------------------------------------------------
