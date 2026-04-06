function [k,alfa]=kalfa(f0,pol);

%KALFA - ITU-modell parameter szamito program
% Az ITU modelljeiben hasznalatos k es alfa parametereket adja
% vissza a fuggveny a vivofrekvencia es a polarizacio fuggvenyeben
% Az ertekek az ITU ajanlasaban adottak tablazatosan, amibol a 
% program interpolalassal kiszamitja az adott ertekeket.
%
% Szintaktika:
%   [k,alfa]=kalfa(f0,pol);
% 
% Parameterek:
%   f0 - frequencia GHz-ben
%   pol - polarizacio ('h' vagy 'v')
%
% Kimeno parameterek:
%   k, alfa - empirikus parameterek
%

f=[1 2 4 6 7 8 10 12 15 20 25 30 35 40 45 50 60 70 80 90 100 120 150 200 300 400];

kh=[0.0000387 0.000154 0.000650 0.00175 0.00301 0.00454 0.0101 0.0188 0.0367 0.0751 0.124 0.187 0.263 0.350 0.442 0.536 0.707 0.851 0.975 1.06 1.12 1.18 1.31 1.45 1.36 1.32];
kv=[0.0000352 0.000138 0.000591 0.00155 0.00265 0.00395 0.0087 0.0168 0.0335 0.0691 0.113 0.167 0.233 0.310 0.393 0.479 0.642 0.784 0.906 0.999 1.06 1.13 1.27 1.42 1.35 1.31];

ah=[0.912 0.963 1.121 1.308 1.332 1.327 1.276 1.217 1.154 1.099 1.061 1.021 0.979 0.939 0.903 0.873 0.826 0.793 0.769 0.753 0.743 0.731 0.710 0.689 0.688 0.683];
av=[0.880 0.923 1.075 1.265 1.312 1.310 1.264 1.200 1.128 1.065 1.030 1.000 0.963 0.929 0.897 0.868 0.824 0.793 0.769 0.754 0.744 0.732 0.711 0.690 0.689 0.684];

if pol=='h'
   k=interp1(f,kh,f0);
   alfa=interp1(f,ah,f0);
elseif pol=='v'
   k=interp1(f,kv,f0);
   alfa=interp1(f,av,f0);
end;
