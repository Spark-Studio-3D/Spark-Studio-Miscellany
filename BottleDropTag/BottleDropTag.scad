include <BOSL2/std.scad>
include <BDQR-58mmRev.scad>

  
    *heightfield(data = image_data, size = [30,30], style = "default", bottom = -1, maxz = 10);



 zscale(1/25)
     surface(file = "BDQR-58mmRev.png", center = true, convexity = 20, $fn = 100);