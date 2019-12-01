// Diameter in mm of the shaft (inner diameter of the knob's socket). Adjustments will probably be required. Values that have worked for some lamps: 5.1, 6.1.
shaft_diameter = 5.6;

// Length in mm of the knob's socket for the shaft.
shaft_length = 15;

// Proportion of shaft_diameter by which to squash the socket out of round to aid in gripping the shaft. Zero is circular.
shaft_fit_stretch = 0.05;

/* [Hidden] */
sleeve = shaft_diameter + 2 * 0.8;
epsilon = 0.01;


main();

module main() {
    color("white")
    difference() {
        union() {
            hull() {
                key_base() key_outer() cylinder(r=10, center=true);
                
                shaft_fit_stretch()
                translate([0, 0, 5])
                rotate([90, 0, 0])
                cylinder(r=1, center=true);

            }
            
            shaft_fit_stretch()
            hull() {
                cylinder(d=sleeve, h=shaft_length, $fn=60);
                translate([0, 0, shaft_length]) sphere(d=sleeve, $fn=60);
            }
        }
        shaft_fit_stretch()
        translate([0, 0, -epsilon]) cylinder(d=shaft_diameter, h=shaft_length, $fn=30);
    }
    
    color("yellow")
    key_base() {
        mirrored([1, 0, 0])
        for (i = [4:2:10]) {
            s = i / 10;
            translate([10 * s - 20 * (1 - s), 0, 0])
            ring(r=10 * s);
        }
    }
}

module shaft_fit_stretch() {
    scale([1 + shaft_fit_stretch, 1 - shaft_fit_stretch * 0.5, 1])
    children();
}

module ring(r=10) {
    scale([1, 1, 1.2])
    rotate_extrude()
    translate([r, 0, 0])
    rotate(360 / 16)
    circle(d=2, $fn=8);
}

module key_base() {
    translate([0, 0, 10 + shaft_length])
    rotate([90, 0, 0]) 
    children();
}

module key_outer() {
    mirrored([1, 0, 0])
    translate([10, 0, 0])
    children();
}

module mirrored(axis) {
    children();
    mirror(axis) children();
}
