include <Round-Anything/polyround.scad>

LION_18650=[18.4, 65.5];


module springS(height, width, length, wall = 1) {

    halfW = width/2 - wall;
    startYP=-wall;

    function beamPoints(r1,r2,rStart=0,rEnd=0)=
    [
        [0, startYP, rStart],                     // 1
        [0, length, r1],                    // 2
        [halfW, length, r1],                // 3
        [halfW, length/3, r2],              // 4
        [2*halfW/3, length/3, r2],          // 5
        [2*halfW/3, 2*length/3, r2],        // 6
        [halfW/3, 2*length/3, r2],          // 7
        [halfW/3, wall/2, r2],              // 8
        [width-halfW/3, wall/2, r2],        // 8
        [width-halfW/3, 2*length/3, r2],    // 7
        [width-2*halfW/3, 2*length/3, r2],  // 6
        [width-2*halfW/3, length/3, r2],    // 5
        [width-halfW, length/3, r2],        // 4
        [width-halfW, length, r1],          // 3
        [width, length, r1],                // 2
        [width, startYP, rEnd]                    // 1
    ];


    radiiPoints=beamPoints(2*halfW/3,halfW/3);

/*
    // Debug marks
    for(i=[0: len(radiiPoints)-1]){
        color("red")
            translate([radiiPoints[i].x,radiiPoints[i].y,0])
                cylinder(d=0.2, h=1.5);
    }
*/

    linear_extrude(height)
        polygon(
            polyRound(
                beamChain(radiiPoints,offset1=wall/2, offset2=-wall/2),
                20)
            );

}

// plastic spring for minus pole
module spring(d, w, ws,ch, el, hf,r) {
    echo("d, w, ws,ch, el, hf, r", d, w, ws,ch, el, hf,r);
    di = d + ws;
    height = hf * d + w;
    rotate([0,0,90]) translate([-di/2,ws/3,0]) springS(height, di, 10, ws);

}


module slot(d,w) {
    resize([2*d/3,4,0]) 
    cylinder(h=w, $fn=6);
}
//////////////////////////////////////////////////////////////////////////////////
//
//  FLEXBATTER:  Flexing battery holder with integrated plastic spring
//
//////////////////////////////////////////////////////////////////////////////////
module flexbatter(n = 1,
                  l = 65,
                  d = 18,
                  hf = 0.75,
                  r = 4,
                  shd = 3,
                  eps = 0.28,
                  el = 0,
                  xchan = [ 1 / 4, 3 / 4 ],
                  $fn = 24)
{
    ew = 0.56;   // extrusion width
    eh = 0.25;   // extrusion height
    w = 2 * ew;  // case wall thickness
    ws = 2 * ew; // spring wall thickness
    ch = w - ws; // edge chamfering
    deepen = 0;  // deepening for side grip of batteries
    // el = 0;  // extra length in spring
    // eps = 0.28;
    // shd = 3; // screw hole diameter
    // hf=0.75;
    // xchan=[1/4,3/4]; // relative position of traversal wire channels

    r = d / 5 + 2 * ws; // linear spring length (depends on sline() call!)

difference() {
    for (i = [0:n - 1])
        translate([ 0, i * (d + w), 0 ])
        { // generate n battery cases
            difference()
            {

                union()
                {
                    difference()
                    {
                        // main body
                        translate([ 0, -w - d / 2, 0 ]) cube(
                            [ l + w, 
                            d + 2 * w + (i < n - 1 ? 0 : 0), 
                            d + 1.5* w 
                            ]);
                        // main cavity
                        translate([ -2, -d / 2, w ]) cube([ 2 + l, d, d + 2*w ]);
                        // cavity for locating plastic spring
                        translate([ -1, -d / 2, -1 ]) cube([ 2, d, d + w + 2 ]);
                        
                        if(i==n-1) {
                            translate([l/2, w + d / 2, 0]) 
                                rotate([90,0,0]) 
                                slot(d, w);
                        }
                        if(i==0) {
                            translate([l/2, - d / 2, 0]) 
                            rotate([90,0,0]) 
                            slot(d, w);
                        }
                        translate([l, 0, 0]) 
                        rotate([90,0,90]) 
                        slot(d, w);

                    }
                    spring(d, w, ws,ch, el, hf, r);

                    if(i==n-1) {
                        translate([l/2, w + d / 2, d + 1.5* w]) 
                            rotate([90,0,0]) 
                            slot(d, w);
                    }
                    if(i==0) {
                        translate([l/2, - d / 2, d + 1.5* w]) 
                        rotate([90,0,0]) 
                        slot(d, w);
                    }

                    translate([l, 0, d + 1.5* w]) 
                    rotate([90,0,90]) 
                    slot(d, w);

                }

                // lower and upper holes for contacts
                for (z = [ -2 * ws, 2 * ws ])
                    translate([ -2 * ws, -d/6, w - ws / 2 + d / 2 + z ])
                        cube([ l + 2 * w + 2, d/3, ws ]);
/*
                // longitudinal bottom wire channel
                translate([ -2 * ws, 0, 0 ]) rotate([ 0, 90, 0 ])
                    cylinder(r = w / 2, h = l + w + 2 + r, $fn = 5);

                // traversal bottom wire channels
                for (x = l * xchan)
                    translate([ x, -d / 2 - w - 1, eh ]) rotate([ -90, 0, 0 ])
                        cylinder(r = w / 2, h = d + 2 * w + ws + 2, $fn = 6);

                // grip deepening
                if (deepen > 0)
                    translate([ w + l / 2 - 0.5, -d / 2 - w - 0.01, w + d + l ])
                        rotate([ -90, 0, 0 ])
                    {
                        cylinder(r = l + deepen * d, h = d + 2 * w + 2 * ws + 2, $fn = 72);
                        if (i == 0)
                            cylinder(r1 = l + deepen * d + ch,
                                     r2 = l + deepen * d,
                                     h = ch + 0.02,
                                     $fn = 72);
                        if (i == n - 1)
                            translate([ 0, 0, d + 2 * w - ch ]) cylinder(r2 = l + deepen * d + ch,
                                                                         r1 = l + deepen * d,
                                                                         h = ch + 0.02,
                                                                         $fn = 72);
                    }
*/
                    
/*
                // conical screw holes in corners
                for (x = [ 7 + shd, l - 2 * shd ])
                    for (y = [ -d / 2 + shd, d / 2 - shd ])
                        translate([ x, y, -1 ])
                        {
                            cylinder(r = shd / 2, h = w + 2);
                            translate([ 0, 0, w - shd / 2 + 1 ])
                                cylinder(r1 = shd / 2, r2 = shd, h = shd / 2 + 0.01);
                        }
*/
                // holes for wires passing inside
                for (sy = [ -1, 1 ])
                    scale([ 1, sy, 1 ])
                    {
                        translate([ l - 1, -d / 2, w ]) cube([ w + 2, 2, 2 ]);
                        for (x = [ 3, l - 7 ])
                            translate([ x, -d / 2 - w - ws - 1, w ]) cube([ 3, w + ws + 3, 2 ]);
                        translate([ 3, -d / 2 + w / 2 - 0.75, -1 ]) cube([ 3, 1.5, w + 2 ]);
                        translate([ -0.5, -d / 2 + w / 2, 0 ]) rotate([ 0, 90, 0 ])
                            cylinder(r = w / 2, h = 6.5, $fn = 5);
                    }

                // engrave battery symbol
                translate([ w + l / 2, d / 4 + 1, w ]) cube([ l / 5, d / 4.5, 4 * eh ], true);
                translate([ w + l / 2 + l / 10, d / 4 + 1, w ])
                    cube([ d / 7, d / 10, 4 * eh ], true);
                // engrave plus symbol
                let(sy = (l > 12 * shd) ? 1 : -1)
                { // for short batteries +- on the side
                    translate([ w + l / 2 + l / (sy > 0 ? 5 : 10), sy * (d / 4 + 1), w ])
                    {
                        cube([ 1, d / 4, 4 * eh ], true);
                        cube([ d / 4, 1, 4 * eh ], true);
                    }
                    // engrave minus symbol
                    translate([ w + l / 2 - l / (sy > 0 ? 5 : 10), sy * (d / 4 + 1), w ])
                        cube([ 1, d / 4, 4 * eh ], true);
                }

            }

        }

    // small cylindrical carving of walls and bottom

    for (i = [0:n - 1])
        translate([ 1, i * (d + w), 0 ])
        {
            if (eps > 0)
                translate([ -1, 0, d / 2 + w ]) rotate([ 0, 90, 0 ])
                    cylinder(r = d / 2 + eps, h = l);
        }
    }
    for (i = [0:n - 1])
        translate([ 0, i * (d + w), 0 ])
                // horizontal contact bulges (+ and - pole)
            for (x = [ -0.3, l ])
                hull() for (y = [ -3 + el, 3 - el ]) translate([ x, y, w + d / 2 ]) sphere(r = ws);

            // vertical contact bulge (+ pole only)
            if (0)
                hull() for (z = [ -3 + el, 3 - el ]) for (x = [ 0, w - ws ])
                    translate([ l + x, 0, w + d / 2 + z ]) sphere(r = ws);

}


module flexbatter18650(n = 1)
{
    // LION_18650[1];
    flexbatter(n = n, l = LION_18650.y, d = LION_18650.x, hf = 0.75, shd = 3, eps = 0.28);
}

module flexbatter18650P(n = 1)
{
    flexbatter(n = n, l = 67.5, d = 18.4, hf = 0.75, shd = 3, eps = 0.28);
}

module flexbatterCR123A(n = 1)
{
    flexbatter(n = n, l = 35.1, d = 16.7, hf = 0.75, shd = 3, xchan = [0.5], eps = 0.28);
}

module flexbatterD(n = 1)
{
    flexbatter(n = n, l = 61.5, d = 34.0, hf = 0.75, shd = 3, eps = 0.28);
}

module flexbatterC(n = 1)
{
    flexbatter(n = n, l = 51.6, d = 26.4, hf = 0.75, shd = 3, eps = 0.28);
}

module flexbatterAA(n = 1)
{
    flexbatter(n = n, l = 51.6, d = 14.4, hf = 0.80, shd = 2.5, el = 0.5, eps = 0.28);
}

module flexbatterAAA(n = 1)
{
    flexbatter(n = n, l = 46.1, d = 10.45, hf = 0.84, shd = 2, el = 1, xchan = [0.5], eps = 0);
}

flexbatter18650(n = 6);
