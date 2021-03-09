
$fn=255;


difference() {
union(){ // brake
    l = 5;
    translate([0,0,l/2]) cube([20, 35, l], center=true);
    l1 = 25;
    translate([0,0,-l1/2]) cube([20, 35, l1], center=true);
    l2=8;
    l3=20;
    hull() {
        translate([0,l2,0]) linear_extrude (0.01) circle(18);
        translate([0,-l2,0]) linear_extrude (0.01) circle(18);

        translate([0,0,-25]) {
            translate([0,l3,0]) linear_extrude (0.01) circle(18);
            translate([0,-l3,0]) linear_extrude (0.01) circle(18);
        }
    }
    translate([0,0,-28]) {
        hull() {
            translate([0,l3,0]) linear_extrude (3) circle(18);
            translate([0,-l3,0]) linear_extrude (3) circle(18);
        }
    }
}

union() { // weel
    rotate([0,90,0]) {
        cylinder(d=22.5, h=50, center=true);
        translate ([0,0,10]) cylinder(d=50, h=8);
        translate ([0,0,-18]) cylinder(d=50, h=8);
    }

    l=35;
    translate([0,l/2, l-7]) cube([3, l, 2*l], center=true);
    #translate([0,-l/2, l-2]) cube([3, l, 2*l], center=true);
    translate([0,19,0]) cylinder(d=17, h=50);

    translate([0,10, 10]) cube([9, 20, 20], center=true);
}
}