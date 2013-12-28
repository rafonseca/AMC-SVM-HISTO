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
variation_vector=[4 8 16 32];
%%
jj=1;
for nbins2d=variation_vector;
    fprintf('\n Generating train and test data with nbins2d=%d\n',nbins2d);
    % generate train data
    clear Xtrain Ytrain
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
    % generate test data
    clear Xtest Ytest
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
    fprintf('\nSVM multi-condition training with nbins=%d.\n',nbins2d);
    fprintf('\tSNR in multi condition: %s\n',sprintf('%d ',SNR_variation));
    % SVM train
    SVM=libsvmtrain(Ytrain(:,1),Xtrain, '-t 0 -c 1 -q');%linear, coeficient C=1
    % SVM test
    i=1;
    for SNRdB=SNR_variation
        fprintf('\tSVM test size=%d, SNR=%d, nbins=%d\n',length(Ytest),SNRdB,nbins2d);
        ind=Ytest(:,4)==SNRdB;
        [H, ~, ~] = libsvmpredict(Ytest(ind,1), Xtest(ind,:), SVM);
        acc(i,jj)=sum(H==Ytest(ind,1))/length(H);
        i=i+1;
    end
    jj=jj+1;
end
%% save
save data_Nbins.mat
%% visualize results

figN=1;
close all;figure(figN);hold on;
plot(SNR_variation, acc(:,1),'d');
plot(SNR_variation, acc(:,2),'o');
plot(SNR_variation, acc(:,3),'x');
plot(SNR_variation, acc(:,4),'s');
grid on; 
axis([(min(SNR_variation)) (max(SNR_variation))  0 1.1]);
xlabel('SNR');
ylabel('accuracy');
legend('#bins=16','#bins=64','#bins=256','#bins=1024','Location','SouthEast');
title('Impact of the histogram granularity');
exportfig(figN,'radioSVM_analysisNbins');



