clear
close all
clc

% Import the audio.
[x, Fs] = audioread('hello.wav');

% The number of unit step delay.
d = ceil(Fs / 1);

% The strenght of the echo.
alpha = 1 / 32

% Generate FIR filter.
b = [1, zeros(1, d), alpha];

% Apply the FIR filter.
y = filter(b, 1, x);

% Write the output.
audiowrite('echo.wav', y, Fs);
