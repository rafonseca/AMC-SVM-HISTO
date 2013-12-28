clear all
%% set default parameters
nb_symbols=400;
SNRdB=inf;
Mk=100;
nbins2d=16;
seq_len=3000;
%period_vector= floor((1.5.^(-5:4))*80);
%%
radioSVM_gensign
%%
close all;
%%
figure(1);
subplot(231);
plot( real( ys_PAM4(1:80:end) ),imag( ys_PAM4(1:80:end) ) ,'.' );
title('PAM4');
%xlabel('In-phase');
%ylabel('Quadrature');
axis([-1 1 -1 1]); grid on;

subplot(232);
plot( real( ys_PSK4(1:80:end) ),imag( ys_PSK4(1:80:end) ) ,'.' );
title('PSK4');
%xlabel('In-phase');
%ylabel('Quadrature');
axis([-1 1 -1 1]); grid on;

subplot(233);
plot( real( ys_QAM4(1:80:end) ),imag( ys_QAM4(1:80:end) ) ,'.' );
title('QAM4');
%xlabel('In-phase');
%ylabel('Quadrature');
axis([-1 1 -1 1]); grid on;

subplot(234);
plot( real( ys_PSK8(1:80:end) ),imag( ys_PSK8(1:80:end) ) ,'.' );
title('PSK8');
% xlabel('In-phase');
% ylabel('Quadrature');
axis([-1 1 -1 1]); grid on;

subplot(235);
plot( real( ys_QAM16(1:80:end) ),imag( ys_QAM16(1:80:end) ) ,'.' );
title('QAM16');
% xlabel('In-phase');
% ylabel('Quadrature');
axis([-1 1 -1 1]); grid on;

subplot(236);
plot( real( ys_QAM64(1:80:end) ),imag( ys_QAM64(1:80:end) ) ,'.' );
title('QAM64');
% xlabel('In-phase');
% ylabel('Quadrature');
axis([-1 1 -1 1]); grid on;
%%
exportfig(1,'radioSVM_const_fig1')
%%
figure(2)
subplot(231);
plot( real( ys_PSK8(20:1:end) ),imag( ys_PSK8(20:1:end) ) ,'.' );
title('OverSampling=80/1');
% xlabel('In-phase');
% ylabel('Quadrature');
axis([-1 1 -1 1]); grid on;

subplot(232);
plot( real( ys_PSK8(20:15:end) ),imag( ys_PSK8(20:15:end) ) ,'.' );
title('OverSampling=80/15');
% xlabel('In-phase');
% ylabel('Quadrature');
axis([-1 1 -1 1]); grid on;

subplot(233);
plot( real( ys_PSK8(10:35:end) ),imag( ys_PSK8(10:35:end) ) ,'.' );
title('OverSampling=80/35');
% xlabel('In-phase');
% ylabel('Quadrature');
axis([-1 1 -1 1]); grid on;

subplot(234);
plot( real( ys_PSK8(20:80:end) ),imag( ys_PSK8(20:80:end) ) ,'.' );
title('OverSampling=80/80');
% xlabel('In-phase');
% ylabel('Quadrature');
axis([-1 1 -1 1]); grid on;

subplot(235);
plot( real( ys_PSK8(20:120:end) ),imag( ys_PSK8(20:120:end) ) ,'.' );
title('OverSampling=80/120');
% xlabel('In-phase');
% ylabel('Quadrature');
axis([-1 1 -1 1]); grid on;

subplot(236);
plot( real( ys_PSK8(20:270:end) ),imag( ys_PSK8(20:270:end) ) ,'.' );
title('OverSampling=80/270');
% xlabel('In-phase');
% ylabel('Quadrature');
axis([-1 1 -1 1]); grid on;

exportfig(2,'radioSVM_const_fig2')
%%
