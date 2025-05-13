v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 3260 -480 3260 -460 {
lab=GND}
N 3180 -530 3220 -530 {
lab=vg}
N 3180 -580 3180 -530 {
lab=vg}
N 3260 -650 3260 -560 {
lab=vout}
N 3260 -810 3260 -750 {
lab=VDD}
N 3260 -650 3330 -650 {
lab=vout}
N 3260 -530 3300 -530 {
lab=GND}
N 3300 -530 3300 -480 {
lab=GND}
N 3260 -480 3300 -480 {
lab=GND}
N 3260 -690 3260 -650 {
lab=vout}
N 3260 -500 3260 -480 {
lab=GND}
C {devices/gnd.sym} 3260 -460 0 0 {name=l3 lab=GND}
C {devices/iopin.sym} 3180 -580 0 0 {name=p5 lab=vg}
C {devices/isource.sym} 3260 -720 0 0 {name=I1 value=\{Ids\}}
C {devices/vdd.sym} 3260 -810 0 0 {name=l4 lab=VDD}
C {devices/iopin.sym} 3330 -650 0 0 {name=p6 lab=vout}
C {sg13g2_pr/sg13_lv_nmos.sym} 3240 -530 2 1 {name=M1
l=\{L\}
w=\{W\}
ng=1
m=\{mult\}
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/code_shown.sym} 2860 -580 0 0 {name=MODEL1 only_toplevel=true
format="tcleval( @value )"
value="

.param corner=0

.if (corner==0)
.lib cornerMOSlv.lib mos_tt
.lib cornerRES.lib res_typ
.lib cornerCAP.lib cap_typ
.endif
"}
C {code.sym} 2900 -800 0 0 {name=Simulation only_toplevel=false value="
.option wnflag=1
.param gm    = \{3.1415*1.1m\}
.param gm_id = 13
.param Ids   = \{gm/gm_id\}
.param L     = 0.13u
.param W     = 3.13u
.param mult  = 10

vsup VDD 0 1.8
vin vg 0 dc=0.45 ac=1

cload vout 0 5p

.control
save all
op
save @n.xm1.nsg13_lv_nmos[gm]
save @n.xm1.nsg13_lv_nmos[ids]
save @n.xm1.nsg13_lv_nmos[gds]
save @n.xm1.nsg13_lv_nmos[ib]

*dc vin -0.01 0.01 0.001
dc vin 0.45 0.45 0.001

let gdsn = @n.xm1.nsg13_lv_nmos[gds]
let gmn = @n.xm1.nsg13_lv_nmos[gm]
let vthn = @n.xm1.nsg13_lv_nmos[vth]
let idn = @n.xm1.nsg13_lv_nmos[ids]
let ao = gmn / gdsn

print Ao

ac dec 100 1 1T
plot vdb(vout)
meas ac GBW when vdb(vout)=0
meas ac DCG find vdb(vout) at=1]]
wrdata cs_amp_bode.raw vdb(vout)
.endc"}
