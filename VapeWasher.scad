
pinDiam=8;
innerDiam=25;
outerDiam=27;
thikness=0.4;
height=1.2;

$fn=255;

difference() {
    cylinder(h=height, d=outerDiam);
    cylinder(h=height, d=pinDiam);
    translate([0,0,thikness]) cylinder(h=height, d=innerDiam);
}