$fn=100;

translate([5,5,0]) linear_extrude(1.5) offset(r=5) square([155,90]);

for(x=[15:25:145]) {
    for(y=[10:25:90]) {
        translate([x,y,0]) cylinder(h=25, d=5);
    }
}