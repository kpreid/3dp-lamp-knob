shaft_diameter = 6.1;  // measured, inexact because knurling
shaft_length = 15;
epsilon = 0.01;

sleeve = shaft_diameter + 2 * 0.8;

main();

module main() {
    color("white")
    difference() {
        union() {
            hull() {
                key_base() key_outer() cylinder(r=10, center=true);
                
                translate([0, 0, 5])
                rotate([90, 0, 0])
                cylinder(r=1, center=true);

            }
            
            hull() {
                cylinder(d=sleeve, h=shaft_length, $fn=60);
                translate([0, 0, shaft_length]) sphere(d=sleeve, $fn=60);
            }
        }
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

module ring(r=10) {
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
