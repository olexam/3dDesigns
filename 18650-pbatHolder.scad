

intW=25.5;
l=50;
wall=2;

difference() {
    cube([intW + 2*wall, l, 12]);
    translate([wall, wall, wall]) cube([intW, l, 12]);
}
