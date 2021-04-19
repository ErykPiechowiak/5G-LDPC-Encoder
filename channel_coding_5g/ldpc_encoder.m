function codeword = ldpc_encoder(msg,B,z)
%msg = information bits, vector length should be equal to kb * z 
%B - base matrix
%z - expansion factor

[m,n] = size(B);
kb = n-m;
codeword = zeros(1,n*z);
size(codeword)
codeword(1:kb*z) = msg;

%pa encoding
temp = zeros(1,z);

lambda = zeros(1,4*z);
for i=1:4
    lambda_temp = zeros(1,z);
    for j=1:kb
        temp=mod(temp+shift(msg((j-1)*z+1:j*z),B(i,j)),2);
        lambda_temp = mod(lambda_temp+shift(msg((j-1)*z+1:j*z),B(i,j)),2);
    end
lambda((i-1)*z+1:i*z) = lambda_temp;   
end

pa = zeros(1,4*z);
pa(1:z) = temp; %pa1
pa(z+1:2*z) = mod(lambda(1:z) + shift(pa(1:z),B(1,kb+1)),2); %pa2 
pa(3*z+1:4*z) = mod(lambda(3*z+1:4*z)+shift(pa(1:z),B(1,kb+1)),2); %pa4
pa(2*z+1:3*z) = mod(lambda(2*z+1:3*z)+pa(3*z+1:4*z),2); %pa3 

codeword(kb*z+1:(kb+4)*z) = pa;

%pc encoding

for k=1:42
    temp = zeros(1,z);
    for i=1:kb
        temp=mod(temp+shift(msg((i-1)*z+1:i*z),B(k+4,i)),2);
    end
    temp2 = zeros(1,z);
    for j=1:4
        temp2 = mod(temp2+shift(pa((j-1)*z+1:j*z),B(k+4,kb+j)),2);
    end
    pc((k-1)*z+1:k*z) = mod(temp+temp2,2);
    
end
codeword((kb+4)*z+1:n*z) = pc;




