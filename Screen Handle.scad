include <BOSL2/std.scad>

$fn = 72;

diff() {
    xcyl(d = 15, l = 100, rounding = 7.5, anchor = BOT)
    tag("remove") position(BOT) cuboid([120,10,3]);
    tag("remove") cyl(d=5, h=20, anchor = BOT);
}