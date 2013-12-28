% this is the base script for radioSVM_analysis# scripts
clear all;
%% set default parameters
nb_symbols=200;
SNRdB=10;
Mk=1024;
nbins2d=8;
seq_len=300;
period_vector= floor((1.5.^(-5:4))*80);
%%
SNR_variation=-40:5:10;
set_size_vector=[4 8 16 32 64 128 256 512]%2.^(4:1:10);
%% generate train data
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
%%
j=1;
for set_size=set_size_vector;
    % SVM train
    for i=1:8 %1:min(8,(Mk/set_size))
        fprintf('\nSVM multi-condition training with training size %d for each class and for each SNR level.\n',set_size);
        fprintf('\tSNR in multi condition: %s\n',sprintf('%d ',SNR_variation));
        fprintf('\trun number: %d\n',i);
        interval=Mk./set_size;
        ind=i:interval:length(Ytrain);
        fprintf('\tSVM train size=%d\n',length(ind));
        SVM=libsvmtrain(Ytrain(ind,1),Xtrain(ind,:), '-t 0 -c 1 -q ');%linear, coeficient C=1
        i=1;
        for SNRdB=SNR_variation
            ind=Ytest(:,4)==SNRdB;
            % SVM test
            fprintf('\tSVM test size=%d, SNR=%d\n',length(Ytest),SNRdB);
            [H, ~, ~] = libsvmpredict(Ytest(ind,1), Xtest(ind,:), SVM);
            acc(i,j)=sum(H==Ytest(ind,1))/length(H);
            i=i+1;
        end
        j=j+1;
    end
end
%% save
save data_SetSize.mat

%% visualize results

figN=1;
close all;figure(figN);
subplot(221);plot( SNR_variation,(acc(:,1:8)'),'bo');grid on; 
axis([(min(SNR_variation)) (max(SNR_variation))  0 1.1]);
xlabel('SNR');
ylabel('accuracy');
title('Set Size = 4');
subplot(222);plot( SNR_variation,(acc(:,9:16)'),'bo');grid on; 
axis([(min(SNR_variation)) (max(SNR_variation))  0 1.1]);
xlabel('SNR');
ylabel('accuracy');
title('Set Size = 8');
subplot(223);plot( SNR_variation,(acc(:,17:24)'),'bo');grid on; 
axis([(min(SNR_variation)) (max(SNR_variation))  0 1.1]);
xlabel('SNR');
ylabel('accuracy');
title('Set Size = 16');
subplot(224);plot( SNR_variation,(acc(:,25:32)'),'bo');grid on; 
axis([(min(SNR_variation)) (max(SNR_variation))  0 1.1]);
xlabel('SNR');
ylabel('accuracy');
title('Set Size = 32');


exportfig(figN,'radioSVM_analysisSetSize1');

figN=2;
figure(figN);
subplot(221);plot( SNR_variation,(acc(:,33:40)'),'bo');grid on; 
axis([(min(SNR_variation)) (max(SNR_variation))  0 1.1]);
xlabel('SNR');
ylabel('accuracy');
title('Set Size = 64');
subplot(222);plot( SNR_variation,(acc(:,41:48)'),'bo');grid on; 
axis([(min(SNR_variation)) (max(SNR_variation))  0 1.1]);
xlabel('SNR');
ylabel('accuracy');
title('Set Size = 128');
subplot(223);plot( SNR_variation,(acc(:,49:56)'),'bo');grid on; 
axis([(min(SNR_variation)) (max(SNR_variation))  0 1.1]);
xlabel('SNR');
ylabel('accuracy');
title('Set Size = 256');
subplot(224);plot( SNR_variation,(acc(:,57:64)'),'bo');grid on; 
axis([(min(SNR_variation)) (max(SNR_variation))  0 1.1]);
xlabel('SNR');
ylabel('accuracy');
title('Set Size = 512');


exportfig(figN,'radioSVM_analysisSetSize2');



