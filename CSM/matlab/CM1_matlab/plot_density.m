close all;
dataout= simout.signals.values;
ampl=abs(dataout);
density=densityf(ampl,'on');
ErrorVec(1)
clear simout;
clear dataout;
clear ampl;