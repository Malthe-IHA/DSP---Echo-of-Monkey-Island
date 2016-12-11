clear
close all
clc

% Import the audio.
[x, Fs] = audioread('hello.wav');

% The strenght of the echo.
alpha = 1;

figure(1)

% Determine the average level.
lvl = mean(x);
x = x - lvl;

for i=(1:4)
    % The number of unit step delay.
    d = ceil(Fs / (2^(i - 1)));
    
    % Generate FIR filter.
    b = [1, zeros(1, d), alpha];
    
    % Apply the FIR filter.
    y = filter(b, 1, x);
    
    subplot(2, 2, i)
    plot(y)
    xlim([2E4, 1E5])
    title(sprintf('Delay of %.1f ms', d / Fs * 1000))
    ylabel('Signal amplitude')
    xlabel('Sample number')
end

fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 6 3];

% Save as a pdf.
print('EchoHello.pdf', '-dpdf')
