x=[-3,-2,-1,-.5,0,0.5,1,2,3];
f=[-1,-1,-1,-0.5,0,0.5,1,0.75,0.75];
figure(1)
plot(x,f,'ro'), axis square, axis([-3,3,-1.5, 1.5])
title('function values'), hold on, shg
plot(x,f,'-ro')
title('... and the linear spline approximation'), shg
t=[-3:0.01:3];
p=pchip(x,f,t);
s=spline(x,f,t);
figure(2)
plot(x,f,'ro',t,p,'-b',t,s,'-k'), axis square
legend('data', 'Hermite spline', 'standard spline', 'location', 'northwest'), shg