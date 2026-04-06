close all;
clear;

agc=importdata('Data\HU11_2004050100_2004060100.csv');
rain=importdata('Data\WEA_BME_Rainfall_2004050100_2004060100.csv');
temp=importdata('Data\WEA_BME_Air Temperature_2004050100_2004060100.csv');

subplot(3,1,1);
x=linspace(1,length(agc)/(24*3600),length(agc));
plot(x,agc);
subplot(3,1,2);

x=linspace(1,length(rain)/(24*60),length(rain));
plot(x,rain);
subplot(3,1,3);
x=linspace(1,length(temp)/(24*60),length(temp));
plot(x,temp);

figure;
x = -100:0.1:-50;
h = hist(agc,x);
plot(x,h);

figure;
att=median(agc)-agc;
[cdf,x]=ecdf(att);
semilogy(x,1-cdf);

[A,p]=ITU530(42,1.5,38,'h');

hold;
semilogy(A,p,'r');

[A,p]=amoup(42,1.5,38,'h');
semilogy(A,p,'g');

legend('Empirical','ITU','MOUP');


