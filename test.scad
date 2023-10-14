include <BOSL2/std.scad>
$fn = 36;
cuboid([25,25,2])
    attach(TOP) cyl(h=20, d = 5, rounding1 = 0,anchor = BOT);