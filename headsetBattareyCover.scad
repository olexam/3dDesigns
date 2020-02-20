
$fn=100;

batW=21;
batL=76;
batH=19;
wall=0.8;

aH=12;
aW=90;

// https://www.mathopenref.com/arcradius.html
aR = aH/2 + (aW*aW/(8*aH));

dH=1.2;
dW=20;
dR = dH/2 + (dW*dW/(8*dH));

difference() {
    union() {
        shL = batL + 2*wall;
        shW = batW + 2*wall;
        hull() 
        {
            translate([-shL/2, -shW/2, aH+batH]) 
                linear_extrude(height=0.1) 
                    offset(r=wall) 
                        translate([wall, wall, 0])
                            square([shL-2*wall, shW-2*wall]);
            translate([-aW/2, -shW/2, -dH]) 
                linear_extrude(height=0.1)
                    offset(r=wall)
                        translate([wall, wall, 0])
                            square([aW-2*wall, shW-2*wall]);
        }
    }

    translate([-batL/2, -batW/2, 1]) cube([batL, batW, aH+batH]);

//    #translate([0, 0, -aR + aH]) rotate([90,0,0]) cylinder(h=2*batW, r=aR, center=true);

    translate([0, 0, -aR + aH]) rotate([90,0,0]) rotate_extrude() translate([aR-dR, 0, 0]) circle(r=dR);
}

