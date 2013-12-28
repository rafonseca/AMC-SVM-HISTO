clear all
%% set default parameters
nb_symbols=400;
SNRdB=inf;
Mk=100;
nbins2d=16;
seq_len=3000;
period_vector= floor((1.5.^(-5:4))*80);
close all
colormap(flipud(gray))
%%
figure(1)
SNRdB=10;
radioSVM_gensign
radioSVM_genhist;
subplot(131)
image(X)
title('Training Set with SNR=10')
xlabel('histogram bins')
ylabel('training samples')

SNRdB=0;
radioSVM_gensign;
radioSVM_genhist;
subplot(132)
image(X)
title('Training Set with SNR=0')
xlabel('histogram bins')
ylabel('training samples')

SNRdB=-10;
radioSVM_gensign;
radioSVM_genhist;
subplot(133)
image(X)
title('Training Set with SNR=-10')
xlabel('histogram bins')
ylabel('training samples')

% SNRdB=-20;
% radioSVM_gensign;
% radioSVM_genhist;
% subplot(144)
% image(X)
% title('Training Set with SNR=-20')
% xlabel('histogram bins')
% ylabel('training sample')
%
exportfig(1,'radioSVM_training_set1')
%%
global use1D
use1D=1;
nbins2d=128;

figure(2)
colormap(flipud(gray))


SNRdB=10;
radioSVM_gensign
radioSVM_genhist;
subplot(131)
image(X*0.5)
title('Training Set with SNR=10')
xlabel('histogram bins')
ylabel('training samples')

SNRdB=0;
radioSVM_gensign;
radioSVM_genhist;
subplot(132)
image(X*0.5)
title('Training Set with SNR=0')
xlabel('histogram bins')
ylabel('training samples')

SNRdB=-10;
radioSVM_gensign;
radioSVM_genhist;
subplot(133)
image(X*0.5)
title('Training Set with SNR=-10')
xlabel('histogram bins')
ylabel('training samples')

% SNRdB=-20;
% radioSVM_gensign;
% radioSVM_genhist;
% subplot(144)
% image(X)
% title('Training Set with SNR=-20')
% xlabel('histogram bins')
% ylabel('training sample')
%
exportfig(2,'radioSVM_training_set2')

%%
close all
clear use1D;
colormap(flipud(gray))
figure(1)
Mk=1000;

SNRdB=0;
radioSVM_gensign;
radioSVM_genhist;
image(X(2001:3000,:))
title('QAM4 with SNR=0')
xlabel('histogram bins')
ylabel('training samples')

exportfig(1,'radioSVM_partial_training_set')