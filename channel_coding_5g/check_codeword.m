function out = check_codeword(c,B,z)
%c - codeword
%B - base matrix
%z - expansion factor
%out = 1 - codeword is valid
[m,n] = size(B);

syn = zeros(m*z,1);

for i = 1:m
    for j=1:n
        syn((i-1)*z+1:i*z) = mod(syn((i-1)*z+1:i*z)+shift(c((j-1)*z+1:j*z),B(i,j))',2);
    end
end

if any(syn)
    out = 0;
else
    out = 1;
end