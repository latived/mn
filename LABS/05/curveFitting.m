% least-squares fit

S = [1.3 1.8 3 4.5 6 8 9];
v = [0.07 0.13 0.22 0.275 0.335 0.35 0.36];
[a,r2] = linregr(1./S, 1./v)

% a =
% 
%    16.4022    0.1902
% 
% 
% r2 =
% 
%     0.9344

% model coefficients

vm = 1/a(2)
ks = vm*a(1)

% vm =
% 
%     5.2570
% 
% 
% ks =
% 
%    86.2260

% least-squares fit on the transformed data

[a,r2] = linregr(1./S.^2, 1./v)

% a =
% 
%    19.3760    2.4492
% 
% 
% r2 =
% 
%     0.9929

% new model coefficients 

vm = 1/a(2)
ks = sqrt(vm * a(1))

% vm =
% 
%     0.4083
% 
% 
% ks =
% 
%     2.8127