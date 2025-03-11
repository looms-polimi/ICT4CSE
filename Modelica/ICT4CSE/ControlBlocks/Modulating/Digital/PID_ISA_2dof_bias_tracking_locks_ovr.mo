within ICT4CSE.ControlBlocks.Modulating.Digital;

model PID_ISA_2dof_bias_tracking_locks_ovr
  "Digital 2-dof ISA PID with Bias, realised by actions"
  extends BaseClasses.SISO_D_SP_PV_CS_200x400;
  
  parameter Real K=1;
  parameter Real Ti=10;
  parameter Real Td=1;
  parameter Real N=4;
  parameter Real b=1;
  parameter Real c=0;
  parameter Real CSmax=1;
  parameter Real CSmin=-1;
  parameter Real CSstart=0;
  parameter Boolean hasBias = false annotation(Dialog(tab="Optional I/O"));
  parameter Boolean hasTracking = false annotation(Dialog(tab="Optional I/O"));
  parameter Boolean hasLocks = false annotation(Dialog(tab="Optional I/O"));
  parameter Boolean hasOvrMax = false annotation(Dialog(tab="Optional I/O"));
  parameter Boolean hasOvrMin = false annotation(Dialog(tab="Optional I/O"));

  Modelica.Blocks.Interfaces.RealInput Bias if hasBias annotation(
    Placement(visible = true, transformation(origin = {-180, 40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, 220}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput TR if hasTracking annotation(
    Placement(visible = true, transformation(origin = {-80, 80}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 8}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput TS if hasTracking annotation(
    Placement(visible = true, transformation(origin = {-36, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 46}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput noInc if hasLocks annotation(
    Placement(visible = true, transformation(origin = {-160, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -32}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput noDec if hasLocks annotation(
    Placement(visible = true, transformation(origin = {-124, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput ovrMax if hasOvrMax annotation(
    Placement(visible = true, transformation(origin = {-70, 90}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -110}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput ovrMin if hasOvrMin annotation(
    Placement(visible = true, transformation(origin = {-60, 100}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -150}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput HIsat annotation(
    Placement(visible = true, transformation(origin = {146, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -40}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanOutput LOsat annotation(
    Placement(visible = true, transformation(origin = {156, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -80}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

protected
  Modelica.Blocks.Interfaces.RealInput iBias;
  Modelica.Blocks.Interfaces.BooleanInput iTS;
  Modelica.Blocks.Interfaces.RealInput iTR;
  Modelica.Blocks.Interfaces.BooleanInput iNoInc;
  Modelica.Blocks.Interfaces.BooleanInput iNoDec;
  Modelica.Blocks.Interfaces.RealInput iOvrMax;
  Modelica.Blocks.Interfaces.RealInput iOvrMin;
  
  discrete Real up,ui,ud,w1,y1,u1,ui1,ud1;

equation
  connect(iBias, Bias);
  connect(iTS, TS);
  connect(iTR, TR);
  connect(iNoInc, noInc);
  connect(iNoDec, noDec);
  connect(iOvrMax, ovrMax);
  connect(iOvrMin, ovrMin);
  if not hasBias then
    iBias = 0;
  end if;
  if not hasTracking then
    iTS = false;
    iTR = 0;
  end if;
  if not hasLocks then
    iNoInc = false;
    iNoDec = false;
  end if;
  if not hasOvrMax then
    iOvrMax = -Modelica.Constants.inf;
  end if;
  if not hasOvrMin then
    iOvrMin = Modelica.Constants.inf;
  end if;

algorithm
  when sample(0,Ts) then
       up  := K*(b*w-y);
       if iTS then
          u := iTR;
       elseif time<=0 then
          u   := CSstart;
          u1  := CSstart;
          w1  := 0;
          y1  := 0;
          ui1 := CSstart-up;
          ud1 := 0;
       else
          ui  := ui1+K*Ts/Ti*(w-y);
          ud  := (Td*ud1+K*N*Td*(c*(w-w1)-(y-y1)))/(Td+N*Ts);
          u   := max(CSmin,min(CSmax,up+ui+ud+iBias));
          if hasOvrMax and iOvrMax>u then
             u := iOvrMax;
          end if;
          if hasOvrMin and iOvrMin<u then
             u := iOvrMin;
          end if;
          if (u>u1 and iNoInc) or (u<u1 and iNoDec) then
             u := u1;
          end if;
       end if;
       HIsat  := (u>=CSmax);
       LOsat  := (u<=CSmin);
       w1     := w;
       y1     := y;
       u1     := u;
       ui1    := u1-up-ud-iBias;
       ud1    := ud;
  end when; 

annotation(
    Icon(graphics = {Text( extent = {{-120, 100}, {120, -100}}, textString = "PID
ISA
2dof
bias
tracking
locks
override
(opt)")}));
end PID_ISA_2dof_bias_tracking_locks_ovr;