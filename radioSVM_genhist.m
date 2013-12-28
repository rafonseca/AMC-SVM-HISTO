
fprintf('\n\tradioSVM_genhist\n');
load analog_radio_signals;
%Agrupamos os sinais em uma matriz
AS=[ys_PSK4';ys_PAM4';ys_QAM4'; ys_PSK8';ys_QAM16';ys_QAM64'];
clear ys_*
% Visualizando os histogramas do sinal amostrado na maior taxa possível
% figure(1);
% subplot(231);H=hist2_of_seq(AS(1,:),32); image(reshape(H,32,32)'*0.01);
% subplot(232);H=hist2_of_seq(AS(2,:),32); image(reshape(H,32,32)'*0.01);
% subplot(233);H=hist2_of_seq(AS(3,:),32); image(reshape(H,32,32)'*0.01);
% subplot(234);H=hist2_of_seq(AS(4,:),32); image(reshape(H,32,32)'*0.01);
% subplot(235);H=hist2_of_seq(AS(5,:),32); image(reshape(H,32,32)'*0.01);
% subplot(236);H=hist2_of_seq(AS(6,:),32); image(reshape(H,32,32)'*0.01);
%%
NTOT=size(AS,2); 
if ~exist('Mk','var')
    Mk= 10000;
end
if ~exist('seq_len','var')
    seq_len=300; 
end
if ~exist('nbins2d','var')
    nbins2d=16;
end
if ~exist('period_vector','var')
    period_vector=floor((1.5.^(-5:4))*80);
end

K=6; 
M=K*Mk;
if exist('use1D','var')
    fprintf('\n\nUsing 1D hist\n\n');
    N=nbins2d*2;
else
    N=nbins2d^2;
end

X=zeros(M,N);
Y=zeros(M,5);


fprintf('extract histograms with the following parameters:\n\t k=%d, Mk=%d, nbins2d=%d, seq_len=%d\n\t period_vector=[%s]\n',K,Mk,nbins2d,seq_len,sprintf('%d ',period_vector));
seq=zeros(1,seq_len);
fprintf('class:')
for i=1:K
    fprintf('\t%d',i)
    for j=1:Mk 
        offset=randi(NTOT);
        period=period_vector(1+floor((j-1)/(Mk/length(period_vector))));
        sample_ind=offset:period:(offset+seq_len*period-1);
        sample_ind=1+mod(sample_ind-1,NTOT);
        seq=AS(i,sample_ind);
        
        X(Mk*(i-1)+j,:)=hist2_of_seq(seq,nbins2d);
        Y(Mk*(i-1)+j,1)=i;
        Y(Mk*(i-1)+j,2)=seq_len;
        Y(Mk*(i-1)+j,3)=nbins2d;
        Y(Mk*(i-1)+j,4)=SNRdB;
        Y(Mk*(i-1)+j,5)=Mk;
        Y(Mk*(i-1)+j,6)=period;
    end
end
fprintf('\n');
%figure(2);image(X);
clear  hrx htx r s rxBitStream
%clear AS
