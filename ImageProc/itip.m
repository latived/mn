addpath('toolbox_signal')
addpath('toolbox_general')
addpath('solutions/introduction_3_image')

%% Image Loading and Displaying

% First we load an image
name = 'lena';
n = 256;
M = load_image(name, []);
M = rescale(crop(M, n));

% Podemos mostrá-la. É possível dar zoom, extrair pixels, etc.
clf;
imageplot(M, 'Original', 1,2,1);
imageplot(crop(M, 50), 'Zoom', 1,2,2);

%% Modificação da Imagem
% Uma imagem é uma array 2D, que pode ser modificado como uma matrix
clf;
imageplot(-M, '-M', 1,2,1);
imageplot(M(n:-1:1,:), 'Flipped', 1,2,2);

% Borramento é realizado ao computar a convolução com um kernel

% Aqui, computamos um filtro passa baixo
k = 9;
h = ones(k,k);
h = h/sum(h(:));
        
% Computamos agora a convolução
Mh = perform_convolution(M, h);

% Mostramos
clf;
imageplot(M, 'Image', 1,2,1);
imageplot(Mh, 'Blurred', 1,2,2);

% Vários operadores diferencias e convolucionais são implementados
G = grad(M);
clf;
imageplot(G(:,:,1), 'd/dx', 1,2,1);
imageplot(G(:,:,2), 'd/dx', 1,2,2);

%% Transformada de Fourier

% A transformada Fourier em 2D pode ser usada para executar 
% aproximação e interpolação (por preenchimento com 0s)

% Computamos e mostramos aqui a transformada Fourier
% (na escala logaritmitca)

% A função |fftshift| é útil para colocar a baixa frequência no centro.
% Após |fftshift|, a frequência zero é localizada na posição (n/2+1, n/2+1)

Mf = fft2(M);
Lf = fftshift(log( abs(Mf) + 1e-1 ));
clf;
imageplot(M, 'Image', 1,2,1);
imageplot(Lf, 'Fourier transform', 1,2,2);

%% Exercício 1

t = linspace(-pi(),pi(),n);
h = (cos(t)+1)/2;
h = h'*h;
Mf = fft2(M.*h);
Lf = fftshift(log( abs(Mf)+1e-1 ));

clf;
imageplot(M.*h, 'Image with CWF', 1,3,1);
imageplot(h, 'Cosine w. function', 1,3,2);
imageplot(Lf, 'FT', 1,3,3);

%% Exercício 2

k = round(.8*n); k = round(k/2)*2; 
Mf = fft2(M);
Mf(n/2-k/2+2:n/2+k/2, n/2-k/2+2:n/2+k/2) = 0;
Mh = real( ifft2(Mf) );

clf;
imageplot( crop(M), 'Image', 1,3,1);
imageplot( crop(Mf), 'Filter', 1,3,2);
imageplot(clamp( crop(Mh)), 'Low pass filtered', 1,3,3);

%% Interpolating

% ...