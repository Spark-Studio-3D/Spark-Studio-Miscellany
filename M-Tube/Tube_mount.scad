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
eps = 0.01;
tube_id = 28;
tube_od = 32;
wall = 2;       //  Insert wall thickness
mount_od = tube_od + 2 * wall;           
floor = 2;      //Floor Thickness
d_btn = 12;     //Button Dia
h_btn = 3;      //Button Thickness
d_post = 6;     //Post Dia
h_post = 4.5;   //Post Height

ring = bottom ? 20: 15; //  Height of Ring
/*######################################################*/


tube_grip();
flat();

/*######################################################/*

    MODULES

/*######################################################*/

module tube_grip() {
    if (bottom) {
        diff() {
            tube(od = tube_od + wall, id = tube_id - wall, h = floor, anchor = BOT)
            attach(BOT) rounding_cylinder_mask(d=mount_od, rounding = 2);
        }
        *tube(od = tube_id, wall = wall, h = ring, anchor = BOT);
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
        left (side/4) down(eps/2) cyl(d = side, h = ring + eps, rounding = 2, anchor = BOT);
    }
}

module post() {
   
    down(wall) yrot(180) cyl(d = d_post, h = h_post, anchor = TOP)
    attach(BOT) cyl(d = d_btn, h = h_btn, rounding1 = 0.5, rounding2 = 0.5, anchor = BOT);
}