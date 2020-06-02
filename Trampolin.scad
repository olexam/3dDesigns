

$fn=100;
width=50;
chanW=3;
th=1;
sLen=200;


rotate([90,0,0]) linear_extrude(sLen) prof(width, th, chanW);

translate([th,-2,0]) 
cube([th,4*th, 2*th]);

translate([width - th,-2,0]) 
cube([th,4*th, 2*th]);

translate([100,00,80]) rotate([0,90,0]) rotate_extrude(angle=45) rotate([0,0,90]) translate([0,-80,0]) #prof(width, th, chanW);

module prof(width, th, chanW) {
    tl=0.4;
polygon(
[
[0,0],[width+th, 0],[width+th, 5*th],[width, 5*th],[width, th],
[width/2 + chanW/2 + th+tl, th],[width/2 + chanW/2 + th+tl, 2*th],[width/2 + chanW/2 + th, 2*th],[width/2 + chanW/2+tl, 2*th],[width/2 + chanW/2+tl, th],
[width/2 - chanW/2-tl, th],[width/2 - chanW/2-tl, 2*th],[width/2 - chanW/2+th-tl, 2*th],[width/2 - chanW/2+th-tl, th],[th, th],
[th, 5*th],[0, 5*th]
]);
}