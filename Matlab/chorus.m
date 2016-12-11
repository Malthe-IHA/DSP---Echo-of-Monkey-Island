clear all
clc
%% LeChuck Theme
 %      _____
 %     /     \
 %    | () () |
 %     \  ^  /
 %      |||||
 %      |||||
 
 
 [x,Fs] = audioread('LeChuck_Theme.mp3'); 
 Ts = 1/Fs;
 x_seg = x(Fs*10 : Fs*20);
 
 soundsc(x_seg,Fs);
 pause(10);
%% parameters to vary the effect %
% 3ms max delay in seconds
max_time_delay=0.003;
%rate of flange in Hz
rate=2;                         
%create index array
index=1:length(x_seg);

% Sin reference to create oscillating delay
sin_ref = (sin(2*pi*index*(rate/Fs)))';

%convert delay in ms to max delay in samples
max_samp_delay=round(max_time_delay*Fs);

% create empty out vector
y = zeros(length(x_seg),1);
   
% to avoid referencing of negative samples
%y(1:max_samp_delay)=x_seg(1:max_samp_delay);

% set gain coefficient
amp=0.7;

% for each sample
for i = (max_samp_delay+1):length(x_seg),
cur_sin=abs(sin_ref(i)); %abs of current sin val 0-1

% generate delay from 1-max_samp_delay and ensure whole number
cur_delay=ceil(cur_sin*max_samp_delay);

% add delayed sample
y(i) = (amp*x_seg(i)) + amp*(x_seg(i-cur_delay));
end

%% Time domain plot of music without delay
 T = 0:Ts:10

 figure(3)
 plot(T,x_seg)
 title('Amplitude Spectrum')
 axis tight
 xlabel('Time/s')
 ylabel('Amplitude')


 %% Chorus of LeChuck 
 comp = x_seg + y';
 
 soundsc(comp,Fs);
 
 %% Fourier of music without chorus
 
x_FFt = fft(x_seg);
L = length(x_seg);

x_FFt_real = abs(x_FFt);

x_FFt_real_chan_1 = x_FFt_real(1,:);

x_FFt_real_chan_1_norm = normr(x_FFt_real_chan_1);

f = Fs*(0:(L-1))/L;

figure(4)
semilogx(f,x_FFt_real_chan_1_norm)
title('Amplitude Spectrum')
axis([10 20000 0 .1])
xlabel('f (Hz)')
ylabel('Normalized amplitude')
 
%% Time domain plot of music wit delay 
figure(5)
plot(T,y)
title('Amplitude Spectrum')
xlabel('Time/s')
ylabel('Amplitude')

%% Fourier of music with delay

y_FFt = fft(y);
L = length(y);

y_FFt_real = abs(y_FFt)';

y_FFt_real_chan_1 = y_FFt_real(1,:);

y_FFt_real_chan_1_norm = normr(y_FFt_real_chan_1);

figure (6)
semilogx(f,y_FFt_real_chan_1_norm)
title('Amplitude Spectrum')
axis([10 20000 0 0.1])
xlabel('f (Hz)')
ylabel('Normalized amplitude')
 