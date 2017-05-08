resolution = 80;

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
                translate([-82,-3.8,0])
                    cube([3,8,100],center=true);
                translate([82,-3.8,0])
                    cube([3,8,100],center=true);
            }  
            // Head top
            union() {
            difference() {
                head();
                translate([0,-100-0.01,100])
                    cube([200,200,400],center=true);
               // Temporal hole for prototyping
               translate([0,100,-70])
                    cube([50,100,50],center=true);
            }    
            translate([-82,-3.8,0])
                cube([3,8,100],center=true);
            translate([82,-3.8,0])
                cube([3,8,100],center=true);
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
        leg(-60,0,0);
    // Right leg
    color([1,1,1])
        leg(60,-0,0);
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
                    translate([0,0,67.5])
                        cylinder(r=69,h=2.5,$fn=resolution,center=true);
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
    difference(){
        translate([-30,-55,0])
            cube([20,70,50],center = true);    
        translate([-39,-35,0])
            cube([3,12,32],center = true);
        translate([-30,-35,0])
            cube([30,12,23],center = true);
        difference(){
            cube([200,200,200],center = true);
            scale([1.2,1])
                cylinder(r=72,h=140,$fn=resolution,center=true);
        }
    }
    difference(){
        translate([30,-55,0])
            cube([20,70,50],center = true);   
        translate([39,-35,0])
            cube([3,12,32],center = true);
        translate([30,-35,0])
            cube([30,12,23],center = true);
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
        difference(){
            scale([1.2,1])
                translate([0,0,-2.5])
                    cylinder(r=69,h=2.4,center=true);
                cube([115,70,10],center = true);
        }
        
        translate([0,0,-2.5])
        difference(){
                translate([0,0,-2.5])
                    cube([125,80,5],center=true);
            translate([0,0,0])
                cube([120,75,20],center = true);
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
            union(){
                linear_extrude(15,center=true)
                    circle(r=35,center=true);
                translate([0,-50,0])
                    cube([40,100,15],center=true);
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