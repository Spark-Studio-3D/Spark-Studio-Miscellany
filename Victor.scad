include <BOSL2/std.scad>

$fn = 72;

od1 = 26;
id2 = 23;
h = 25;
t = 1.5;
edge_r = 1.5;

cuboid([od1, od1, 2 * t], rounding = edge_r, edges = "Z", anchor = BOT)
    attach(TOP) {
        zrot_copies(n=4)
            cuboid([id2, t, h], anchor = BOT);

        cuboid([id2, id2, t], rounding = 2*edge_r, edges = "Z", anchor = BOT);

    }