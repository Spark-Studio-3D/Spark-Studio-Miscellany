//  Spark Studio
//  Mount Plastic Tubes on Metal Shelf
//  by Richard
//

/*######################################################/*

    CONFIGURATION

/*######################################################*/

include <BOSL2/std.scad>

bottom = true;

module hide_variables () {}	// variables below hidden from Customizer

$fn=72;
eps = 0.1;
tube_id = 28;
tube_od = 32;           
neck = 5;          //  Length of neck
wall = 1;           //  Insert wall thickness
tubewall = 1.35;    //  Tube wall thickness

if (bottom) {
    tube(od = tube_od + wall, id = tube_id - wall, h = 1, anchor = BOT);
    tube(od = tube_id, wall = wall, h = neck, anchor = BOT);
}
tube(id = tube_od, wall = wall, h = neck, anchor = BOT)
    *attach(RIGHT) post();

/*######################################################/*

    MODULES

/*######################################################*/


module post() {
    A = 12;
    B = 6;
    C = 2.5;
    D = 5;
    down(wall) yrot(180) cyl(d = B, h = C, anchor = TOP)
    attach(BOT) cyl(d = A, h = C, rounding1 = 0.5, rounding2 = 0.5, anchor = BOT);
}