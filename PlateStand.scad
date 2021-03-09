

//length = 415;

lngth = 415;
bar=5;
gap=10;
frm=10;
wdth=100;
hght=45;
ofst=26.0;
difference() {
    union() {
        difference() {
            cube([lngth/2, wdth + 2 * frm, frm]);
            translate([frm, frm, -0.01]) cube([lngth/2 - 2*frm, wdth, frm + 0.02]);
        }

        for (i = [0:gap + bar: lngth/2 -ofst])
        translate([ofst + i,0,5]) 
        rotate([0,-105,0]) 
        difference() {
            cube([hght + 10, wdth + 2*frm, bar]);
            translate([-0.01, frm, -0.01]) cube([hght+10.02, wdth, bar + 0.02]);
        }
    }
    translate([-lngth/2, -5, hght]) cube([lngth, wdth + 30, 20]);
    translate([lngth/2, -5, 0]) cube([lngth, wdth + 30, hght]);
}