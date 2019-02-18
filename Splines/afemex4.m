x=2*[3,1.75,0.9,0,0.5,1.5,3.25,4.25,4.25,3,3.75,6]; % x-values
y=2*[4,1.6,0.5,0,1.0,0.5,0.5,2.25,4,4,3.25,4.25]; % y-values
n=length(x);
data=[x',y'],
axis square, hold on
t=0:1:n-1; % parametric coordinate
tt=[0:0.01:n-1]; % interpolant evaluation points
xx=spline(t,x,tt); yy=spline(t,y,tt);
plot(xx,yy'), plot(x,y,'o'),
grid on, shg