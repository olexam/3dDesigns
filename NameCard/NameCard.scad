/*[ properties of Card]*/

//The resolution of the curves. Higher values give smoother curves but may increase the model render time.
resolution = 10; //[10, 20, 30, 50, 100]

//Layer height
layerHeight = 0.2;//[1 : 10]

//Total height of the sign
height = 2 * layerHeight;//[1 : 10]

//Length of card
length = 85.60;

//Width of card
width = 53.98;

//LineWidth of border
lineWidth = 0.45;

//Corner radius
radius = 3.4;

/*[ Content To be written ] */

//Message to be write
Message = ["Oleksiy Melnikov", "fb.com/oleksiy.melnikov", "olexa.m@gmail.com", "+380631548579"];
fsize = 4.1;

svg_logo = "drone-pirate-logo-dark-inkscape.svg";
//svg_logo = "drone-pirate-logo-dark.svg";
logo_scale = 0.25;
logo_offset = 2;
font="DejaVu Sans:style=Book";

$fn = resolution;

linear_extrude(height) 
    offset(r = radius) 
        square([length - radius, width - radius], center = true) ;

translate([-length/2 + logo_offset, -width/2 + logo_offset, 2* layerHeight])
    color("black") 
        linear_extrude(layerHeight) 
            scale ([logo_scale, logo_scale, 0]) import(svg_logo) ;

translate([0,0,2* layerHeight]) 
color ("black") 
linear_extrude(height = layerHeight) {
    for (i = [0:len(Message)-1]) {
        m = Message[i];
        translate([length/2 - logo_offset, width/2 - logo_offset - fsize * 2 * (i + 1)])
            text(m, size = fsize, halign = "right", font=font);
    }
}

translate([0,0,2* layerHeight])
color("black")
    linear_extrude(height = layerHeight) {
        difference() {
        offset(r = radius) 
            square([length - radius - 2 * lineWidth, width - radius - 2 * lineWidth], center = true) ;
        offset(r = radius) 
            square([length - radius - 4 * lineWidth, width - radius - 4 * lineWidth], center = true) ;
    }
}
