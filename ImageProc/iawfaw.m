addpath('toolbox_signal')
addpath('toolbox_general')
addpath('solutions/introduction_3_image')

%% Image Loading and Displaying

name = 'lena';
n0 = 512;
f = rescale( load_image(name, n0));

clf;
imageplot( f, 'Image f');

%
clf;
imageplot( crop(f, 64), 'Zoom');

%
clf;
imageplot(-f, '-f', 1,2,1);
imageplot(f(n0:-1:1,:), 'Flipped', 1,2,2);

%
k = 9;
h = ones(k,k);
h = h/sum(h(:));

%
fh = perform_convolution(f,h);

%
clf;
imageplot(fh, 'Blurred image');

% 
F = fft2(f) / n0;

%

