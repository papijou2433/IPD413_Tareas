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
N 3750 -540 3750 -470 {
lab=GND}
N 3750 -590 3750 -570 {
lab=#net1}
N 3750 -670 3750 -650 {
lab=vd}
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
vin vg 0 0.35
vds vd 0 1.8
.param length = 0.5u
.param width = 4.38u
.param Ids = \{120u*3.1415\}
cload vd 0 5p

.control
let strt_w = 0.3u
let stop_w = 3u
let step_w = 0.05u
let curr_w = strt_w

shell rm -f gmid_sweep_w.raw
shell rm -f vov_sweep_w.raw

while curr_w le stop_w
    alterparam length = $&curr_w
    reset
    save all
    save @n.xm1.nsg13_lv_nmos[gm]
    save @n.xm1.nsg13_lv_nmos[ids]
    dc vin 0.35 0.35 0.01
    let idn = @n.xm1.nsg13_lv_nmos[ids]
    let gm  = @n.xm1.nsg13_lv_nmos[gm]
    let gmid= gm/idn
    let idw = idn/curr_w
    set appendwrite
    wrdata gmid_sweep_w.raw gmid idw
    
    
    let curr_w = curr_w + step_w
end
.endc

"

}
C {devices/iopin.sym} 3750 -670 0 0 {name=p1 lab=vd}
C {isource.sym} 3750 -620 0 0 {name=I0 value=\{Ids\}}
