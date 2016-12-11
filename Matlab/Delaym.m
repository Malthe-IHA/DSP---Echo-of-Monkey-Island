
clear
clc
close all

%% The Secret of Monkey Island - Opening theme
[x,Fs] = audioread('Monkey_island.wav');  
 
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
  
test = zeros(1,200);
zplane([1 test 0.65])

%% Echo of Monkey Island  
%soundsc(y,Fs); 
%audiowrite('EchoOfMonkeyIsland.wav', y, Fs);
figure(7)
freqz(b,1);

%% Impluse response
figure(1)
impz(b,1,[],44100)

 
%% Frequncy response of filter and delay
figure(2)
grpdelay(b,1)

%% Time domain plot of music without delay
T = 0:Ts:10;

figure(3)
plot(T,y,'r')
title('Amplitude Spectrum')
ylabel('Amplitude')
hold on
plot(T,x_seg,'b')
hold off
legend('Delay', 'No delay')
xlabel('Time [s]')

fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 3];

% Save as a pdf.
print('EchoTime.pdf', '-dpdf')

figure(4)
plot(T,y,'r')
title('Amplitude Spectrum')
ylabel('Amplitude')
hold on
plot(T,x_seg,'b')
hold off
legend('Delay', 'No delay')
xlabel('Time [s]')
%xlim([])

fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 3];

% Save as a pdf.
print('EchoTimeZoom.pdf', '-dpdf')

%% Fourier of music without delay
x_FFt = fft(x_seg);
L = length(x_seg);

x_FFt_real = abs(x_FFt / L);

x_FFt_real_chan_1 = x_FFt_real(1,:);

x_FFt_real_chan_1_norm = 20 * log10(x_FFt_real_chan_1);

f = Fs*(0:(L-1))/L;

%% Fourier of music with delay

y_FFt = fft(y);
L = length(y);

y_FFt_real = abs(y_FFt / L);

y_FFt_real_chan_1 = y_FFt_real(1,:);

y_FFt_real_chan_1_norm = 20 * log10(y_FFt_real_chan_1);

figure (6)
semilogx(f,y_FFt_real_chan_1_norm + 80, 'r')
hold on
semilogx(f,x_FFt_real_chan_1_norm + 80, 'b')
hold off
legend('Delay', 'No delay')
title('Amplitude Spectrum')
xlim([10 20000])
ylabel('Amplitude [dB]')
xlabel('f [Hz]')

fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 3];

% Save as a pdf.
print('EchoFreq.pdf', '-dpdf')
