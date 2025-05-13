v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 930 -280 930 -220 {
lab=GND}
N 930 -350 1010 -350 {
lab=GND}
N 1010 -350 1010 -280 {
lab=GND}
N 930 -280 1010 -280 {
lab=GND}
N 930 -320 930 -280 {
lab=GND}
N 930 -490 930 -380 {
lab=Vdd}
N 840 -350 890 -350 {
lab=Vg}
C {devices/ipin.sym} 840 -350 0 0 {name=p1 lab=Vg}
C {devices/gnd.sym} 930 -220 0 0 {name=l3 lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 910 -350 2 1 {name=M1
l=\{L\}
w=\{W\}
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
C {code.sym} 590 -450 2 1 {name=Simulacion only_toplevel=false value=
"
.param L = 0.26u
.param W = 1.0u
vdd  Vdd 0 0.75
vgs vg 0 0.75
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

dc vgs 0.1 1.2 0.01

let idn = @n.xm1.nsg13_lv_nmos[ids]
let gmn = @n.xm1.nsg13_lv_nmos[gm]
let vthn = @n.xm1.nsg13_lv_nmos[vth]
let vgsn = @n.xm1.nsg13_lv_nmos[vgs]


let vov = 2*idn/gmn
let vov2 = vgsn - vthn
*Vov teorico difiere demasiado con vov real 
*Vov=2.38 cuando vgs=1.8, siendo que Vthn = .27 
let gmoverId = gmn/idn

print vthn[0]
meas dc Vg_400 when gmoverID=4 CROSS=1
meas dc Vg_920 when gmoverID=9.2 CROSS=1
meas dc Vg_100 when gmoverID=10 CROSS=1
meas dc Vg_130 when gmoverID=13 CROSS=1

print vthn[0]-Vg_10
*(más fiable un measure?)
wrdata nmos_char_gmid-vov.raw gmoverID vov vov2
op
.endc
"}
C {devices/ipin.sym} 930 -490 0 0 {name=p2 lab=Vdd}
