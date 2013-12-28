
fprintf('\n\tradioSVM_gensign\n');
dt_setGlobalConstants %set global variables

%% local configuration of global variables
showPlots=0; %use 1 to show plots
%shouldWriteEPS=0; %write EPS files
Fs=10000; %sampling frequency in Hz
over_sampling=80;
if ~exist('nb_symbols')
    nb_symbols=200;
end
L=over_sampling; %oversampling factor
S=nb_symbols; %number of symbols in string
useIdealChannel = 0; %set 1 if want ideal channel
%% QAM16
M=16; %number of symbols in alphabet
const=ak_qamSquareConstellation(M); %QAM const.
const=const*(0.9/max(real(const)));%normalize constellation
b=log2(M); %num of bits per symbol
Nbits=b*S; %total number of bits to be transmitted

QAM16_const=const;
fprintf('generate signal QAM16 with nb_symbols=%d, oversampling=%d, SNR=%d\n',nb_symbols,over_sampling,SNRdB)
txBitStream=rand(Nbits,1)>0.5; %bits: 0 or 1
delayInSamples=0;
[s, symbols]=ak_transmitter(txBitStream); %transmission
r=dt_channel(s,SNRdB); % channel

useQAM=1;% consider always complex samples. it must be set before calling ak_receiver
L=1;% baud rate of receiver
S=over_sampling*nb_symbols; %number of symbols in receiver
[rxBitStream, ys_QAM16]=ak_receiver(r); %receiver
L=over_sampling; %oversampling factor
S=nb_symbols; %number of symbols in string

%% QAM64
M=64; %number of symbols in alphabet
const=ak_qamSquareConstellation(M); %QAM const.
const=const*(0.9/max(real(const)));
b=log2(M); %num of bits per symbol
Nbits=b*S; %total number of bits to be transmitted

QAM64_const=const;
fprintf('generate signal QAM64 with nb_symbols=%d, oversampling=%d, SNR=%d\n',nb_symbols,over_sampling,SNRdB)
txBitStream=rand(Nbits,1)>0.5; %bits: 0 or 1
delayInSamples=0;
[s, symbols]=ak_transmitter(txBitStream); %transmission
r=dt_channel(s,SNRdB); % channel

useQAM=1;% consider always complex samples. it must be set before calling ak_receiver
L=1;% baud rate of receiver
S=over_sampling*nb_symbols; %number of symbols in receiver
[rxBitStream, ys_QAM64]=ak_receiver(r); %receiver
L=over_sampling; %oversampling factor
S=nb_symbols; %number of symbols in string

%% QAM4
M=4; %number of symbols in alphabet
const=ak_qamSquareConstellation(M); %QAM const.
const=const*(0.9/max(real(const)));
b=log2(M); %num of bits per symbol
Nbits=b*S; %total number of bits to be transmitted

QAM4_const=const;

fprintf('generate signal QAM4 with nb_symbols=%d, oversampling=%d, SNR=%d\n',nb_symbols,over_sampling,SNRdB)
txBitStream=rand(Nbits,1)>0.5; %bits: 0 or 1
delayInSamples=0;
[s, symbols]=ak_transmitter(txBitStream); %transmission
r=dt_channel(s,SNRdB); % channel

useQAM=1;% consider always complex samples. it must be set before calling ak_receiver
L=1;% baud rate of receiver
S=over_sampling*nb_symbols; %number of symbols in receiver
[rxBitStream, ys_QAM4]=ak_receiver(r); %receiver
L=over_sampling; %oversampling factor
S=nb_symbols; %number of symbols in string

%% PSK4
M=4; %number of symbols in alphabet

const=[-0.9j +0.9j -0.9 +0.9 ];
b=log2(M); %num of bits per symbol
Nbits=b*S; %total number of bits to be transmitted

PSK4_const=const;

fprintf('generate signal PSK4 with nb_symbols=%d, oversampling=%d, SNR=%d\n',nb_symbols,over_sampling,SNRdB)
txBitStream=rand(Nbits,1)>0.5; %bits: 0 or 1
delayInSamples=0;
[s, symbols]=ak_transmitter(txBitStream); %transmission
r=dt_channel(s,SNRdB); % channel

useQAM=1;% consider always complex samples. it must be set before calling ak_receiver
L=1;% baud rate of receiver
S=over_sampling*nb_symbols; %number of symbols in receiver
[rxBitStream, ys_PSK4]=ak_receiver(r); %receiver
L=over_sampling; %oversampling factor
S=nb_symbols; %number of symbols in string



%% PAM4
M=4; %number of symbols in alphabet

const=0.9*(-3:2:3)/3;
b=log2(M); %num of bits per symbol
Nbits=b*S; %total number of bits to be transmitted

PAM4_const=const;

fprintf('generate signal PAM4 with nb_symbols=%d, oversampling=%d, SNR=%d\n',nb_symbols,over_sampling,SNRdB)
txBitStream=rand(Nbits,1)>0.5; %bits: 0 or 1
delayInSamples=0;
[s, symbols]=ak_transmitter(txBitStream); %transmission
r=dt_channel(s,SNRdB); % channel

useQAM=1;% consider always complex samples. it must be set before calling ak_receiver
L=1;% baud rate of receiver
S=over_sampling*nb_symbols;; %number of symbols in receiver
[rxBitStream, ys_PAM4]=ak_receiver(r); %receiver
L=over_sampling; %oversampling factor
S=nb_symbols; %number of symbols in string
%% PSK8
M=8; %number of symbols in alphabet

const=0.9*sqrt(-1j).^(1:8);
b=log2(M); %num of bits per symbol
Nbits=b*S; %total number of bits to be transmitted

PSK8_const=const;

fprintf('generate signal PSK8 with nb_symbols=%d, oversampling=%d, SNR=%d\n',nb_symbols,over_sampling,SNRdB)
txBitStream=rand(Nbits,1)>0.5; %bits: 0 or 1
delayInSamples=0;
[s, symbols]=ak_transmitter(txBitStream); %transmission
r=dt_channel(s,SNRdB); % channel

useQAM=1;% consider always complex samples. it must be set before calling ak_receiver
L=1;% baud rate of receiver
S=over_sampling*nb_symbols;; %number of symbols in receiver
[rxBitStream, ys_PSK8]=ak_receiver(r); %receiver
L=over_sampling; %oversampling factor
S=nb_symbols; %number of symbols in string
%%
% subplot(2,3,1);plot(real(ys_PSK4),imag(ys_PSK4));axis(2*[-1 1 -1 1]);
% subplot(2,3,2);plot(real(ys_PAM4),imag(ys_PAM4));axis(2*[-1 1 -1 1]);
% subplot(2,3,3);plot(real(ys_QAM4),imag(ys_QAM4));axis(2*[-1 1 -1 1]);
% subplot(2,3,4);plot(real(ys_PSK8),imag(ys_PSK8));axis(2*[-1 1 -1 1]);
% subplot(2,3,5);plot(real(ys_QAM16),imag(ys_QAM16));axis(2*[-1 1 -1 1]);
% subplot(2,3,6);plot(real(ys_QAM64),imag(ys_QAM64));axis(2*[-1 1 -1 1]);
%%
save analog_radio_signals.mat ys*
