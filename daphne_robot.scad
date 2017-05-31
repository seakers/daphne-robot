use <parametric_involute_gear.scad>

resolution = 60;

rotate([0,360*$t,0])
union() {
rotate_about([0,0,0],[35*sin($t*1440),0,0])
translate([0,35,0])
    union() {
        // Head top and bottom
        color([1,1,1])
        union() {
            // Head bottom
            difference() {
                head();
                translate([0,100-0.01,100])
                    cube([200,200,400],center=true);
                // Take into account tolerances !!!
                translate([-82,-3.8,0])
                    cube([3+0.5,8+0.5,100+2],center=true);
                translate([82,-3.8,0])
                    cube([3+0.5,8+0.5,100+2],center=true);
            }
            // Head top
            translate([0,0,0])

            union() {
            difference() {
                head();
                translate([0,-100+0.01,100])
                    cube([200,200,400],center=true);
               // Temporal hole for prototyping
               //translate([0,100,-70])
               //     cube([50,100,50],center=true);
            }
            //Add temporal support in the top
            translate([0,1.5,-10])
                difference() {
                    cube([172,3,120],center=true); 
                    cube([142,5,130],center=true); 
                    // Holes
                    translate([74.5,0,0])
                    rotate([90,0,0])
                        linear_extrude(200,center=true)
                            circle(r=1.25,center=true);

                    translate([-74.5,0,0])
                    rotate([90,0,0])
                        linear_extrude(200,center=true)
                            circle(r=1.25,center=true);
                }

            // Take into account tolerances !!!
            translate([-82,-3.8,0])
                cube([3-0.5,8-0.5,100-2],center=true);
            translate([82,-3.8,0])
                cube([3-0.5,8-0.5,100-2],center=true);
            }   
        }   
        //Screen
        color([1,1,0])
            screen(0,0,65);
        // Screen cover
        color([0,0,0])
           screen_cover(0,0,70);    
    }
    // Left leg
    color([1,1,1])
    rotate([0,180,0])
        leg(60,0,0);
    // Right leg
    color([1,1,1])
    rotate([0,0,0])
        leg(60,0,0);
    // Top base
    color([1,1,1])
        base(0,-100,0);
}
// Bottom base
color([1,0,0])
    base(0,-120,0);

// --- Draw modules

// Draw head module
module head() {  
    difference() {
        scale([1.2,1]) {
            union() {
                difference(){
                    cylinder(r=72,h=140,$fn=resolution,center=true);   
                    translate([0,0,-3])
                        cylinder(r=65,h=150,$fn=resolution,center=true);
                    // Take into account tolerances !!!
                    translate([0,0,67.5])
                        cylinder(r=69+0.5,h=2.5+0.5,$fn=resolution,center=true);
                }
                translate([0,0,70])
                    top_round(65,7,$fn=resolution);
                translate([0,0,-70])
                    bottom_round(55,17,$fn=resolution);
            }
        }
        translate([-60,-40,0])
            rotate([0,90,0])
                linear_extrude(20,center=true)
                    circle(r=40,center=true);
        translate([60,-40,0])
            rotate([0,90,0])
                linear_extrude(20,center=true)
                    circle(r=40,center=true);
    }
    // Take into account tolerances !!!
    difference(){
        translate([-28,-54.8,-23/4])
            cube([20,52,50],center = true);
        translate([-37,-35,-23/4])
            cube([3+0.5,12.6+0.5,31.5+0.5],center = true);
        translate([-28,-35,-23/4])
            cube([30+0.5,12.6+0.5,22.6+0.5],center = true);
        // Holes
        translate([-35,-35,-14-23/4])
            rotate([0,90,0])
                linear_extrude(10,center=true)
                    circle(r=1,center=true);
        translate([-35,-35,14-23/4])
            rotate([0,90,0])
                linear_extrude(10,center=true)
                    circle(r=1,center=true); 
        difference(){
            cube([200,200,200],center = true);
            scale([1.2,1])
                cylinder(r=72,h=140,$fn=resolution,center=true);
        }
    }
    // Take into account tolerances !!!
    difference(){
        translate([28,-54.8,-23/4])
            cube([20,52,50],center = true);
        translate([37,-35,-23/4])
            cube([3+0.5,12.6+0.5,31.5+0.5],center = true);
        translate([28,-35,-23/4])
            cube([30+0.5,12.6+0.5,22.6+0.5],center = true);
        // Holes
        translate([35,-35,-14-23/4])
            rotate([0,90,0])
                linear_extrude(10,center=true)
                    circle(r=1,center=true);
        translate([35,-35,14-23/4])
            rotate([0,90,0])
                linear_extrude(10,center=true)
                    circle(r=1,center=true);
        difference(){
            cube([200,200,200],center = true);
            scale([1.2,1])
                cylinder(r=72,h=140,center=true);
        }
    }
}

// Draw screen cover module
module screen_cover(x,y,z) {
    translate([x,y,z])
    union() {
        // Take into account tolerances !!!
        difference(){
            scale([1.2,1])
            translate([0,0,-2.5])
                cylinder(r=69-0.5,h=2.5-0.5,$fn=resolution,center=true);
            cube([115,70,10],center = true);
        }
        // Take into account tolerances !!!
        translate([0,0,-2.5])
        difference(){
            translate([0,0,-2.5])
                cube([127,82,5],center=true);
            translate([0,0,0])
                cube([122+0.5,77+0.5,20],center = true);
            //
            translate([70,50,0])
                cube([50,50,20],center = true);
            translate([70,-50,0])
                cube([50,50,20],center = true);
            translate([-70,50,0])
                cube([50,50,20],center = true);
            translate([-70,-50,0])
                cube([50,50,20],center = true);
        }
    }
}

// Draw screen module
module screen(x,y,z) {
    translate([x,y,z])
        cube([120,70,10],center = true);
}

// Draw leg module
module leg(x,y,z) {
    translate([x,y,z])
    rotate([0,90,0])
        difference() {
            union(){
                // Take into account tolerances !!!
                translate([0,0,-7.5])
                rotate([180,0,90])
                difference(){
                    linear_extrude(height=8)
                    hull() {
                        circle(d=10,$fn=40);
                        translate([14,0])
                            circle(d=8,$fn=40);
                    }
                    translate([0,0,5.5])
                    linear_extrude(height=5)
                    hull() {
                        circle(d=6+0.5,$fn=40);
                        translate([14,0])
                            circle(d=4+0.5,$fn=40);
                    }
                }
                cylinder(d=70,h=15,$fn=resolution,center=true);
                translate([0,-50,0])
                    cube([40,100,15],center=true);
            }
            rotate([0,0,90])
            translate([4,0,-15])
                for (i=[1:5])
                    translate([i*2,0])
                        cylinder(d=1+0.2,h=5,$fn=10);
            translate([0,0,-30])
                cylinder(d=6.7+0.5,h=200,$fn=40);
            translate([0,0,0])
                cylinder(d=10,h=200,$fn=40);
            translate([0,0,0])
                cylinder(d=62,h=7,$fn=resolution,center=true);
            translate([0,-50,0])
                cube([32,100.5,7],center=true);
            }
}

// Draw base module
module base(x,y,z) {
    translate([x,y,z])
        rotate([90,0,0])
            cylinder(r=100,h=20,$fn=resolution,center=true);
}

// --- Module functions
module halfcircle(r) {
    difference() {
        circle(r);
        translate([-r,-r])
            square([r*2,r]);
    }
}

module top_round(inradius,thick) {
    rotate_extrude(convexity = 10)
        translate([inradius+thick/2, 0, 0])
            halfcircle(thick/2);
}

module bottom_round(inradius,thick) {
    rotate([180,0,0]){
        rotate_extrude(convexity = 10)
            translate([inradius+thick/2, 0, 0])
                halfcircle(thick/2);
        linear_extrude(thick/2)
            circle(inradius+thick/2);
    }
}

module rotate_about(v,a) {
    translate(v)
        rotate(a)
            translate(-v)
                children(0);
}