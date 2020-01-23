/* global config */
$fn=100;


/*Sizes*/
handle_height = 50;
height=50;
length = 200;
width = 180;
round_rad=8;
//tr

offset(round_rad) 
cube([width, length, height + handle_height], center=false);

