v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 1180 -290 1180 -230 {
lab=GND}
N 1180 -360 1260 -360 {
lab=GND}
N 1260 -360 1260 -290 {
lab=GND}
N 1180 -290 1260 -290 {
lab=GND}
N 1180 -530 1330 -530 {
lab=d1}
N 1180 -330 1180 -290 {
lab=GND}
N 1180 -420 1180 -390 {
lab=#net1}
N 1180 -530 1180 -480 {
lab=d1}
N 970 -360 970 -310 {
lab=g1}
N 970 -360 1140 -360 {
lab=g1}
N 1330 -530 1330 -480 {
lab=d1}
C {devices/ipin.sym} 970 -360 0 0 {name=p1 lab=g1}
C {devices/iopin.sym} 1330 -530 0 0 {name=p2 lab=d1}
C {devices/gnd.sym} 1180 -230 0 0 {name=l3 lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 1160 -360 2 1 {name=M1
l=0.5u
w=5u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/code_shown.sym} 550 -300 0 0 {name=MODEL1 only_toplevel=true
format="tcleval( @value )"
value="

.param corner=0

.if (corner==0)
.lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.endif
"}
C {ammeter.sym} 1180 -450 0 0 {name=Vmeas savecurrent=true spice_ignore=0}
C {code.sym} 570 -430 2 1 {name=Simulacion only_toplevel=false value=
"
.control
save all
save @n.xm1.nsg13_lv_nmos[ids]
save @n.xm1.nsg13_lv_nmos[gm]
op

dc vgs 0.01 1.8 0.01 vds 0.45 1.35 0.45

let idn = @n.xm1.nsg13_lv_nmos[ids]
let gmn = @n.xm1.nsg13_lv_nmos[gm]
let vthn = @n.xm1.nsg13_lv_nmos[vth]
let vgsn = @n.xm1.nsg13_lv_nmos[vgs]
let vdsatn = @n.xm1.nsg13_lv_nmos[vdss]
let cgg = @n.xm1.nsg13_lv_nmos[cgg]
let cgsol = @n.xm1.nsg13_lv_nmos[cgsol]
let cgdol = @n.xm1.nsg13_lv_nmos[cgdol]
let vov = 2*idn/gmn
let gmoverId = gmn/idn
let cgg_tot = cgg + cgsol + cgdol
let ft = 1e-9*gmn/6.28/cgg_tot

plot i(Vmeas)
*plot ylog i(Vmeas)
*plot gmn
*plot xlog gmoverId

wrdata data_nmos_idvgs_VDSp9_test.txt idn

wrdata data_nmos_idvgs_VDSp9_gmid-ft.txt gmoverId ft

**Pregunta B
reset
dc vds 0 1.35 0.01  vgs 0.4 0.8 0.4
plot i(Vmeas)
reset 
dc vds 0 1.35 0.01 vgs 1.5 1.5 0.01
plot i(Vmeas)

**Pregunta C
reset 

save all
save @n.xm1.nsg13_lv_nmos[gm]
dc vgs 0 1.5 0.01

let gmn2 = @n.xm1.nsg13_lv_nmos[gm]
let ft = gmn2/(2*pi*@n.xm1.nsg13_lv_nmos[cgg])
plot gmn2/i(Vmeas)
plot ft

.endc
"}
C {vsource.sym} 970 -280 0 0 {name=vgs value=0.75 savecurrent=false}
C {devices/gnd.sym} 970 -250 0 0 {name=l1 lab=GND}
C {vsource.sym} 1330 -450 0 0 {name=vds value=0.75 savecurrent=false}
C {devices/gnd.sym} 1330 -420 0 0 {name=l2 lab=GND}
