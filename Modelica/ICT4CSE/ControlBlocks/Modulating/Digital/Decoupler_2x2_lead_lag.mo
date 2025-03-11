within ICT4CSE.ControlBlocks.Modulating.Digital;

model Decoupler_2x2_lead_lag
  extends ICT4CSE.Icons.DigitalController_200x200;
  parameter Real u1_to_bias2_mu;
  parameter Real u1_to_bias2_Tz;
  parameter Real u1_to_bias2_Tp;
  parameter Real u2_to_bias1_mu;
  parameter Real u2_to_bias1_Tz;
  parameter Real u2_to_bias1_Tp;
  parameter Real Ts;
  Modelica.Blocks.Interfaces.RealInput v1 annotation(
    Placement(visible = true, transformation(origin = {-140, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput u1 annotation(
    Placement(visible = true, transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput v2 annotation(
    Placement(visible = true, transformation(origin = {-140, -50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-120, -58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput u2 annotation(
    Placement(visible = true, transformation(origin = {30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput bias1 annotation(
    Placement(visible = true, transformation(origin = {-130, 20}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-120, 20}, extent = {{20, -20}, {-20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput bias2 annotation(
    Placement(visible = true, transformation(origin = {-130, -20}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-120, -20}, extent = {{20, -20}, {-20, 20}}, rotation = 0)));
  discrete Real u11, u21, bias11, bias21;
algorithm
  when sample(0, Ts) then
    u1 := pre(v1);
    u2 := pre(v2);
    bias1 := -(u2_to_bias1_Tp * bias11 + u2_to_bias1_mu * ((Ts + u2_to_bias1_Tz) * u2 - u2_to_bias1_Tz * u21))
             /(u2_to_bias1_Tp + Ts);
    bias2 := -(u1_to_bias2_Tp * bias21 + u1_to_bias2_mu * ((Ts + u1_to_bias2_Tz) * u1 - u1_to_bias2_Tz * u11))
             /(u1_to_bias2_Tp + Ts);
    bias11 := bias1;
    bias21 := bias2;
    u11 := u1;
    u21 := u2;
  end when;
  annotation(
    Icon(graphics = {Text(origin = {-1, -5}, extent = {{-71, 79}, {71, -79}}, textString = "decoupler
2x2
lead/lag"), Text(origin = {-10, -119}, extent = {{-130, 19}, {130, -19}}, textString = "%name")}),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end Decoupler_2x2_lead_lag;