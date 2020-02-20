

innerDiam=25;
outerDiam=40;
thikness=2;

$fn=256;

difference() {
    cylinder(h=thikness, d=outerDiam);
    cylinder(h=thikness, d=innerDiam);
}