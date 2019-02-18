n = 1024*16;
options.n = n;
[x,fs] = load_sound('bird', n);


% Ex 1
%%

t0 = n/4;
% width of the bump
sigma = 128;
% window
t = (1:n)';
h = exp( -(t-t0).^2 ./ (2*sigma^2) );
% fft
xh = x.*h;
tau = 1e-3;
xh = xh(abs(xh)>tau);
xf = fft(xh);

% display signal
clf; 
subplot(2,1,1);
plot(t, x); axis('tight');
set_graphic_sizes([], 20);
title('Signal x');
subplot(2,1,2);
plot(t, h); axis('tight');
set_graphic_sizes([], 20);
title('Window h');

% display FFTs
p = length(xf);
clf; 
subplot(2,1,1);
plot(xh);
set_graphic_sizes([], 20); axis('tight');
title('Windowed signal (zoom)');
subplot(2,1,2);
plot( -p/2+1:p/2, fftshift(abs(xf)) );
set_graphic_sizes([], 20); axis('tight');
title('Windowed FFT (zoom)');

% Ex 2
%%

% a noisy signal
sigma = .2;
xn = x + randn(size(x))*sigma;

% The only parameters of the transform are the size of the window and the
% overlap.
w = 64*2;  
q = w/2;

Sn = perform_stft(xn,w,q, options);
Tlist = linspace(.8,2.5,20)*sigma;
err_hard = []; err_soft = [];

for i=1:length(Tlist);
    % soft thresholding
    SnT = perform_thresholding(Sn,Tlist(i)/2, 'soft');
    x1 = perform_stft(SnT, w,q, options);
    err_soft(i) = snr(x,x1);
    % hard thresholding
    SnT = perform_thresholding(Sn,Tlist(i), 'hard');
    x1 = perform_stft(SnT, w,q, options);
    err_hard(i) = snr(x,x1);
end

% ret best hard thresholding result
[snr_hard,i] = max(err_hard);
SnT = perform_thresholding(Sn,Tlist(i), 'hard');
x1 = perform_stft(SnT, w,q, options);
% error curves
clf;
plot(Tlist/sigma, [err_hard(:) err_soft(:)]);
axis('tight');
legend('Hard', 'Soft');
set_graphic_sizes([], 20,2);
set_label('T/sigma', 'SNR');

% Ex 3
%%

clf;
subplot(2,1,1);
plot(xn); axis([1 n -1.2 1.2]);
set_graphic_sizes([], 20);
title(strcat(['Noisy signal, SNR=', num2str(snr(x,xn),4), 'dB']));
subplot(2,1,2);
plot(x1); axis([1 n -1.2 1.2]);
set_graphic_sizes([], 20);
title(strcat(['Denoised signal, SNR=', num2str(snr_hard,4), 'dB']));

% Ex 4
%%

Sn = perform_stft(xn,w,q, options);
Tlist = linspace(1,3,6)/2*sigma;
snr_block = [];
bslist = 1:4;
[bsY,bsX] = meshgrid(bslist,bslist);
for k=1:length(bsX(:))
    options.block_size = [bsX(k) bsY(k)];
    err = [];
    for i=1:length(Tlist);
        % hard thresholding
        SnT = perform_thresholding(Sn,Tlist(i), 'block',options);
        x1 = perform_stft(SnT, w,q, options);
        err(i) = snr(x,x1);
    end
    [snr_block(k),t] = max(err);
    if t==1 | t==length(Tlist)
        warning('Out of bound reached');
    end
    Topt(k) = Tlist(t);
end
snr_block = reshape(snr_block, size(bsX));
clf;
imageplot(snr_block, 'SNR for several block sizes');
set_label('X block size','Y block size');

