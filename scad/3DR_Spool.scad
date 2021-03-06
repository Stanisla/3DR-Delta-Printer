include <3DRAux.scad>

spool();

vLspool=[2,13,2,6];
module spool_nh(){
	cylinder(r1=rbSpo,r2=rSpo,h=vLspool[0]);
	translate([0,0,sumV(v=vLspool,i=0)])
		cylinder(r=rSpo,h=vLspool[1]);
	translate([0,0,sumV(v=vLspool,i=1)])
		cylinder(r1=rSpo,r2=rbSpo,h=vLspool[2]);
	translate([0,0,sumV(v=vLspool,i=2)])
		cylinder(r=rbSpo,h=vLspool[3]);
}
module line_hole(){
	translate([0,rSpo-2,-sol]) rotate([0,0,0])
		cylinder(r=1,h=sumV(v=vLspool,i=1));
	translate([0,rSpo+1,vLspool[0]+1]) rotate([45,0,0])
		cylinder(r=1,h=3.5);
	translate([0,rSpo-2,vLspool[1]-1.5]) rotate([-45,0,0])
		cylinder(r=1,h=4);
}
//line_hole();
module spool(){
	//Spool holes height
	hSpoHol=sumV(v=vLspool,i=1)+(vLspool[2]+vLspool[3])/2;
	difference(){
		spool_nh();
		translate([0,0,-sol])
			cylinder(r=M5r,h=sumV(v=vLspool,i=3)+2*sol);
		/*%translate([0,(rbSpo+rSpo)/2,vLspool[0]+1]) rotate([135,0,0])
			cylinder(r=1,h=4*vLspool[0]);*/
		/*%translate([0,rSpo-2,-sol]) rotate([0,0,0])
			cylinder(r=1,h=sumV(v=vLspool,i=2));
		%translate([0,rSpo-0.8+2,vLspool[0]]) rotate([45,0,0])
			cylinder(r=1,h=sumV(v=vLspool,i=2));*/
		line_hole();
		for(i=[0:2]) rotate(120*i){
			translate([-rbSpo/2+0,rSpo,sumV(v=vLspool,i=1)])
				cube([rbSpo,rSpo-2,vLspool[2]+vLspool[3]+sol]);
			translate([0,M5r-1,hSpoHol])
				rotate([-90,0,0]) cylinder(r=M3r,h=rSpo);
			translate([0,rSpo-1+sol,hSpoHol])	
				rotate([-90,0,0]) cylinder(r=2*M3r,h=1.5);
			translate([-M3r*2,rSpo-1+sol,hSpoHol])
				cube([M3r*4,M3r*4,10]);
			translate([0,3*M3h/2,hSpoHol]){	//z=19		
				rotate([-90,90,0]) cylinder(r=M3nr/2,h=M3h,$fn=6);
				translate([-M3n/2,0,0])
					cube([M3n,M3h,M3n]);
			}
		}
	}	
}

