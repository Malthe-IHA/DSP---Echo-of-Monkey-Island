clear all;  
 %% The Secret of Monkey Island - Opening theme
 [x,Fs] = audioread('Monkey_island.mp3');   
 delay = 0.5; % 0.5s delayed of audio.  
 alpha = 0.65; % Gain.
 D = delay*Fs;  
 y = zeros(size(x));  
 y(1:D) = x(1:D);  
   
   
 %%   FIR Filter Method.  
  b = [1,zeros(1,D),alpha];  % Creating coefficient for delay (22050 scalers of zero).
  y = filter(b,1,x);         % Filtering music sample with one 1 coefficient 22050 zero and one 0.65. 
  

 %% Echo of Monkey Island  
 soundsc(y,Fs); 