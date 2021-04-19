clear;
load NR_1_2_20.txt;
B = NR_1_2_20;
z = 20;
[m,n] = size(B);
msg = randi([0 1],1,(n-m)*z);
%encode generated msg
c = ldpc_encoder(msg,B,z);
out = check_codeword(c,B,z)

