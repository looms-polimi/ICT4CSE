within ICT4CSE.Courseware.U02_Modulating_blocks_realisation;

model E01_In_linear_region_all_equal
  "Compare some 1-dof PID digital realisations and their analogue counterparts:
   narrow the CS range so that saturation is hit and compare contolled variables
   and control signals (cmp_y{a,d} and cmp_u{a,d} respectively)"
  extends Icons.CourseworkModel;
  parameter Real K = 5;
  parameter Real Ti = 5;
  parameter Real Td = 1;
  parameter Real N = 10;
  parameter Real CSmax = 1;
  parameter Real CSmin = 0;
  parameter Real Ts = 0.05;
  parameter Real Pn[:] = {1};
  parameter Real Pd[:] = {10, 11, 1};
  
  Modelica.Blocks.Sources.RealExpression SP(y = if time < 1 then 0 elseif time < 060 then 0.8
   elseif time < 120 then 1.2
   elseif time < 180 then 0.2
   elseif time < 240 then 0.8 else 0.5);
   
/*********************************************************************/
  model Analogue_and_digital_loops_1dof
    parameter Real K = 1;
    parameter Real Ti = 10;
    parameter Real Td = 1;
    parameter Real N = 4;
    parameter Real CSmax = 1;
    parameter Real CSmin = -1;
    parameter Real Ts = 0.05;
    parameter Real Pn[:] = {1};
    parameter Real Pd[:] = {10, 11, 1};
    output Real cmp_ya, cmp_yd, cmp_ua, cmp_ud; /* for comparisons */
    Modelica.Blocks.Interfaces.RealInput SP;
    replaceable model AC = ControlBlocks.Modulating.Analogue.PID_ifb_derr
         constrainedby ControlBlocks.Modulating.Analogue.PID_ifb_derr;
    replaceable model DC = ControlBlocks.Modulating.Digital.PID_ifb_derr
         constrainedby ControlBlocks.Modulating.Analogue.PID_ifb_derr;       
  protected
    AC PID_analogue(K = K, Ti = Ti, Td = Td, N = N, CSmin = CSmin, CSmax = CSmax);
    DC PID_digital(K = K, Ti = Ti, Td = Td, N = N, CSmin = CSmin, CSmax = CSmax, Ts = Ts);
    Modelica.Blocks.Continuous.TransferFunction P_analogue(b = Pn, a = Pd);
    Modelica.Blocks.Continuous.TransferFunction P_digital(b = Pn, a = Pd);
  equation
    cmp_ya = P_analogue.y;
    cmp_yd = P_digital.y;
    cmp_ua = PID_analogue.CS;
    cmp_ud = PID_digital.CS;
    connect(SP, PID_analogue.SP);
    connect(SP, PID_digital.SP);
    connect(P_analogue.y, PID_analogue.PV);
    connect(P_digital.y, PID_digital.PV);
    connect(PID_analogue.CS, P_analogue.u);
    connect(PID_digital.CS, P_digital.u);
  end Analogue_and_digital_loops_1dof;
/*********************************************************************/   
   
  Analogue_and_digital_loops_1dof PID_ifb_derr
      (K = K, Ti = Ti, Td = Td, N = N, CSmin = CSmin, CSmax = CSmax, Ts = Ts, Pn = Pn, Pd = Pd);
      
  Analogue_and_digital_loops_1dof PIplusD_ifb_derr
      (redeclare model AC=ControlBlocks.Modulating.Analogue.PIplusD_ifb_derr,
       redeclare model DC=ControlBlocks.Modulating.Digital.PIplusD_ifb_derr,
       K = K, Ti = Ti, Td = Td, N = N, CSmin = CSmin, CSmax = CSmax, Ts = Ts, Pn = Pn, Pd = Pd);
       
  Analogue_and_digital_loops_1dof PIplusD_ifb_dout
      (redeclare model AC=ControlBlocks.Modulating.Analogue.PIplusD_ifb_dout,
       redeclare model DC=ControlBlocks.Modulating.Digital.PIplusD_ifb_dout,
       K = K, Ti = Ti, Td = Td, N = N, CSmin = CSmin, CSmax = CSmax, Ts = Ts, Pn = Pn, Pd = Pd);

  Analogue_and_digital_loops_1dof PIplusD_parallel_derr
      (redeclare model AC=ControlBlocks.Modulating.Analogue.PID_parallel_derr,
       redeclare model DC=ControlBlocks.Modulating.Digital.PID_parallel_derr,
       K = K, Ti = Ti, Td = Td, N = N, CSmin = CSmin, CSmax = CSmax, Ts = Ts, Pn = Pn, Pd = Pd);

  Analogue_and_digital_loops_1dof PIplusD_parallel_dout
      (redeclare model AC=ControlBlocks.Modulating.Analogue.PID_parallel_dout,
       redeclare model DC=ControlBlocks.Modulating.Digital.PID_parallel_dout,
       K = K, Ti = Ti, Td = Td, N = N, CSmin = CSmin, CSmax = CSmax, Ts = Ts, Pn = Pn, Pd = Pd);

equation
  connect(SP.y, PID_ifb_derr.SP);
  connect(SP.y, PIplusD_ifb_derr.SP);
  connect(SP.y, PIplusD_ifb_dout.SP);
  connect(SP.y, PIplusD_parallel_derr.SP);
  connect(SP.y, PIplusD_parallel_dout.SP);
  annotation(
    experiment(StartTime = 0, StopTime = 500, Tolerance = 1e-06, Interval = 0.1),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "rungekutta", variableFilter = ".*"));
end E01_In_linear_region_all_equal;