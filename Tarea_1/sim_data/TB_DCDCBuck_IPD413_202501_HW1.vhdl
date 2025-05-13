-- sch_path: /workspaces/shared_xserver/IPD413_202501/xschem/Tareas/Tarea_1/TB_DCDCBuck_IPD413_202501_HW1.sch
entity TB_DCDCBuck_IPD413_202501_HW1 is
end TB_DCDCBuck_IPD413_202501_HW1 ;

architecture arch_TB_DCDCBuck_IPD413_202501_HW1 of TB_DCDCBuck_IPD413_202501_HW1 is

component DCDC_Buck 
port (
  VgM1 : in std_logic ;
  VgM2 : in std_logic ;
  GND : inout std_logic ;
  Vin : inout std_logic ;
  Vo : inout std_logic
);
end component ;


signal Vdd : std_logic ;
signal Vo : std_logic ;
signal net1 : std_logic ;
signal GND : std_logic ;
signal Vg_M1 : std_logic ;
signal Vg_M2 : std_logic ;
begin
Vin : vsource
generic map (
   value => {Vin} ,
   savecurrent => false
)
port map (
   p => Vdd ,
   m => GND
);

Vg2 : vsource
generic map (
   value => PULSE(0 {VH} {TdR} {TR} {TF} {T*D-TdR-TdF} {T} 0) ,
   savecurrent => false
)
port map (
   p => Vg_M2 ,
   m => GND
);

Vg1 : vsource
generic map (
   value => PULSE(0 {VH} 0 {TR} {TF} {T*D} {T} 0) ,
   savecurrent => false
)
port map (
   p => Vg_M1 ,
   m => GND
);

V_Iin : ammeter
generic map (
   savecurrent => true ,
   spice_ignore => 0
)
port map (
   plus => Vdd ,
   minus => net1
);

X1 : DCDC_Buck
port map (
   VgM1 => Vg_M1 ,
   VgM2 => Vg_M2 ,
   GND => GND ,
   Vin => net1 ,
   Vo => Vo
);


.param Vin = 3.3
.param VH = 3.3
.param Del = 0

.ic v(Vo) = 0
*.ic i(x1.L1) = 0
*.ic v(Vc) = 0


*.param fsw = 10Meg
*.param fsw = 8Meg
.param fsw = 1Meg

.param Vo = 1.8
.param Io = 2
.param rI = 0.3
.param rV = 0.1
.param T = 1/fsw

.param D = 1-((Vo+0.05)/(Vin-0.03))
.param TR = 0.01*T
.param TF = 0.01*T
.param TdR = 1n
.param TdF = 1n

*Filtro
.param L = Vin/(4*Io*rI*fsw)
.param R = Vo/Io
.param C = rI/(8*rV*R*fsw)

*.option temp = 125
*.option temp = -40
.option temp = 27



.save v(Vo) i(v.x1.V_Io) i(V_Iin) v(Vdd) v(x1.Vc) i(v.x1.V_IM2) i(v.x1.V_IL) v(Vg_M1) v(Vg_M2)
.param tau = 4*L/R
.csparam tau = {tau}
.param SimTime = tau+30*T
.csparam Sim_end = {SimTime}

.csparam T = {T}
.csparam L = {L}
.csparam C = {C}
.csparam R = {R}

.tran 1n {SimTime} uic

.control

run
set color0 = white
*tran 10n {SimTime} uic
*tran 10n {SimTime}

let Tmeas_i = {Sim_end} -{T}*10
let Tmeas_end = {Sim_end}

let Io = i(v.x1.V_Io)
*let Id_M1 = @m.x1.xm1.msky130_fd_pr__pfet_01v8[id]
let Id_M1 = i(V_Iin)
*let Id_M2 = @m.x1.xm2.msky130_fd_pr__nfet_01v8[id]
let Id_M2 = -i(v.x1.V_IM2)
let gds_M1 = @m.x1.xm1.msky130_fd_pr__pfet_01v8[gds]
let gds_M2 = @m.x1.xm2.msky130_fd_pr__nfet_01v8[gds]

let Po = Io*v(Vo)
let I_in = i(V_Iin)
let Pin = I_in*v(Vdd)
let Vsd_M1 = v(Vdd) - v(x1.Vc)
let Vds_M2 = v(x1.Vc)
let P_M1 = Vsd_M1*Id_M1
let P_M2 = -Vds_M2*Id_M2
let Ron_M1 = Vsd_M1/Id_M1
let Ron_M2 = Vds_M2/Id_M2
*let Ron_M1 = 1/gds_M1
*let Ron_M2 = 1/gds_M2

meas tran Vo_mean AVG v(Vo) FROM={Tmeas_i} TO={Tmeas_end}
meas tran Io_mean AVG Io FROM={Tmeas_i} TO={Tmeas_end}
meas tran Irms_M1 RMS Id_M1 FROM={Tmeas_i} TO={Tmeas_end}
meas tran Irms_M2 RMS Id_M2 FROM={Tmeas_i} TO={Tmeas_end}
meas tran Po_mean AVG Po FROM={Tmeas_i} TO={Tmeas_end}
meas tran Pin_mean AVG Pin FROM={Tmeas_i} TO={Tmeas_end}
meas tran P_M1_mean AVG P_M1 FROM={Tmeas_i} TO={Tmeas_end}
meas tran P_M2_mean AVG P_M2 FROM={Tmeas_i} TO={Tmeas_end}

let eff = 100*Po_mean/Pin_mean
let loss_M1 = 100*P_M1_mean/Pin_mean
let loss_M2 = 100*P_M2_mean/Pin_mean
let cond_loss_M1 = Irms_M1*Irms_M1*40m*100
let cond_loss_M2 = Irms_M2*Irms_M2*35m*100
let sumaPot = eff+loss_M1+loss_M2
print eff loss_M1 loss_M2 cond_loss_M1 cond_loss_M2 sumaPot
print tau T L C R

plot Io i(v.x1.V_IL)
plot Id_M1 Id_M2
plot v(Vo)
plot Po Pin
*plot P_M1 P_M2
plot v(x1.Vc)
plot v(Vg_M1) v(Vg_M2)
plot Ron_M1 Ron_M2
*plot i(V_Iload)
write TB_DCDCBuck.raw
.endc


.end



.lib cornerMOShv.lib mos_tt
.lib cornerMOSlv.lib mos_tt
*.lib cornerMOShv.lib mos_ff
*.lib cornerMOSlv.lib mos_ff
*.lib cornerMOShv.lib mos_ss
*.lib cornerMOSlv.lib mos_ss
*.lib cornerMOShv.lib mos_sf
*.lib cornerMOSlv.lib mos_sf
*.lib cornerMOShv.lib mos_fs
*.lib cornerMOSlv.lib mos_fs

.include /opt/pdks/ihp-sg13g2/libs.ref/sg13g2_stdcell/spice/sg13g2_stdcell.spice
.lib $::SG13G2_MODELS/cornerRES.lib res_typ
.lib $::SG13G2_MODELS/cornerCAP.lib cap_typ
*.lib $::SG13G2_MODELS/diodes.lib


.param temp=27
.param mult_M1 = {3*1024}
.param w_M1 =10u 
.param l_M1 = 0.4u
.param ng_M1 = 1

.param mult_M2 = {1*1024}
.param w_M2 =10u 
.param l_M2 =0.45u
.param ng_M2 =1




end arch_TB_DCDCBuck_IPD413_202501_HW1 ;


-- expanding   symbol:  ../Tarea_1/DCDC_Buck.sym # of pins=5
-- sym_path: /workspaces/shared_xserver/IPD413_202501/xschem/Tareas/Tarea_1/DCDC_Buck.sym
-- sch_path: /workspaces/shared_xserver/IPD413_202501/xschem/Tareas/Tarea_1/DCDC_Buck.sch
entity DCDC_Buck is
port (
  VgM1 : in std_logic ;
  VgM2 : in std_logic ;
  GND : inout std_logic ;
  Vin : inout std_logic ;
  Vo : inout std_logic
);
end DCDC_Buck ;

architecture arch_DCDC_Buck of DCDC_Buck is


signal Vc : std_logic ;
signal net1 : std_logic ;
signal net2 : std_logic ;
signal net3 : std_logic ;
begin
L1 : ind
generic map (
   m => 1 ,
   value => {L} ,
   footprint => 1206 ,
   device => inductor
)
port map (
   p => net2 ,
   m => net1
);

V_Io : ammeter
generic map (
   savecurrent => true ,
   spice_ignore => 0
)
port map (
   plus => net1 ,
   minus => Vo
);

V_IL : ammeter
generic map (
   savecurrent => true ,
   spice_ignore => 0
)
port map (
   plus => Vc ,
   minus => net2
);

R1 : res
generic map (
   value => {R} ,
   footprint => 1206 ,
   device => resistor ,
   m => 1
)
port map (
   P => Vo ,
   M => GND
);

V_IM2 : ammeter
generic map (
   savecurrent => true ,
   spice_ignore => 0
)
port map (
   plus => Vc ,
   minus => net3
);

M3 : sg13_hv_pmos
generic map (
   l => {l_M1} ,
   w => {w_M1} ,
   ng => {ng_M1} ,
   m => {mult_M1} ,
   model => sg13_hv_pmos ,
   spiceprefix => X
)
port map (
   D => Vc ,
   G => VgM1 ,
   S => Vin ,
   B => Vin
);

M1 : sg13_hv_nmos
generic map (
   l => {l_M2} ,
   w => {w_M2} ,
   ng => {ng_M2} ,
   m => {mult_M2} ,
   model => sg13_hv_nmos ,
   spiceprefix => X
)
port map (
   D => net3 ,
   G => VgM2 ,
   S => GND ,
   B => GND
);

end arch_DCDC_Buck ;

