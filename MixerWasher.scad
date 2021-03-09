
$fn=255;
hg = 8;
difference() {
  union() {
    cylinder(d=18, h=hg);
    cylinder(d=22.5, h=4);
  }
  cylinder(d=14, h=hg);
}
