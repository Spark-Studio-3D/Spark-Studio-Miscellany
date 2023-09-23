//  Spark Studio
//  Tube fittings for lighted M sign from 28mm tubes.
//  by Richard
//

/*######################################################/*

    CONFIGURATION

/*######################################################*/

include <BOSL2/std.scad>
$fn=72;

eps = 0.1;
dia = 29;           //  Tube id
neck = 30;          //  Length of neck
wall = 1;           //  Insert wall thickness
tubewall = 1.35;    //  Tube wall thickness
hole = 4;           // Mounting hole dia.
spread = dia/2; 
offset = [-dia/5,-dia/5,0];
dia2 = dia + 2 * tubewall;    //  Tube od  
id = dia - wall * 2;          //  Insert id
base = wall + tubewall ;  //  Height of base  
rgn = [ circle(d =dia2), circle(d = dia - 2 * wall) ];



joint45();



/*######################################################/*

    MODULES

/*######################################################*/

module joint90() {
    tfm = [
        down(neck/2),
        for (a=[0:5:90]) yrot(a, cp=[dia2/2+eps,0,0]),
        move([neck/2 + dia2/2,0,dia2/2]) * yrot(90),
    ];
    sweep(rgn, tfm, closed=false, caps=true);


    tube(od = dia, wall = wall, h = neck, anchor = TOP);
    up(dia2/2) right(dia2/2) yrot(90) tube(od = dia, wall = wall, h = neck, anchor = BOT);

    right(dia/2) fwd(dia/2) {
        difference() {
        up(0.5) ycyl(d = dia, h = base, rounding2 = base/2);
            right(dia/5) down(dia/5) 
                ycyl(d = hole, h = base+eps);
        }
    }
}

module joint45() {
    tube(od = dia, id = id, l = neck, anchor = BOT);
    up(neck/2) tube(od = dia2, id = id, l = neck/2, anchor = BOT);
    up(neck) {
        rgn = [ circle(d =dia2), circle(d = dia - 2 * wall) ];
        tfm = [

            for (a=[0:5:135]) yrot(a, cp=[dia2/2+eps,0,0]),
            
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