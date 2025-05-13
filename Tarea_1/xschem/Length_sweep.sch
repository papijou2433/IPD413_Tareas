v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 3670 -540 3710 -540 {
lab=vg}
N 3670 -590 3670 -540 {
lab=vg}
N 3750 -660 3750 -570 {
lab=vd}
N 3750 -540 3750 -470 {
lab=GND}
C {devices/gnd.sym} 3750 -470 0 0 {name=l3 lab=GND}
C {devices/iopin.sym} 3670 -590 0 0 {name=p5 lab=vg}
C {sg13g2_pr/sg13_lv_nmos.sym} 3730 -540 2 1 {name=M1
l=\{length\}
w=\{width\}
ng=1
m=1
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
C {code.sym} 3860 -800 0 0 {name=Simulation only_toplevel=false value="
.option wnflag=1
*vsup VDD 0 1.8
vin vg 0 dc=0.45 ac=1
vds vd 0 1.8
.param length = 0.13u
.param width = 0.3u
cload vd 0 5p
*.dc vin 0.0 1.8 0.01

.control
let strt_l = 0.13u
let stop_l = 1.13u
let step_l = 0.01u
let curr_l = strt_l

shell rm -f ao_sweep_l.raw

while curr_l le stop_l
    alterparam length = $&curr_l
    reset
    save all
    save @n.xm1.nsg13_lv_nmos[gm]
    save @n.xm1.nsg13_lv_nmos[gds]
    dc vds 0.02 1.8 0.01

    let gm = @n.xm1.nsg13_lv_nmos[gm]
    let gds = @n.xm1.nsg13_lv_nmos[gds]

    let ao = gm / gds
    *print ao

    set appendwrite
    wrdata ao_sweep_l.raw ao

    let curr_l = curr_l + step_l
end
.endc

"

}
C {devices/iopin.sym} 3750 -620 0 0 {name=p1 lab=vd}
