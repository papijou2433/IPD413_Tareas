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
C {code.sym} 590 -440 2 1 {name=Simulacion only_toplevel=false value=
"
.param vd = 0.75
.param vg = 0.75
.control
save all
save @n.xm1.nsg13_lv_nmos[ids]
save @n.xm1.nsg13_lv_nmos[gm]
save @n.xm1.nsg13_lv_nmos[vth]
save @n.xm1.nsg13_lv_nmos[cgg]
save @n.xm1.nsg13_lv_nmos[cgsol]
save @n.xm1.nsg13_lv_nmos[cgdol]
save @n.xm1.nsg13_lv_nmos[vgs]
save @n.xm1.nsg13_lv_nmos[vdss]

dc vgs 0.01 1.8 0.01 vds 0.4 1.35 0.05

let idn = @n.xm1.nsg13_lv_nmos[ids]
let gmn = @n.xm1.nsg13_lv_nmos[gm]
let vthn = @n.xm1.nsg13_lv_nmos[vth]
let vgsn = @n.xm1.nsg13_lv_nmos[vgs]
let vdsatn = @n.xm1.nsg13_lv_nmos[vdss]

let cgg = @n.xm1.nsg13_lv_nmos[cgg]
let cgsol = @n.xm1.nsg13_lv_nmos[cgsol]
let cgdol = @n.xm1.nsg13_lv_nmos[cgdol]
let c_tot = cgg + cgsol + cgdol
let ft = gmn/(2*pi*c_tot)

let vov = 2*idn/gmn
let vov2 = vgsn - vthn
*Vov teorico difiere demasiado con vov real 
*Vov=2.38 cuando vgs=1.8, siendo que Vthn = .27 (Vov irrealista, no aplicable)
*print vov2
let gmoverId = gmn/idn

*plot idn title A_lineal
*plot ylog idn title A_log
*plot gmn
*plot xlog gmoverId

wrdata nmos_char_idn.raw idn

wrdata nmos_char_gmid-vov.raw gmoverID vov2

wrdata nmos_char_gmid-ft.raw gmoverId ft
*print vthn

dc vds 0.0 1.35 0.01 vgs 0.4 1.5 0.1
let idn = @n.xm1.nsg13_lv_nmos[ids]
wrdata nmos_char_vds.raw idn
.endc
"}
C {vsource.sym} 970 -280 0 0 {name=vgs value=\{vg\} savecurrent=false}
C {devices/gnd.sym} 970 -250 0 0 {name=l1 lab=GND}
C {vsource.sym} 1330 -450 0 0 {name=vds value=\{vd\} savecurrent=false}
C {devices/gnd.sym} 1330 -420 0 0 {name=l2 lab=GND}
