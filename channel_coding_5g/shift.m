function y = shift(x,k)
% x - vector to shift 
% k - shift value 

if(k==-1) %if shift value = -1, set all values to 0 
    y = zeros(1,length(x));
else
    y = [x(k+1:length(x)) x(1:k)];
end