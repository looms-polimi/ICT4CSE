within ICT4CSE.ControlBlocks.Modulating.Digital;

model PID_ifb_derr
  "Digital 1-dof PID with AW by internal feedback"
  extends BaseClasses.SISO_D_SP_PV_CS_200x200;
  
  parameter Real K=1;
  parameter Real Ti=10;
  parameter Real Td=1;
  parameter Real N=4;
  parameter Real CSmax=1;
  parameter Real CSmin=-1;

/* MAXIMA
  kill(all);
  C    :  K*(1+1/s/Ti+s*Td/(1+s*Td/N));
  disc :  s=(z-1)/z/Ts;
  Gfb  :  rhs(solve(1/(1-G)=C,G)[1]);
  Gfbd :  rat(subst(disc,Gfb),z);
  a1   : -factor(coeff(denom(Gfbd),z,1)/coeff(denom(Gfbd),z,2));
  a2   : -factor(coeff(denom(Gfbd),z,0)/coeff(denom(Gfbd),z,2));
  b0   :  factor(coeff(num(Gfbd),z,2)/coeff(denom(Gfbd),z,2));
  b1   :  factor(coeff(num(Gfbd),z,1)/coeff(denom(Gfbd),z,2));
  b2   :  factor(coeff(num(Gfbd),z,0)/coeff(denom(Gfbd),z,2));
          ratsimp(Gfbd-(b0+b1/z+b2/z^2)/(1-a1/z-a2/z^2));
*/

  discrete Real e,u1,u2,xfb,xfb1,xfb2;

protected
  parameter Real a1 =  (N*Ti*Ts+Td*Ts+2*N*Td*Ti+2*Td*Ti)/(N*Ts^2+N*Ti*Ts+Td*Ts+N*Td*Ti+Td*Ti);
  parameter Real a2 = -((N+1)*Td*Ti)/(N*Ts^2+N*Ti*Ts+Td*Ts+N*Td*Ti+Td*Ti);
  parameter Real b0 =  (K*N*Ts^2+K*N*Ti*Ts-N*Ti*Ts+K*Td*Ts+K*N*Td*Ti+K*Td*Ti-Td*Ti)
                      /(K*(N*Ts^2+N*Ti*Ts+Td*Ts+N*Td*Ti+Td*Ti));
  parameter Real b1 = -(K*N*Ti*Ts-N*Ti*Ts+K*Td*Ts+2*K*N*Td*Ti+2*K*Td*Ti-2*Td*Ti)
                      /(K*(N*Ts^2+N*Ti*Ts+Td*Ts+N*Td*Ti+Td*Ti));
  parameter Real b2 =  ((K*N+K-1)*Td*Ti)/(K*(N*Ts^2+N*Ti*Ts+Td*Ts+N*Td*Ti+Td*Ti));

algorithm
  when sample(0,Ts) then
       e    := w-y;
       u    := max(CSmin,min(CSmax,e+xfb));
       xfb  := a1*xfb1+a2*xfb2+b0*u+b1*u1+b2*u2;
       xfb2 := xfb1;
       xfb1 := xfb;   
       u2   := u1;
       u1   := u;
  end when;  

initial algorithm
  xfb  := 0;
  xfb1 := 0;
  xfb2 := 0;
  u1   := 0;
  u2   := 0;
annotation(
    Icon(graphics = {Text(origin = {0, -3}, extent = {{-100, 85}, {100, -85}}, textString = "PID
1dof
ifb")}));
end PID_ifb_derr;