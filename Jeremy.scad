include <BOSL2/std.scad>

cyl_height     = 16.5;
cyl_diameter   = 16.5;
hole_diameter  = 4.63;
nut_hole_width = 7.5; // inscribed diameter of nut
nut_height     = 6.67;

difference() {
    
    
    //tube(od=cyl_diameter, id=hole_diameter, l=cyl_height, anchor = BOT, $fn=72)
    cyl(d=cyl_diameter,  h=cyl_height, chamfer=0.75, anchor = BOT, $fn=72);
    cyl(d=hole_diameter, h=cyl_height, anchor = BOT, $fn=72);
    cyl(d=nut_hole_width, h=nut_height, anchor=BOT, $fn=6);
}


