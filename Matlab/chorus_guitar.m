clear all
clc
%% LeChuck Theme
 %      _____
 %     /     \
 %    | () () |
 %     \  ^  /
 %      |||||
 %      |||||
 
 
 [x,Fs] = audioread('181425__serylis__guitar-chord.wav'); 
  
 x = x(1:240894);
 
 soundsc(x,Fs);
%% parameters to vary the effect %
% 3ms max delay in seconds
max_time_delay=0.003;
%rate of flange in Hz
rate=1;                         
%create index array
index=1:length(x);

% Sin reference to create oscillating delay
sin_ref = (sin(2*pi*index*(rate/Fs)))';

%convert delay in ms to max delay in samples
max_samp_delay=round(max_time_delay*Fs);

% create empty out vector
y = zeros(length(x),1);

% set gain coefficient
amp=0.7;

% for each sample
for i = (max_samp_delay+1):length(x),
cur_sin=abs(sin_ref(i)); %abs of current sin val 0-1

% generate delay from 1-max_samp_delay and ensure whole number
cur_delay=ceil(cur_sin*max_samp_delay);

% add delayed sample
y(i) = (amp*x(i)) + amp*(x(i-cur_delay));
end

%% Time domain plot of music without delay

figure(3)
plot(y,'r')
title('Amplitude Spectrum')
ylabel('Amplitude')
hold on
plot(x,'b')
hold off
legend('Chorus', 'No Chorus')
xlabel('Time [s]')

fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 3];

% Save as a pdf.
print('Guitar_time_plot.pdf', '-dpdf')


 %% Chorus of LeChuck 
 
 soundsc(y,Fs);
 
 %% Fourier of music without chorus
 
x_FFt = fft(x);
L = length(x);

x_FFt_real = abs(x_FFt);

x_FFt_real_chan_1 = x_FFt_real(1,:);

x_FFt_real_chan_1_norm = 20 * log10(x_FFt_real_chan_1);

f = Fs*(0:(L-1))/L;

y_FFt = fft(y);
L = length(y);

y_FFt_real = abs(y_FFt)';

y_FFt_real_chan_1 = y_FFt_real(1,:);

y_FFt_real_chan_1_norm = 20 * log10(y_FFt_real_chan_1);



figure (6)
semilogx(f,y_FFt_real_chan_1_norm, 'r')
hold on
semilogx(f,x_FFt_real_chan_1_norm, 'b')
hold off
legend('Chorus', 'No Chorus')
title('Amplitude Spectrum')
xlim([10 20000])
ylabel('Amplitude [dB]')
xlabel('f [Hz]')

fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 3];

% Save as a pdf.
print('Guitar_freq_plot.pdf', '-dpdf')

 