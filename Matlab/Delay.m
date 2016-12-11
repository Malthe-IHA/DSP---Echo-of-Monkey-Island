
clear all;  
clc
clf
 %% The Secret of Monkey Island - Opening theme
 [x,Fs] = audioread('Monkey_island.mp3');  
 
 Ts = 1/Fs;
 x_seg = x(Fs*10 : Fs*20); %segment of the music
 
 delay = 0.5; % 0.5s delayed of audio.  
 alpha = 0.65; % Gain.
 D = delay*Fs;  
 y = zeros(size(x_seg));  
 y(1:D) = x_seg(1:D);  
 
 
   
 %%   FIR Filter Method.  
  b = [1,zeros(1,D),alpha];  % Creating coefficient for delay (22050 scalers of zero).
  y = filter(b,1,x_seg);     % Filtering music sample with one 1 coefficient 22050 zero and one 0.65. 
  

 %% Echo of Monkey Island  
 soundsc(y,Fs); 

figure(7)
freqz(b,1);

%% Impluse response
figure(1)
impz(b,1,[],44100)

 
%% Time domain plot of music without delay
 T = 0:Ts:10

 figure(3)
 plot(T,x_seg)


%% Fourier of music without delay
x_FFt = fft(x_seg);
L = length(x_seg);

x_FFt_real = abs(x_FFt);

x_FFt_real_chan_1 = x_FFt_real(1,:);

x_FFt_real_chan_1_norm = normr(x_FFt_real_chan_1);

f = Fs*(0:(L-1))/L;

figure(4)
semilogx(f,x_FFt_real_chan_1_norm)
title('Amplitude Spectrum')
axis([10 20000 0 .09])
xlabel('f (Hz)')
ylabel('Normalized amplitude')

%% Time domain plot of music wit delay 
figure(5)
plot(T,y)

%% Fourier of music with delay

y_FFt = fft(y);
L = length(y);

y_FFt_real = abs(y_FFt);

y_FFt_real_chan_1 = y_FFt_real(1,:);

y_FFt_real_chan_1_norm = normr(y_FFt_real_chan_1);

figure (6)
semilogx(f,y_FFt_real_chan_1_norm)
title('Amplitude Spectrum')
axis([10 20000 0 .09])
xlabel('f (Hz)')
ylabel('Normalized amplitude')

