//  Spark Studio
//  Tube fittings for lighted M sign from 20mm tubes.
//  by Richard
//

/*######################################################/*

    CONFIGURATION

/*######################################################*/

include <BOSL2/std.scad>

part = "all";       //  [all,elbow,neck,tab]
angle = 90;         //  [30,60,90]
pin = true;         //  [true,false]
mount = true;       //  [true,false]    
flat = true;        //  [true,false]    

tube_id = 16.85;    //  Tube id             <-- Adjust this value to fit for over/under extrusion
tube_wall = 2.6;    //  Tube wall 

insert_wall = 2;    // Insert wall 
insert_h = 10;      // Length of insert
neck_h = 7;         // Length of neck 

card  = 1.5;        // LED backing card slot
pin_d = 2;          // LED strip routing pin
hole = 4;           // Mounting hole diameter



module hide_variables () {}	// variables below hidden from Customizer

$fn=72;
eps = 0.1;


tube_od = tube_id + 2 * tube_wall;    //  Tube od  
tube_ir = tube_id/2;     //  Tube internal radius

insert_id = tube_id - insert_wall * 2;  //  Insert id

tab = [hole * 2 , 2, tube_od/2];      //  Mounting Tab  



/*####################### MAIN ###############################*/

if (part == "all")   M_tube_fitting(angle);
if (part == "elbow") elbow(angle);
if (part == "neck")  neck();
if (part == "tab")   tab();



/*#########################  Modules #############################*/

module M_tube_fitting (angle) {
    diff() {
        elbow(angle);
        if (flat) tag("remove") cyl(d = 20, h = tube_wall - 1.5, anchor = BOT);   // Flatten Bottom        
    }
    xflip_copy() {  //place neck at each end of elbow
        up(tube_od - (sin(angle/2) * tube_od/2)) right(cos(angle/2) * tube_od/2) yrot(angle/2) neck();
    }

    if (pin)  up(tube_od/2) ycyl(d = pin_d, h = tube_id);      //LED strip routing pin

    if (mount) fwd(tube_od/2 - tab.y)  up(tube_od * 2/3) tab();  //Mounting pad w/screw hole
}

module elbow(angle) {
    region = [ circle(d = tube_od), circle(d = insert_id) ]; 
    
    transforms = [ 
        for (a=[0: 5 : 180 - angle]) yrot(a, cp=[tube_od/2,0,0]), 
    ];

    left(tube_od/2) up(tube_od)                      // Reposition to place bottom center 
        yrot(180 + angle/2, cp = [tube_od/2, 0, 0])  // of the elbow at the origin after the sweep.
  
    sweep(region, transforms, closed=false, caps=true);     
}


module neck() {
    tag_scope("neck")
    diff() {
        tube(od = tube_od, id = insert_id, h = neck_h, anchor = BOT) {                      //Tube neck
            attach(TOP) tube(od = tube_id, id = insert_id, h = insert_h, anchor = BOT)      //Tube insert
                tag("remove") attach(TOP) cuboid([tube_id, card, insert_h], anchor = TOP);  //Card alignment slots
        }
    }
}

module tab() {
    difference() {
        conv_hull() {
            ycyl(d = 1.4 * tab.x, h = tab.y, anchor = BACK);
            up(tube_od/2 + hole/4) ycyl(d = tab.x, h = tab.y, anchor = BACK);
        }
        up(tube_od/2) tag("remove") ycyl(d = hole, h = tab.y, rounding2 = -tab.y/2, anchor = BACK);
    }
}
