clear all
%% set default parameters
nb_symbols=400;
SNRdB=10;
Mk=100;
nbins2d=16;
seq_len=3000;
period_vector= floor((1.5.^(-5:4))*80);
%% 
close all
colormap(flipud(gray))
%%
figure(1)
SNRdB=10;
radioSVM_gensign
radioSVM_genhist;

%%
%Visualizando os histogramas do sinal amostrado na maior taxa possível
figure(1);
clear H; use1D=0
subplot(231);H=hist2_of_seq(AS(1,:),32); image(reshape(H,32,32)'*1);title('PSK4');
subplot(232);H=hist2_of_seq(AS(2,:),32); image(reshape(H,32,32)'*1);title('PAM4');
subplot(233);H=hist2_of_seq(AS(3,:),32); image(reshape(H,32,32)'*1);title('QAM4');
subplot(234);H=hist2_of_seq(AS(4,:),32); image(reshape(H,32,32)'*1);title('PSK8');
subplot(235);H=hist2_of_seq(AS(5,:),32); image(reshape(H,32,32)'*1);title('QAM16');
subplot(236);H=hist2_of_seq(AS(6,:),32); image(reshape(H,32,32)'*1);title('QAM64');
exportfig(1,'2Dhistograms');

%%
figure(2);colormap(flipud(gray))
clear H;
global use1D
use1D=1;
subplot(231);H=hist2_of_seq(AS(1,:),512); image(H(513:1024)'*H(1:512)*0.01);title('PSK4');

subplot(232);H=hist2_of_seq(AS(2,:),512); image(H(513:1024)'*H(1:512)*0.01);title('PAM4');
subplot(233);H=hist2_of_seq(AS(3,:),512); image(H(513:1024)'*H(1:512)*0.01);title('QAM4');
subplot(234);H=hist2_of_seq(AS(4,:),512); image(H(513:1024)'*H(1:512)*0.01);title('PSK8');
subplot(235);H=hist2_of_seq(AS(5,:),512); image(H(513:1024)'*H(1:512)*0.01);title('QAM16');
subplot(236);H=hist2_of_seq(AS(6,:),512); image(H(513:1024)'*H(1:512)*0.01);title('QAM64');
exportfig(2,'1Dhistograms');

%% 
close all
colormap(flipud(gray))
%%
figure(1)
SNRdB=0;
radioSVM_gensign
radioSVM_genhist;

%%
%Visualizando os histogramas do sinal amostrado na maior taxa possível
figure(1);
clear H; use1D=0
subplot(231);H=hist2_of_seq(AS(1,:),32); image(reshape(H,32,32)'*1);title('PSK4');
subplot(232);H=hist2_of_seq(AS(2,:),32); image(reshape(H,32,32)'*1);title('PAM4');
subplot(233);H=hist2_of_seq(AS(3,:),32); image(reshape(H,32,32)'*1);title('QAM4');
subplot(234);H=hist2_of_seq(AS(4,:),32); image(reshape(H,32,32)'*1);title('PSK8');
subplot(235);H=hist2_of_seq(AS(5,:),32); image(reshape(H,32,32)'*1);title('QAM16');
subplot(236);H=hist2_of_seq(AS(6,:),32); image(reshape(H,32,32)'*1);title('QAM64');
exportfig(1,'2Dhistograms_noisy');

%%
figure(2);colormap(flipud(gray))
clear H;
global use1D
use1D=1;
subplot(231);H=hist2_of_seq(AS(1,:),512); image(H(513:1024)'*H(1:512)*0.01);title('PSK4');

subplot(232);H=hist2_of_seq(AS(2,:),512); image(H(513:1024)'*H(1:512)*0.01);title('PAM4');
subplot(233);H=hist2_of_seq(AS(3,:),512); image(H(513:1024)'*H(1:512)*0.01);title('QAM4');
subplot(234);H=hist2_of_seq(AS(4,:),512); image(H(513:1024)'*H(1:512)*0.01);title('PSK8');
subplot(235);H=hist2_of_seq(AS(5,:),512); image(H(513:1024)'*H(1:512)*0.01);title('QAM16');
subplot(236);H=hist2_of_seq(AS(6,:),512); image(H(513:1024)'*H(1:512)*0.01);title('QAM64');
exportfig(2,'1Dhistograms_noisy');
