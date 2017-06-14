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
            }
            // Take into account tolerances !!!
            translate([-82,-3.8,0])
                cube([3-0.5,8-0.5,100-2],center=true);
            translate([82,-3.8,0])
                cube([3-0.5,8-0.5,100-2],center=true);
            } 
            // Head top shelf
            head_top_shelf(0,4,-10);
        }   
        // Screen
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
        top_base(0,-105,0);
}
// Bottom base
color([1,0,0])
    bottom_base(0,-200,0);
// Groove
groove(40,-180,0);

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
        translate([-60,-80,0])
            cube([25,100,80],center=true);
        translate([60,-80,0])
            cube([25,100,80],center=true);
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
    // Head top support
    translate([0,1.5,-10])
    difference() {
        cube([172,3,120],center=true); 
        cube([142,5,130],center=true); 
        // Holes
        translate([74.5,0,0])
            rotate([90,0,0])
            cylinder(r=1.375,h=10,center=true);
        translate([-74.5,0,0])
            rotate([90,0,0])
            cylinder(r=1.375,h=10,center=true);
    }
}

// Draw head top shelf
module head_top_shelf(x,y,z) {
    translate([x,y,z])
    difference() {
        cube([155,2,120],center=true); 
        translate([22,11,10])
            rotate([90,90,0])
            hull() {
                translate([-(85-6)/2,-(56-6)/2,0]) 
                    cylinder(r=3,h=10.4);
                translate([-(85-6)/2, (56-6)/2,0]) 
                    cylinder(r=3,h=10.4);
                translate([ (85-6)/2,-(56-6)/2,0]) 
                    cylinder(r=3,h=10.4);
                translate([ (85-6)/2,(56-6)/2,0]) 
                    cylinder(r=3,h=10.4);
            }
        translate([74.5,0,0])
            rotate([90,0,0])
            cylinder(r=1.375,h=10,center=true);
        translate([-74.5,0,0])
            rotate([90,0,0])
            cylinder(r=1.375,h=10,center=true);
        translate([22,0,10])
            rotate([90,90,0])
            union() {
                translate([-85/2+3.5,-49/2,-1]) 
                    cylinder(d=2.75,h=3);
                translate([-85/2+3.5,49/2,-1]) 
                    cylinder(d=2.75, h=3);
                translate([58-85/2+3.5,-49/2,-1])
                    cylinder(d=2.75,h=3);
                translate([58-85/2+3.5, 49/2,-1])
                    cylinder(d=2.75,h=3); 
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
                    linear_extrude(height=5)
                    hull() {
                        circle(d=10,$fn=40);
                        translate([14,0])
                            circle(d=8,$fn=40);
                    }
                    translate([0,0,1])
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
                        cylinder(d=1+0.2,h=10,$fn=10);
            translate([0,0,-30])
                cylinder(d=6.7+0.5,h=200,$fn=40);
            translate([0,0,0])
                cylinder(d=10,h=200,$fn=40);
            translate([0,0,0])
                cylinder(d=62,h=7,$fn=resolution,center=true);
            translate([0,-50,0])
                cube([32,100.5,7],center=true);
            translate([0,-92,0])
                cylinder(d=2,h=100,$fn=40);
            }
}

// Draw top base module
module top_base(x,y,z) { 
    translate([x,y,z])
    rotate([90,0,0]){
    difference() {
    union() {       
        cylinder(r=100,h=15,$fn=resolution,center=true);
        translate([60,0,-15])
        rotate([90,0,90])
        difference() {
            translate([0,5,0])
                cube([32-0.5,20,7-0.5],center=true);
            translate([0,2,-40])
                cylinder(d=2,h=100,$fn=40);
        }     
        translate([-60,0,-15])
        rotate([90,0,90])
        difference() {
            translate([0,5,0])
                cube([32-0.5,20,7-0.5],center=true);
            translate([0,2,-40])
                cylinder(d=2,h=100,$fn=40);
        }
    }
    //cylinder(r=70,h=9,$fn=resolution);
    translate([0,0,-4])
    gear(number_of_teeth=80,
        circular_pitch=318,
        clearance = 0.2,
        gear_thickness = 80,
        rim_thickness = 80,
        rim_width = 2,
        bore_diameter=0,
        circles=0);
    //
    translate([0,0,7.8])
        rotate_extrude(convexity = 100, $fn = 40) 
        translate([86, 0, 0])
            circle(r = 6.35, $fn = 20,center=true);    
    }
    
    difference() {
        cylinder(r=5,h=15,$fn=resolution,center=true);
        translate([0,0,12])
            cylinder(r=1.375,h=15,$fn=resolution,center=true);   
    }
    }
}

// Draw bottom base module
module bottom_base(x,y,z) {
    translate([x,y,z])
        rotate([90,0,0])
        difference() {
            cylinder(r=100,h=20,$fn=resolution,center=true);
            translate([0,0,-15])
                cylinder(r=70,h=40,$fn=resolution,center=true);   
            translate([85,0,-10])
                sphere(r=7.5, resolution=20, center=true);
            translate([-85,0,-10])
                sphere(r=7.5, resolution=20, center=true);
            translate([0,85,-10])
                sphere(r=7.5, resolution=20, center=true);
            translate([0,-85,-10])
                sphere(r=7.5, resolution=20, center=true);
        }       
}

module groove(x,y,z) {
    translate([x,y,z])
    rotate([90,0,0])
    union() {
        difference() {
            cylinder(h=16,r=8,$fn=resolution);
            translate([-1.5,-2.5,0])
                cube([3,5,16+0.1],1);
            translate([0,0,9+(7/2)]) 
            rotate([0,90,0])  
                cylinder(h=30,r=1.3,$fn=resolution);
        }
        //cylinder(r=20,h=9,$fn=resolution);
            gear(number_of_teeth=20,
            circular_pitch=318,
            clearance = 0.2,
            gear_thickness = 8,
            rim_thickness = 8,
            rim_width = 2,
            bore_diameter=0,
            circles=0);
    }
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