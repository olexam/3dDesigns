
$fn = 255;

insR = 15.5/2;
insLength = 46;
lidTopR = 46/2;
lidTopH = 6;
lidTopW = 2.5;
stndR = 10;
stndLength = 400;


module stand() {
    translate([0,0,-insLength]) hull() {
        translate([-(30/2 - insR), 0,0]) cylinder(h=insLength, r=insR);
        translate([(30/2 - insR), 0,0]) cylinder(h=insLength, r=insR);
    }
    translate([0,0,-lidTopH]) {
        difference() {
            cylinder(r=lidTopR + lidTopW, h=lidTopH + lidTopW);
            cylinder(r=lidTopR, h=lidTopH);
        }
    }
    translate([0,0,lidTopW]) hull() {
        translate([-(40/2 - stndR), 0,0]) cylinder(h=stndLength, r=stndR);
        translate([(40/2 - stndR), 0,0]) cylinder(h=stndLength, r=stndR);
    }
}

stand();