include <BOSL2/std.scad>
$fn=36;

base = [50,50,1];
Rcyl = 5;
Hcyl = 30;
rFillet = 5;


dildo(140);

module dildo(h1) {
    

    cuboid(base, anchor = TOP ) ;
    cyl(r=Rcyl, h=h1, rounding1 = -rFillet, rounding2 = rFillet, anchor = BOT, $fn=4);
}




// rotate_extrude(angle=360)
// translate([Rcyl+2, 0, 0])
//     difference() {
//         square(rFillet);
//         translate([rFillet, rFillet,0]) circle(r = rFillet);
//     }
