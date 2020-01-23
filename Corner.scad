///
// params

$fn=360;
length=740;
width=41;
width1=47;
height=45;
wall=1.26;

Corner();

module Corner() {
    translate([0,0,-20]) cube([wall, length, height + 20]);
    cube([width, length, wall]);
    translate([width, length, 0]) 
        rotate ([90, 0, 0]) 
            linear_extrude(length) 
                polygon([[0,0], [20, 0], [20, 0.5], [0, wall]]);
    hull() {
        translate([width,0,-20]) cube([wall, wall, 20]);
        translate([width1, length - wall,-20]) cube([wall, wall, 20]);
    }
    hull() {
        translate([0, 0, -20]) cube([width, wall, wall]);
        translate([0, length - wall, -20]) cube([width1, wall, wall]);
    }
    translate([width + wall , length, width + wall-0.2]) rotate([90,180,0]) linear_extrude(length) projection() rotate_extrude(angle=90) translate([width, 0, 0]) square([wall,0.01]);
}