
pinDiam=8;
innerDiam=27;
outerDiam=29;
thikness=0.4;
height=2;

$fn=255;

difference() {
    cylinder(h=height, d=outerDiam);
    cylinder(h=height, d=pinDiam);
    translate([0,0,thikness]) cylinder(h=height, d=innerDiam);
}