function [A,p]=ITU530(R0,L,f,pol)

% ITU530 - ITU-530 ajanlasban adott esocsillapitas komplemens eloszlas modellt
% szamito fuggveny (Terrestrial)
%
% Szintaktika:
%   A=ITU530(R0,L,f,pol);
%
% Parameterek:
%   R0   - P(R0)=0.01, Az ido 0.01%-hoz tartozo esointenzitas
%   L    - szakaszhossz [km]
%   f    - frekvencia [GHz]
%   pol  - polarizacio ('v', 'h')
%
% Kimeno parameterek:
%   A - csillapitas vektor
%   p - valószínûség
%

[k,a]=kalfa(f,pol);

d0=35*exp(-0.015*R0);
r=1/(1+L/d0);
A0=k*(R0^a)*L*r;

disp([A0 R0]);

%   p    - valoszinuseg in %
p=0:0.001:100;

A=A0*0.12*p.^(-(0.546+0.043*log10(p)));
p=p/100;
%plot(A,1-p/100)

