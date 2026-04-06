function [A,P]=amoup(R001,L,f,pol);

%AMOUP - Mouphouma-fele felempirikus esointenzitas modellen alapulo 
% esocsillapitas komplemens eloszlas modellt kiszamito fuggveny
%
% Szintaktika:
%   P=amoup(R001,L,f,pol);
%
% Parameterek:
%   R001 - P(R001)=0.01, eves 0.01% valoszinuseghez tartozo esointenzitas
%   L    - szakaszhossz [km]
%   f    - frekvencia [GHz]
%   pol  - polarizacio ('v', 'h')
%
% Kimeno parameter:
%   P - valoszinuseg vektor
%
%   A    - csillapitas tengely vektor
A=0:1:50;

[k,alfa]=kalfa(f,pol);
pera=1/alfa;

d0=35*exp(-0.015*R001);
r=1/(1+L/d0);
l=L*r;

A001=k*(R001^alfa)*l;
disp(A001);
a=1-( (1-(A/A001).^pera)./( 1+4.56*(A/A001).^(1.03*pera) ) );
b=((A/A001).^pera-1).*log(1+(A/A001).^pera);
P=(((A001^pera+(k*l)^pera)./(A.^pera+(k*l)^pera)).^b).*10.^(-4*a);
%semilogy(A,P)
