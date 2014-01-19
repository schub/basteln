// ----------------------------------------------------------------------------------
// 
// Bike lamps (front and back)
// 
// ----------------------------------------------------------------------------------

use <modules.scad>;

$fn=100;


// ----------------------------------------------------------------------------------
// parameter
// ----------------------------------------------------------------------------------

fRodR=10;		// radius of the rod where the lamp will be atached to
fRodH=25;		// height of the holding on the rod
fRodS=4;		// strength of the holding

fHoldingH=15;	// length of holding
fHoldingR=4;	// radius of holding
fHoldingS=2;	// space for the holding

bH=40;			// height of backlamp
bL=60;			// length of backlamp
bD=25;			// depth of backlamp

batL=55;		// length of battery pack
batH=30;		// height of battery pack
batD=14.5;		// depth of battery pack

fLampR=40;		// front lamp radius
fLampD=40;		// depth of front lamp
fLampS=3;		// strength of chassis

rounding=1;		// rounding

nutSize=4;		// size of nut
nutH=3;			// height of nut
screwRodR=1.5;	// radius of screw rod


// ----------------------------------------------------------------------------------
// computed constants
// ----------------------------------------------------------------------------------


// ----------------------------------------------------------------------------------
// program
// ----------------------------------------------------------------------------------

backLamp();

//batteryCut();

//backLampBody();

//frontLampHolding();

//akkuAAA();

//frontLamp();

// ----------------------------------------------------------------------------------
// modules
// ----------------------------------------------------------------------------------



module frontLamp() {
	
	
}


module backLamp() {
	frontLampHolding();
	translate([-38, batL/2+2.5, 62]) rotate(a=[-90, 0, -90]) backLampBody();
}


module backLampBody() {
	difference() {
		union() {
			rCube([bL, bH, 5], rounding);
			rCube([bL, bD, bD], rounding);
			translate([bL/2-2.5, bD+2, bD/2-1]) rotate(a=[0, 90, 0]) {
				hull() {
					rCylinder(bD/2, 5, rounding);
					translate([0, -bD/2, 0]) rCube([bD/2, bD, 5], rounding);
					translate([-bD/2, -bD/2, 0]) rCube([bD, bD/2, 5], rounding);
				}
			}
			hull() {
				translate([rounding, rounding, 0]) cylinder(r=rounding, h=2*rounding);
				translate([bL-rounding, rounding, 0]) cylinder(r=rounding, h=2*rounding);
				translate([bL-rounding, bH-rounding, 0]) cylinder(r=rounding, h=2*rounding);
				translate([rounding, bH-rounding, 0]) cylinder(r=rounding, h=2*rounding);
			}
		}
		translate([0, 0, -10]) cube([2*bL, 2*bH, 10]);
		translate([(bL-batL)/2, (bD-batD)/2, 8]) batteryCut();

		// the hole for the connector to the holder
		translate([0, bD+(bH-bD)/2-1, 5+bD/2-1]) rotate(a=[0, 90, 0]) cylinder(r=2.5, h=100);
	}
}

batConOffset=10;

module batteryCut() {
	translate([0, 0, 0]) {
		union() {
			cube([batL, batD, batH]);
			translate([batConOffset, batD/2, -20]) cylinder(r=screwRodR, h=20);
			translate([batConOffset, batD/2, -nutH]) nutDummy(nutSize, nutH);
			translate([batL-batConOffset, batD/2, -20]) cylinder(r=screwRodR, h=20);
			translate([batL-batConOffset, batD/2, -nutH]) nutDummy(nutSize, nutH);
			translate([0, batD/2-nutSize/2, -nutH]) cube([batConOffset, nutSize, nutH]);
			translate([batL-batConOffset, batD/2-nutSize/2, -nutH]) { 
				cube([batConOffset, nutSize, nutH]);
			}
		}
	}
}


module frontLampBody() {
	hull() {
		translate([0, 0, 0]) cylinder(r=fLampR, h=1);
		translate([-30, 0, 10]) cube([60, 15, 15]);
	}
}


module frontLampHolding() {
	difference() {
		hull() {
			cylinder(r=fRodR+fRodS, h=fRodH);
			translate([fRodR+fRodS, fHoldingH/2, fRodH/2]) {
				rotate(a=[90, 0, 0]) cylinder(r=fHoldingR, h=fHoldingH);
			}
			translate([-20, fHoldingH/2, 30]) {
				rotate(a=[90, 0, 0]) cylinder(r=fHoldingR, h=fHoldingH);
			}
		}
		cylinder(r=fRodR, h=100);
		translate([0, -1, 0]) cube([100, 2, 100]);
		translate([fRodR+fRodS, 0, fRodH/2]) screwDummy();
		translate([-20, 50, 30]) rotate(a=[90, 0, 0]) cylinder(r=1.5, h=100);
		translate([-fRodR-fRodS-50, -2.5, 0]) cube([50, 5, 100]);
		translate([-20, 0, 30]) screwDummy();
	}
}

module screwDummy() {
	translate([0, (2*(fHoldingS+fRodS) + 40)/2, 0]) {
		rotate(a=[90, 0, 0]) {
			screwWithNut(nr=3, nd=20, s=2*(fHoldingS+fRodS), sd=20, sr=1.5, wp=1);
		}
	}
}


