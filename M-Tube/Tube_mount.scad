//  Spark Studio
//  Mount Plastic Tubes on Metal Shelf
//  by Richard
//

/*######################################################/*

    CONFIGURATION

/*######################################################*/

include <BOSL2/std.scad>

bottom = false;

module hide_variables () {}	// variables below hidden from Customizer

$fn=72;

tube_id = 29;
tube_od = 32;
wall = 2;               //  Insert wall thickness
mount_od = tube_od + 2 * wall;           
tubewall = 1.35;        //  Tube wall thickness
ring = bottom ? 25: 15; //  Height of Ring

tube_grip();
flat();

/*######################################################/*

    MODULES

/*######################################################*/

module tube_grip() {
    if (bottom) {
        diff() {
            tube(od = tube_od + wall, id = tube_id - wall, h = 1, anchor = BOT)
            attach(BOT) rounding_cylinder_mask(d=mount_od, rounding = 2);
        }
        tube(od = tube_id, wall = wall, h = ring, anchor = BOT);
    }
    diff() {
        tube(id = tube_od, wall = wall, h = ring, anchor = BOT)
        yrot_copies(n = 2) attach(TOP) rounding_cylinder_mask(d=mount_od, rounding = 2);
    }
}

module flat() {
    side = mount_od;
    right(side/4)
    difference() {
        cuboid([side/2, side, ring], rounding = 2, except = LEFT, anchor = BOT)
            attach(RIGHT) post();
        left (side/4) cyl(d = side, h = ring, rounding = 2, anchor = BOT);
    }
}

module post() {
    A = 12;
    B = 6;
    C = 3;
    D = 5;
    down(wall) yrot(180) cyl(d = B, h = C, anchor = TOP)
    attach(BOT) cyl(d = A, h = C, rounding1 = 0.5, rounding2 = 0.5, anchor = BOT);
}