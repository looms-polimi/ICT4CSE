within ICT4CSE.ControlBlocks.Modulating.Digital;

model PID_ISA_2dof
  "Digital 2-dof ISA PID, realised by actions"
  extends BaseClasses.SISO_D_SP_PV_CS_200x200;
  
  parameter Real K=1;
  parameter Real Ti=10;
  parameter Real Td=1;
  parameter Real N=4;
  parameter Real b=1;
  parameter Real c=0;
  parameter Real CSmax=1;
  parameter Real CSmin=-1;

  discrete Real up,ui,ud,w1,y1,ui1,ud1;

algorithm
  when sample(0,Ts) then
       up  := K*(b*w-y);
       ui  := ui1+K*Ts/Ti*(w-y);
       ud  := (Td*ud1+K*N*Td*(c*(w-w1)-(y-y1)))/(Td+N*Ts);
       u   := max(CSmin,min(CSmax,up+ui+ud));
       w1  := w;
       y1  := y;
       ui1 := u-up-ud;
       ud1 := ud;

  end when;  

initial algorithm
  w1  := 0;
  y1  := 0;
  ui1 := 0;
  ud1 := 0;
annotation(
    Icon(graphics = {Text(origin = {0, -3}, extent = {{-100, 85}, {100, -85}}, textString = "PID
ISA
2dof")}));
end PID_ISA_2dof;