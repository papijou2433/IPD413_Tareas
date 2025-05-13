v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -10 -200 -10 -40 {
lab=vg}
N -50 -200 -10 -200 {
lab=vg}
N 140 -200 140 -40 {
lab=vg}
N -10 -200 140 -200 {
lab=vg}
N 30 -180 30 -70 {
lab=vd}
N 30 -40 30 20 {
lab=GND}
N 180 -110 180 -70 {
lab=GND}
N 180 -40 180 30 {
lab=vd}
C {launcher.sym} -50 100 0 0 {name=h1
descr="Annotate value/s"
tclcommand="xschem annotate_op"}
C {gnd.sym} 30 20 0 0 {name=l2 lab=GND}
C {code_shown.sym} -560 -170 0 0 {name=Simulaton only_toplevel=false value="
vgs vg 0 3.3
vds vd 0 3.3
.control
save all
save @n.xm1.nsg13_hv_nmos[ids]
save @n.xm1.nsg13_hv_nmos[vth]
save @n.xm2.nsg13_hv_pmos[ids]
save @n.xm2.nsg13_hv_pmos[vth]

dc vgs 0.0 3.3 0.05
let idn  = @n.xm1.nsg13_hv_nmos[ids]
let vthn = @n.xm1.nsg13_hv_nmos[vth]
let idp  = @n.xm2.nsg13_hv_pmos[ids]
let vthp = @n.xm2.nsg13_hv_pmos[vth]

print vthn vthp
plot idn 
plot -idp

.endc
"}
C {devices/code_shown.sym} -560 240 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib cornerMOShv.lib mos_tt
"}
C {sg13g2_pr/sg13_hv_nmos.sym} 10 -40 2 1 {name=M1
l=0.45u
w=1.0u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {ipin.sym} -50 -200 0 0 {name=p1 lab=vg}
C {ipin.sym} 30 -180 0 0 {name=p2 lab=vd}
C {sg13g2_pr/sg13_hv_pmos.sym} 160 -40 2 1 {name=M2
l=0.45u
w=1.0u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {ipin.sym} 180 30 0 0 {name=p3 lab=vd}
C {gnd.sym} 180 -110 2 0 {name=l1 lab=GND}
