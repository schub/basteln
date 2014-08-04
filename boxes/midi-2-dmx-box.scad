

// box design for midi-2-dmx controller


$fn=50;


h_box=50;
w_box=120;
d_box=60;
d_midi=15;
h_midi=10;
d_dmx=23.4;
h_dmx=10;
t1_box=2;
t2_box=5;



//box();

cover();


module box() {
	union() {

		translate([10, 0, 0]) cube([15, 60, 10]);
		translate([60, 0, 0]) cube([15, 60, 10]);

		translate([t1_box-0.1, t1_box-0.1, h_box]) screwFoo();
		translate([t1_box-0.1, d_box-t1_box+0.1, h_box]) rotate(a=[0, 0, -90]) screwFoo();
		translate([w_box-t1_box+0.1, t1_box-0.1, h_box]) rotate(a=[0, 0, 90]) screwFoo();
		translate([w_box-t1_box+0.1, d_box-t1_box+0.1, h_box]) rotate(a=[0, 0, 180]) screwFoo();

		difference() {
			// outer cube
			cube([w_box, d_box, h_box]);

			// inner cube
			translate([t1_box, t1_box, t1_box]) cube([w_box-t1_box-t2_box, d_box-2*t1_box, h_box]);

			// power connector hole
			translate([0, 3.5+t1_box, 14]) cube([20, 10, 9]);

			// usb connector hole
			translate([0, 35+t1_box, 14]) cube([20, 13, 9]);

			// dmx connector hole
			translate([100, d_dmx/2+7, d_dmx/2+h_dmx]) rotate(a=[0, 90, 0]) cylinder(h=40, r=d_dmx/2); 

			// midi connector hole
			translate([100, d_midi/2+38, d_midi/2+h_dmx]) rotate(a=[0, 90, 0]) cylinder(h=40, r=d_midi/2); 
		}
	}
}


module cover() {
	cube([w_box, d_box, t1_box]);
}


module screwFoo() {
	difference() {
		translate([0, 0, -8]) {
			union() {
				cylinder(h=8, r=6);
				translate([0, 0, -5]) cylinder(h=5, r1=0.1, r2=6);
			}
		}
		translate([-20, -10, -20]) cube(20);
		translate([-10, -20, -20]) cube(20);
	}
}















