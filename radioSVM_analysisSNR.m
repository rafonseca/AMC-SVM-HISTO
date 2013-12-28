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
variation_vector=-40:5:10;
%% generate train data
clear Xtrain Ytrain
for SNRdB=variation_vector
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
%% generate test data
clear Xtest Ytest
for SNRdB=variation_vector
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
%% multi-condition case
% SVM train
SVM=libsvmtrain(Ytrain(:,1),Xtrain, '-t 0 -c 1 -q')%linear, coeficient C=1
% SVM test
i=1;
for SNRdB=variation_vector
    ind=Ytest(:,4)==SNRdB;
    [H, ~, ~] = libsvmpredict(Ytest(ind,1), Xtest(ind,:), SVM);
    MC_acc(i)=sum(H==Ytest(ind,1))/length(H);
    i=i+1;
end
%% matched case
i=1;
for SNRdB=variation_vector
    % SVM train
    ind=Ytrain(:,4)==SNRdB;
    SVM=libsvmtrain(Ytrain(ind,1),Xtrain(ind,:), '-t 0 -c 1 -q')%linear, coeficient C=1
    %SVM test
    ind=Ytest(:,4)==SNRdB;
    [H, ~, ~] = libsvmpredict(Ytest(ind,1), Xtest(ind,:), SVM);
    MA_acc(i)=sum(H==Ytest(ind,1))/length(H);
    i=i+1;
end
%% matched case for SNRdB=10
%SVM train
ind=Ytrain(:,4)==10;
SVM=libsvmtrain(Ytrain(ind,1),Xtrain(ind,:), '-t 0 -c 1 -q')%linear, coeficient C=1
%SVM test
i=1;
for SNRdB=variation_vector
    ind=Ytest(:,4)==SNRdB;
    [H, ~, ~] = libsvmpredict(Ytest(ind,1), Xtest(ind,:), SVM);
    MA10_acc(i)=sum(H==Ytest(ind,1))/length(H);
    i=i+1;
end
%% matched case for SNRdB=-15
%SVM train
ind=Ytrain(:,4)==-15;
SVM=libsvmtrain(Ytrain(ind,1),Xtrain(ind,:), '-t 0 -c 1 -q')%linear, coeficient C=1
%SVM test
i=1;
for SNRdB=variation_vector
    ind=Ytest(:,4)==SNRdB;
    [H, ~, ~] = libsvmpredict(Ytest(ind,1), Xtest(ind,:), SVM);
    MAm15_acc(i)=sum(H==Ytest(ind,1))/length(H);
    i=i+1;
end
%% save
save dataSNR.mat
%% visualize results
figN=1;
close all;figure(figN); hold on; grid on; 
plot(variation_vector, (MC_acc),'ko');
plot(variation_vector, (MA_acc),'k.');
plot(variation_vector, (MA10_acc),'kd');
plot(variation_vector, (MAm15_acc),'kx');
legend('Multi-condition','Matched','SNR=10','SNR=-15','Location','SouthEast');

axis([(min(variation_vector)) (max(variation_vector))  0 1.1]);
xlabel('SNR');
ylabel('accuracy');
title('Robustness to Noise');
exportfig(figN,'radioSVM_analysisSNR');



