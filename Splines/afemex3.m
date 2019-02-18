x=[1,2,3,2,1.2,2,2.7]; % x-values
y=[1,0,1,2.5,3.4,4,3.2]; % y-values
n=length(x);
data=[x',y'],
axis square, hold on
t=0:1:n-1; % parametric coordinate
tt=[0:0.01:n-1]; % interpolant evaluation points
xx=spline(t,x,tt); yy=spline(t,y,tt);
plot(xx,yy'), plot(x,y,'o'),
grid on, shg, comet(xx, yy')