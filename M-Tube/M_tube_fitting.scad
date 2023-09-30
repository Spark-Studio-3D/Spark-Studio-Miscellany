//  Spark Studio
//  Tube fittings for lighted M sign from 28mm tubes.
//  by Richard
//

/*######################################################/*

    CONFIGURATION

/*######################################################*/

include <BOSL2/std.scad>

angle = 45;         //  [45,90]

module hide_variables () {}	// variables below hidden from Customizer

$fn=72;
eps = 0.1;
dia = 29;           //  Tube id
neck = 20;          //  Length of neck
wall = 1;           //  Insert wall thickness
tubewall = 1.35;    //  Tube wall thickness
hole = 4;           // Mounting hole dia.
dia2 = dia + 2 * tubewall;    //  Tube od  
r2 = dia2/2;                  //  Tube radius
id = dia - wall * 2;          //  Insert id
base = wall + tubewall;       //  Height of base  
rgn = [ circle(d =dia2), circle(d = dia - 2 * wall) ];
tab = r2+neck/2;


if (angle == 45) joint45();
if (angle == 90) joint90();



/*######################################################/*

    MODULES

/*######################################################*/

module sub90() {  // 90 degree joint
    tfm = [
        down(neck/2),
        for (a=[0:5:90]) yrot(a, cp=[r2+eps,0,0]),
        move([neck/2 + r2,0,r2]) * yrot(90),
    ];
    sweep(rgn, tfm, closed=false, caps=true);


    tube(od = dia, wall = wall, h = neck, anchor = TOP);
    up(r2) right(r2) yrot(90) tube(od = dia, wall = wall, h = neck, anchor = BOT);

    fwd(r2-0.1) up(r2) {   // Mounting plate
        difference() {
            #cuboid([tab,base,tab], rounding = hole * 2.8, edges = "Y", anchor = FWD+LEFT+UP);
            right(neck) down(neck) fwd(eps/2)
                ycyl(d = hole, h = base+eps, anchor = FWD);
        }
    }
}

module joint90() {     // Reposition to make it more printable and add flat base
    right(11.27) up(20.55) yrot(-135) sub90();
    xscale(1.75) #cyl(d=dia/2 + 1, h=4.5, rounding1 = 4, teardrop = true, anchor = BOT);
}



module sub45() {  // 45 degree joint
    tube(od = dia, id = id, l = neck, anchor = BOT);
    up(neck/2) tube(od = dia2, id = id, l = neck/2, anchor = BOT);
    up(neck) {
        rgn = [ circle(d =dia2), circle(d = dia - 2 * wall) ];
        tfm = [

            for (a=[0:5:135]) yrot(a, cp=[r2+eps,0,0]),
            
        ];
        sweep(rgn, tfm, closed=false, caps=true) {
            attach(RIGHT+DOWN)
                union() {
                    tube(od = dia, id = id, l = neck, anchor = BOT);
                    up(neck/2) tube(od = dia2, id = id, l = neck/2, anchor = TOP);
                }
        }
    }        
}


module joint45() {     // Reposition to make it more printable and add flat base
   
        right(22.5) up(44.2) yrot(202.5) sub45();
        xscale(1.5) #cyl(d=dia/2 + 1, h=4.5, rounding1 = 4, teardrop = true, anchor = BOT);
}          



