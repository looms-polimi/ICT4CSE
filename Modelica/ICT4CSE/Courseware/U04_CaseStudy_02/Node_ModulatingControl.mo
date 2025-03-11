within ICT4CSE.Courseware.U04_CaseStudy_02;

model Node_ModulatingControl
  parameter Real Ki = 1;
  parameter Real Tii = 2;
  parameter Real Ke = 1;
  parameter Real Tie = 10;
  parameter Real umax = 1;
  parameter Real umin = -1;
  parameter Real Ts = 0.1;
  Modelica.Blocks.Interfaces.RealOutput u annotation(
    Placement(visible = true, transformation(origin = {140, 52}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput ye annotation(
    Placement(visible = true, transformation(origin = {-130, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 0), iconTransformation(origin = {-40, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput yi annotation(
    Placement(visible = true, transformation(origin = {-120, 50}, extent = {{-10, 10}, {10, -10}}, rotation = 0), iconTransformation(origin = {40, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput we annotation(
    Placement(visible = true, transformation(origin = {-130, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.BooleanInput TRK annotation(
    Placement(visible = true, transformation(origin = {-130, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput uTRK annotation(
    Placement(visible = true, transformation(origin = {-120, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
protected
  discrete Real upe, wi, upi, uie, uii;
  discrete Real uieo(start = 0, fixed = true);
  discrete Real uiio(start = 0, fixed = true);
  discrete Real wio(start = 0, fixed = true);
algorithm
  when sample(0, Ts) then
    upe := Ke*(pre(we) - pre(ye));
    if TRK then
      u := uTRK;
/* set u to track reference */
      wi := yi;
/* set external regulator output to generate zero internal error */
      upi := 0;
/* as a consequence the internal P control is zero */
    else
      uie := uieo + Ke*Ts/Tie*(we - ye);
      wi := upe + uie;
/* no limits here, locks are used */
      upi := Ki*(wi - yi);
      uii := uiio + Ki*Ts/Tii*(wi - yi);
      u := max(umin, min(umax, upi + uii));
      if (wi > wio and u >= umax) or (wi < wio and u >= umax) then
/* locks on external controller output */
        wi := wio;
/* re-evaluate internal controller if active */
        upi := Ki*(wi - yi);
        uii := uiio + Ki*Ts/Tii*(wi - yi);
        u := max(umin, min(umax, upi + uii));
      end if;
    end if;
    uiio := u - upi;
/* state management and AW only once, here at the end */
    uieo := wi - upe;
    wio := wi;
  end when;
initial algorithm
  upe :=  0;
  annotation(
    Icon(graphics = {Rectangle(fillColor = {170, 255, 127}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(extent = {{-100, 100}, {100, -100}}, textString = "MC")}),
    Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
    __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end Node_ModulatingControl;