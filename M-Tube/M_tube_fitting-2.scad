//  Spark Studio
//  Tube fittings for lighted M sign from 28mm tubes.
//  by Richard
//

/*######################################################/*

    CONFIGURATION

/*######################################################*/

include <BOSL2/std.scad>

angle = 30;         //  [30,60,90]
pin = true;         //  [true,false]

tube_id = 16.8;     //  Tube id
tube_wall = 2.6;    //  Tube wall 

insert_wall = 2;    //  Insert wall 


module hide_variables () {}	// variables below hidden from Customizer

$fn=72;
eps = 0.1;


tube_od = tube_id + 2 * tube_wall;    //  Tube od  
tube_ir = tube_id/2;     //  Tube internal radius

insert_h = 10;          //  Length of insert
insert_id = tube_id - insert_wall * 2;  //  Insert id

sweep_offset = 0.01; //  Sweep rotation centerpoint offset from tubing edge
fudge = 0.14;

base = tube_wall;   //  Height of base  
//tab = +neck/2;    //  Mounting Tab
hole = 4;           //  Mounting hole dia.

card  = 1;          //LED backing card thickness
pin_d = 2;          //LED strip routing pin

rgn = [ circle(d = tube_od), circle(d = insert_id) ]; 



diff() {
    elbow(angle);
    tag("remove") cyl(d = 20, h = tube_wall - 1.5, anchor = BOT);              
}



/*######################################################/*

    MODULES

/*######################################################*/



module elbow(angle) {
    tfm = [ 
        for (a=[0: 5 : 180 - angle]) yrot(a, cp=[tube_od/2,0,0]), 
    ];
    
    left(tube_od/2) up(tube_od)
        yrot(180 + angle/2, cp = [tube_od/2, 0, 0])  
  
    sweep(rgn, tfm, closed=false, caps=true); 
        

    xflip_copy() {
        up(tube_od - (sin(angle/2) * tube_od/2)) right(cos(angle/2) * tube_od/2) yrot(angle/2) neck();
        //up(tube_od - (sin(angle/2) * tube_od/2)) right(cos(angle/2) * tube_od/2) color("red") sphere(.25);
    }
    if (pin == true) { up(tube_od/2) ycyl(d = pin_d, h = tube_id); }       //LED routing pin

}




module neck() {
    tag_scope("neck")
    diff() {
        tube(od = tube_od, id = insert_id, h = insert_h/2, anchor = BOT) {
            attach(TOP) tube(od = tube_id, id = insert_id, h = insert_h, anchor = BOT)
                tag("remove") attach(TOP) cuboid([tube_id, card, insert_h], anchor = TOP);
        }
    }
}


