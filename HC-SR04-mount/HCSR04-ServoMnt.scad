// Servo Mount for SainSmart HC-SR04 ultrasonic distance sensor
// from http://www.amazon.com/gp/product/B004U8TOE6/
// WARNING: similar devices (even with identical part number)
// have different dimensions, so measure yours before printing
// by J.Beale 31-Dec-2014

slop = 0.25; // allowance for printer tolerance
// ----------------------------------------------------
// Parameters of HC-SR04 circuit board
SSEP = 25.4; // center separation of ultrasonic xducers
SZ = 11.9; // height of transducer cylinders
SOD = 16.0+slop; // OD of transducer cylinders

PCBX = 45.35+slop; // length of PCB
PCBY = 20.5; // width of PCB
PCBZ = 1.6+slop; // z-height of PCB
XTLX = 10.3; // crystal length
XTLY = 4.53; // crystal width
XTLZ = 3.7; // crystal z-height
// HOD = 1.5; // ID of corner mounting holes ID
HOD = 0; // ID of corner mounting holes ID
HCX = 42.35; // X centers of mounting holes
HCY = 17.0; // Y centers of mounting holes
// ----------------------------------------------------

fn = 60; // facets on a circle
eps = 0.03; // a small number

module xducer() {
  translate([SSEP/2,0,0])
    cylinder(d=SOD, h=SZ, $fn=fn); // ult.xducer 1
  translate([-SSEP/2,0,0])
    cylinder(d=SOD, h=SZ, $fn=fn); // ult.xducer 2
}

module xtal() {
    translate([-XTLX/2,XTLY,0]) cube([XTLX,XTLY,XTLZ]);
    
}
module PCB() {
  difference() {
    translate([-PCBX/2,-PCBY/2,0])
      cube([PCBX,PCBY,PCBZ]);    
      // 4x mounting holes at corners
    translate([HCX/2,HCY/2,-PCBZ])
       cylinder(d=HOD, h=PCBZ*3, $fn=12);
    translate([-HCX/2,HCY/2,-PCBZ])
       cylinder(d=HOD, h=PCBZ*3, $fn=12);
    translate([HCX/2,-HCY/2,-PCBZ])
       cylinder(d=HOD, h=PCBZ*3, $fn=12);
    translate([-HCX/2,-HCY/2,-PCBZ])
       cylinder(d=HOD, h=PCBZ*3, $fn=12);
  }
}

module HCSR04() {
  color("grey") translate([0,0,PCBZ]) xducer();
  color([.1,.1,.6]) PCB();
  color([.6,.6,.6]) translate([0,0,PCBZ]) xtal();
  color([.8,.7,.7]) rotate([0,0,180]) 
    translate([0,5,PCBZ]) scale([1,.5,0.5]) xtal();
}


// =============================================================

// Draw a prism based on a right triangle
// l:length, w: width, h: height
// from https://github.com/dannystaple/OpenSCAD-Parts-Library/blob/master/prism.scad
module prism(l, w, h) {
  translate([0, l, 0]) rotate( a= [90, 0, 0])
  linear_extrude(height = l) polygon(points = [
    [0, 0],
    [w, 0],
    [0, h]
  ], paths=[[0,1,2,0]]);
}

BX = PCBX + 4; // mounting base X length
BY = 21; // mounting base Y width
BZ = 5; // mounting base Z thickness 1
BZS = 2; // mounting base Z thickness 2
BZO = 1; // mounting base Z offset
SPX = 3; // side post X width
SPY = 5; // side post Y width
BMH = 32; // base mounting hole center spacing
BMHID = 1.6+0.2; // ID of base mounting holes
BMHY = BY-5.5; // mounting hole Y offset
CMHID = 6.0+slop; // center mnt. hole ID
MTX = 12.0; // front tab X width
MTY = 21; // front tab Y length
MTHY = 15; // mounting tab hole Y offset

module rtab() {
  difference() {
    hull() {
     translate([0,MTY-MTX/2,0]) cylinder(d=MTX,h=BZS,$fn=50);
     translate([0,-(MTY-MTX/2),0]) cylinder(d=MTX,h=BZS,$fn=50);
    }
    translate([0,MTHY,-BZ*2]) cylinder(d=BMHID, h=BZ*4, $fn=10); // hole
  }
}
 
module pcb_holder1() {
 difference() {
  union() {
    intersection() {
      translate([-BX/2,-2,BZO-BZ]) cube([BX,BY,BZ]); // mounting base underneath
      translate([0,0,-BZ]) cylinder(d=BX+3, h=BZ*4, $fn=150); // round off edges
    }
    translate([0,BMHY,BZO-BZ]) rtab(); // front tab
  }
  translate([-BMH/2,BMHY,-BZ*2]) cylinder(d=BMHID, h=BZ*4, $fn=10); // hole 1
  translate([BMH/2,BMHY,-BZ*2]) cylinder(d=BMHID, h=BZ*4, $fn=10); // hole 2    
  translate([0,BMHY,-BZ*2]) cylinder(d=CMHID, h=BZ*4, $fn=30); // hole 3    
  translate([-BX/2-eps,3.1,BZO-(BZ-BZS)]) cube([BX+2*eps,BY,BZ]); // mounting base notch
 }

 translate([-BX/2,-2,0]) cube([SPX,SPY,PCBY-eps]); // side post 1
 translate([BX/2-SPX,-2,0]) cube([SPX,SPY,PCBY-eps]); // side post 2
 translate([BX/2,2,-2]) rotate([0,0,90]) prism(2,6.8,20); // wedge1
 translate([-BX/2+2,2,-2]) rotate([0,0,90]) prism(2,6.8,20); // wedge2
}

module pcb_holder() {
  difference() {
    pcb_holder1();
    translate([0,0,PCBY/2]) rotate([-90,0,0]) HCSR04();
  }
}

// translate([0,0,SZ+PCBZ]) horn();
// horn();
// translate([0,0,IDPTH-(SZ+PCBZ)]) HCSR04(); // ultrasonic transducer module

pcb_holder();
// translate([0,0,PCBY/2]) rotate([-90,0,0]) HCSR04();
