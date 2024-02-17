// use via other config runner or uncomment one special config and one label line

include <config/common.config.scad>

// include <config/narrow_text.config.scad> 
// label = "one";
// label = "zero";
// label = "plus";
// label = "minus";
// label = "minus_i";
// label = "plus_i";


// include <config/axis.config.scad>
// label = "x";
// label = "plus_x";
// label = "minus_x";
// label = "y";
// label = "plus_y";
// label = "minus_y";
// label = "z";
// label = "plus_z";
// label = "minus_z";


//include <config/wide_text.config.scad>
//label = "plus_wide";
// label = "minus_wide";
// label = "plus_i_wide";
// label = "minus_i_wide";

//get full file name
label_filename = str("svg/", label, ".svg");

//calculate length
calcL = pinL - pinFreeL + bodyR;
bodyL = calcL > minBodyL ? calcL : minBodyL;

//draw
rotate([0, 90, 0])
difference() {
    union() {
        color("lime", 0.3) pinBody();
        translate([0,0, (bodyL + bodyR) *platePositionRatio]) rotate([90,0,-90]) 
        {
            plate(25 / 16 * plateH * labelW);
            translate([labelXShift * plateH / 16 ,0,plateT - eps])
                color("brown") label();
        }
    }
    
    translate([0,0,-pinFreeL])
        color("blue", 0.5) steelPin();
    
    translate([pinL, 0, 0]) cube(size=[2 * pinL, 2 * pinL, 2 * pinL], center=true);
}

module pinBody() {
    cylinder(r=bodyR, h=bodyL);
    translate([0,0,bodyL]) sphere(r=bodyR);
    cylinder(r = stopperR, h =stopperH);
    
}

module steelPin() {    
    translate([0,0,pinL]) rotate([180,0,0]) {
        cylinder(r= pinR + play, h = pinL);
        translate([0,0,-play]) cylinder(r = pinHeadR + play, h = pinHeadH + 2 * play );
    }
}

module label() {
    linear_extrude(height=engrave)
         scale(svgScale * plateH)
             import(label_filename, center = true);    
}

module plate(l) {
    linear_extrude(plateT)
    translate([-l / 2, -plateH / 2, 0])
        rounded_rectangle(l, plateH, plateCornerR);
}

module rounded_rectangle( length, width, radius_corner ) {
	translate( [ radius_corner, radius_corner, 0 ] )
		minkowski() {
			square( [length - 2 * radius_corner,  width - 2 * radius_corner] );
			circle( radius_corner );
		}
}