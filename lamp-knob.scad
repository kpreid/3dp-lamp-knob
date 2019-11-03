shaft_diameter = 6.1;  // measured, inexact because knurling
shaft_length = 15;
epsilon = 0.01;

sleeve = shaft_diameter + 2 * 0.8;

main();

module main() {
    difference() {
        union() {
            hull() {
                key_position() cylinder(r=10, center=true);
                
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
    
}

module key_position() {
    mirrored([1, 0, 0])
    translate([10, 0, 10 + shaft_length])
    rotate([90, 0, 0])
    children();
}

module mirrored(axis) {
    children();
    mirror(axis) children();
}
