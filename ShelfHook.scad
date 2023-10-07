include <BOSL2/std.scad>
$fn = 72;
A = 12;
B = 6;
C = 2.5;
D = 5;
fudge = 1;
base = [55, 35, D-C];
loop = 30;

hook();
left(30) post();

module hook(){
    difference() {
        union() {
            cyl(d = base.y, h = base.z, anchor = BOT);
            cuboid(base, anchor = LEFT+BOT);
        }
        zrot(180) slot();
    }
    right(base.x) loop();

}


module loop() {
    right_half(s=200)
    xrot(90) tube(od = loop, h = base.y, wall = base.z, anchor = FWD);
}

module slot() {
    hull(){
        cyl(d = A + fudge, h = D, anchor = BOT);
        right(10)  cyl(d1 = B, d2 = A + fudge, h = D, anchor = BOT);
    }
}


module post() {
    cyl(d = A, h = C, anchor = BOT, rounding1 = 0.5, rounding2 = 0.5)
        attach(TOP) cyl(d = B, h = C, anchor = BOT)
            attach(TOP) cyl(d1 = B, d2 = A, h = D, anchor = BOT);
}