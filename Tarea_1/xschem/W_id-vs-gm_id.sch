v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 3670 -540 3710 -540 {
lab=vgs}
N 3670 -590 3670 -540 {
lab=vgs}
N 3750 -540 3750 -470 {
lab=GND}
N 3750 -670 3750 -570 {
lab=vd}
C {devices/gnd.sym} 3750 -470 0 0 {name=l3 lab=GND}
C {devices/iopin.sym} 3670 -590 0 0 {name=p5 lab=vgs}
C {sg13g2_pr/sg13_lv_nmos.sym} 3730 -540 2 1 {name=M1
l=\{length\}
w=\{width\}
ng=1
m=\{mult\}
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/code_shown.sym} 3380 -630 0 0 {name=MODEL1 only_toplevel=true
format="tcleval( @value )"
value="

.param corner=0

.if (corner==0)
.lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.endif
"}
C {code.sym} 3510 -750 0 0 {name=Simulation only_toplevel=false value="
.option wnflag=1

.param length= 0.26u
.param width = 1u
.param mult = 1


vin vgs 0 0.520
vds vd 0 1.2

.control

shell rm -f gmid_sweep_w.raw

save all
save @n.xm1.nsg13_lv_nmos[gm]
save @n.xm1.nsg13_lv_nmos[ids]

dc vds 0.01 1.8 0.01
let idn  = @n.xm1.nsg13_lv_nmos[ids]
let gmn  = @n.xm1.nsg13_lv_nmos[gm]

let gmid = gmn/idn
let idw  = idn/1u 
wrdata gmid_sweep_w.raw gmid idw	
.endc

"

}
C {devices/iopin.sym} 3750 -670 0 0 {name=p1 lab=vd}
