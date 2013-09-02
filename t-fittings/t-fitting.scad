// ----------------------------------------------------------------------------------
// 
// This is a t-fitting for water tubes. It has an input and two output tubes. It can 
// be parameterized and/or easily modified.
// 
// ----------------------------------------------------------------------------------


$fn=100;


// ----------------------------------------------------------------------------------
// parameter
// ----------------------------------------------------------------------------------

inInnerR=4.75;			// inner radius of the input tube holder
inOuterR=5.25;			// outer radius of the input tube holder

//inInnerR=6.25;			// inner radius of the input tube holder
//inOuterR=6.75;			// outer radius of the input tube holder

outInnerR=6.25;			// inner radius of the output tube holder
outOuterR=6.75;			// outer radius of the output tube holder

thS=2;					// tube holder strength
thPL=8;					// length of last piece of tube holder

bR=10;					// radius of base which connects all tube holders

// for two output tubes use this array
//outAngles=[135, 225];	// angles for output tubes

// for one output tube use this array
outAngles=[180];			// angles for output tubes


// ----------------------------------------------------------------------------------
// computed constants
// ----------------------------------------------------------------------------------

// size of sphere
bRSphere=sqrt(pow(outOuterR,2) + pow(bR, 2));


// ----------------------------------------------------------------------------------
// program
// ----------------------------------------------------------------------------------


all();


// ----------------------------------------------------------------------------------
// modules
// ----------------------------------------------------------------------------------

module all() {
	union() {
		base();
		translate([bR, 0, 0]) tubeHolder(inInnerR, inOuterR);
		for ( i= [0:len(outAngles)] ) {
			rotate(a=[0, 0, outAngles[i]]) {
				translate([bR, 0, 0]) tubeHolder(outInnerR, outOuterR);
			}
		}
	}
}

module base() {
	difference() {
		translate([0, 0, outOuterR]) sphere(r=bRSphere);
		translate([-50, -50, -100]) cube(100);
		translate([-50, -50, 2*outOuterR]) cube(100);
		translate([0, 0, outOuterR]) {
			for ( i = [0:len(outAngles)] ) {
				rotate(a=[outAngles[i], 90, 0]) cylinder(h=100, r=outOuterR-thS);
			}
		}
	}
}

module tubeHolder(ri, ro) {
	mirror([0, 0, 1]) {
		rotate(a=[0, 90, 0]) {
			translate([ri, 0, 0]) {
				difference() {
					tubeHolderSolid(ri, ro);
					translate([-100-ri, -50, 0]) cube(100);
				}
			}
		}
	}
}

module tubeHolderSolid(ri, ro) {
	rotate(a=[0, 0, 0]) {
		union() {
			difference() {
				hull() {
					translate([0, 0, thPL]) sphere(ri);
					translate([(outOuterR-ri), 0, 0]) sphere(outOuterR);
				}
				translate([-50, -50, -100]) cube(100);
				hull() {
					translate([0, 0, thPL]) sphere(ri-thS);
					translate([(outOuterR-ri), 0, 0]) sphere(outOuterR-thS);
				}
				translate([0, 0, thPL]) cylinder(h=3*thPL, r=ri-thS);
			}
			difference() {
				union() {
					for ( i = [1 : 2] ) {
						translate([0, 0, i*thPL]) cylinder(h=thPL, r1=ro, r2=ri);
					}
					if (ro < outOuterR) {
						translate([0, 0, 3*thPL]) cylinder(h=thPL, r1=ro, r2=ri);
					}
				}
				translate([0, 0, thPL]) cylinder(h=4*thPL, r=ri-thS);
			}
		}
	}
}
