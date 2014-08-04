// ---------------------------------------------------
// geodasic dome connectors
// 
// creates connectors for the rods of a 3V geodesic 
// dome. This aproach does the 
// For a 5/8 dome you need the following 
// connectors (see connector configurations below)
//	- 30 x con_ABCBCB (6 way connector)
//	- 10 x con_6C (6 way connector)
//	-  6 x con_5A (5 way connector)
//	-  5 x con_4C (4 way connector)
//	-  5 x con_CBCB (4 way connector)
//	-  5 x con_BCBC (4 way connector)
//	
// ---------------------------------------------------


// ---------------------------------------------------
// imports
// ---------------------------------------------------
use <modules.scad>;
use <TextGenerator.scad>;

// ---------------------------------------------------
// parameter
// ---------------------------------------------------

$fn=50;							// resolution of the rendered object


con_radius=55;					// radius of the whole connector
con_screw_radius=5;				// radius for the screw that holds connector together
con_height=36;					// total height of the connector

rod_radius=8.5;					// rod radius
rod_center_distance=20;			// distance rod from connector centre
stop_height=3;					// height of rod stopper
stop_screw_length=9;				// length of the stopper screw
stop_screw_radius=2.8;				// radius of the stopper screw
stop_screw_head_radius=4;			// radius of nut
stop_screw_head_height=3.2;			// height of nut
stop_cylinder_radius=4.7;			// cylinder radius

rod_angles=[10.04, 11.64, 11,90];	// angles for the different rod sizes
rod_angle_chars=["A","B","C"];		// corresponding char for rod angle


// ---------------------------------------------------
// computed values
// ---------------------------------------------------

con_height_1=(con_height/2)-(tan(12)*con_radius/2)+(con_height/10);					
con_height_2=(con_height/2)+(tan(12)*con_radius/2)+(con_height/10);



// ---------------------------------------------------
// connector angles
// ---------------------------------------------------


// connector configurations
con_T=[[0,1], 72,0];
con_5A=[[0,0],[72,0],[144,0],[216,0],[288,0]];
con_6C=[[0,2],[60,2],[120,2],[180,2],[240,2],[300,2]];
con_ABCBCB=[[0,0],[60,1],[120,2],[180,1],[240,2],[300,1]];
con_4C=[[0,2],[60,2],[120,2],[180,2]];
con_CBCB=[[0,2],[60,1],[120,2],[180,1]];
con_BCBC=[[0,1],[60,2],[120,1],[180,2]];



// ---------------------------------------------------
// start program
// ---------------------------------------------------


//top(con_ABCBCB);
//bottom(con_ABCBCB);

//star(con_ABCBCB);

//bottom_base();
//top_base();

//con(con_ABCBCB, "top");
//con(con_ABCBCB, "bottom");

testing();

// ---------------------------------------------------
// modules
// ---------------------------------------------------

module top(angles) {
	rotate(a=[180, 0, 0]) translate([0, 0, -con_height]) con(angles, "top");
}

module bottom(angles) {
	con(angles, "bottom");
}



module bottom_base() {
	union() {
		cylinder(h=con_height_1, r=con_radius);
		translate([0, 0, con_height_1]) cylinder(h=con_height_2-con_height_1, r1=con_radius, r2=0.1);
	}
}

module top_base() {
	difference() {
		cylinder(h=con_height, r=con_radius);
		bottom_base();
	}
}


module con(angles, part) {
	translate([0.01, 0, 0]) {
		difference() {
			union() {			
				// base part
				if (part == "bottom") {
					bottom_base();
				} else {
					top_base();
				}			
			}

			// screw holes
			screw_holes(angles);

			// rods
			translate([0, 0, con_height_2]) star(angles);

			// marker
			translate([10, 0, 0]) cylinder(h=con_height, r=2);
		}
	}
}



module screw_holes(angles) {
	// the holes for potential screws
	union() {
		cylinder(h=con_height, r=con_screw_radius);
		for (j = [0 : len(angles)-2]) {
			rotate(a=[0, 0, ((angles[j+1][0]-angles[j][0])/2)+angles[j][0]]) {
				translate([con_radius-con_screw_radius-5, 0, 0]) cylinder(h=con_height, r=con_screw_radius);
			}
		}
		rotate(a=[0, 0, (angles[len(angles)-1][0]-360)/2]) {
			translate([con_radius-con_screw_radius-5, 0, 0]) cylinder(h=con_height, r=con_screw_radius);
		}
	}
}


module star(angles) {
	union() {
		// the rods
		for (i = [0 : len(angles)-1]) {
			rotate(a=[0, 90+rod_angles[angles[i][1]], angles[i][0]]) {
				translate([0, 0, rod_center_distance]) rod_end(rod_angle_chars[angles[i][1]]);
			}
		}
	}
}


module rod_end(char) {
	union() {
	cylinder(h=2*con_radius, r=rod_radius);
	translate([rod_radius-2, 0, stop_screw_head_height+5]) { 
		rotate(a=[0, 90, 0]) {
			screwWithNut(
				nr=stop_screw_head_radius, 
				nd=0, 
				s=con_radius, 
				sd=stop_screw_head_height+2,
				sr=stop_screw_radius, 
				wp=0
			);
			translate([0, 0, stop_screw_length+stop_screw_head_height+2]) {
				cylinder(h=con_radius, r=stop_cylinder_radius);
			}
		}
	}
	translate([-rod_radius-2, -2.5, con_radius-rod_center_distance-5]) {
		rotate(a=[-90, 0, -90]) mirror([1, 0, 0]) scale([1, 1, 2*rod_radius+4]) drawtext(char);
	}
	}
}




// testing
module testing() {
	difference() {
		con(con_ABCBCB, "bottom");
		translate([-100, rod_radius+2, 0]) cube([200, 200, 30]);
		translate([-100, -200-rod_radius-2, 0]) cube([200, 200, 30]);
		translate([-100+rod_center_distance-5, -50, 0]) cube(100);
		translate([35, -50, 0]) cube(100);
	}
}
