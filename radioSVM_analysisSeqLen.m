% this is the base script for radioSVM_analysis# scripts
clear all;
%% set default parameters
nb_symbols=200;
SNRdB=10;
Mk=100;
nbins2d=8;
seq_len=300;
period_vector= floor((1.5.^(-5:4))*80);
%%
SNR_variation=-40:5:10;
seq_vector=[75 150 300 600 1200]
%% generate train data
clear Xtrain Ytrain
for seq_len=seq_vector
for SNRdB=SNR_variation
    radioSVM_gensign;
    radioSVM_genhist;
    if exist('Xtrain')
        Xtrain=[Xtrain;X];
        Ytrain=[Ytrain;Y];
    else
        Xtrain=X;
        Ytrain=Y;
    end
end
end
%% generate test data
clear Xtest Ytest
for seq_len=seq_vector
for SNRdB=SNR_variation
    radioSVM_gensign;
    radioSVM_genhist;
    if exist('Xtest')
        Xtest=[Xtest;X];
        Ytest=[Ytest;Y];
    else
        Xtest=X;
        Ytest=Y;
    end
end
end
%%
j=1;
for seq_len=seq_vector
    % SVM train
    ind=Ytrain(:,2)==seq_len;
    fprintf('Training for seq_len=%d. #training_set=%d\n',seq_len,sum(ind));
    SVM=libsvmtrain(Ytrain(ind,1),Xtrain(ind,:), '-t 0 -c 1 -q');%linear, coeficient C=1
    % SVM test
    i=1;
    for SNRdB=SNR_variation
        ind=(Ytest(:,4)==SNRdB) & (Ytrain(:,2)==seq_len);
        fprintf('Testing for seq_len=%d and SNR=%d. #test_set=%d\n',seq_len,SNRdB,sum(ind));
        [H, ~, ~] = libsvmpredict(Ytest(ind,1), Xtest(ind,:), SVM);
        acc(i,j)=sum(H==Ytest(ind,1))/length(H);
        i=i+1;
    end
    j=j+1;
end
%% save
save data_SeqLen.mat

%% visualize results
clear all;
load data_SeqLen.mat
%%
figN=1;
close all;figure(figN); hold on;
plot(SNR_variation, acc(:, 1),'d');
plot(SNR_variation, acc(:, 2),'o');
plot(SNR_variation, acc(:, 3),'x');
plot(SNR_variation, acc(:, 4),'s');
plot(SNR_variation, acc(:, 5),'.');
grid on; 
axis([(min(SNR_variation)) (max(SNR_variation))  0 1.1]);
xlabel('SNR');
ylabel('accuracy');
legend('seq\_len=75','seq\_len=150','seq\_len=300','seq\_len=600','seq\_len=1200','Location','SouthEast');
title('Sequence Length Impact on Accuracy');
exportfig(figN,'radioSVM_analysisSeqLen1');

% 
% figN=2;
% figure(figN);
% semilogx((seq_vector), (acc'));
% grid on; 
% axis([(min(seq_vector)) (max(seq_vector))  0 1.1]);
% xlabel('Sequence Length');
% ylabel('accuracy');
% legend('SNR=-40','SNR=-30','SNR=-20','SNR=-10','SNR=0','SNR=10','Location','SouthEast');
% title('Sequence Length Impact on Accuracy');
% exportfig(figN,'radioSVM_analysisSeqLen2');
% 
