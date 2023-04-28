include <BOSL2/std.scad>

cuboid ([150,50,0.5], rounding = 5, edges = "Z", anchor = BOT);
color("blue") text3d(text = "2701",  h = 1, size = 40, font = "Avenir Heavy", anchor = BOT );