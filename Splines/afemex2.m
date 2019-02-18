x=linspace(0,1,20);
f = @(x) exp(-2*x).*sin(10*3.14*x);
fx = f(x);
figure(1)
plot(x,fx,'ro'), axis square, axis([0,1,-1, 1])
title('function values'), hold on, shg
plot(x,fx,'-ro')
title('... and the linear spline approximation'), shg
t=[0:0.01:1];
p=pchip(x,fx,t);
s=spline(x,fx,t);
figure(2)
plot(x,fx,'ro',t,p,'-b',t,s,'-k'), axis square
legend('data', 'Hermite spline', 'standard spline', 'location', 'northwest'), shg