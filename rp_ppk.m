function RP = rp_ppk(FR,PS,T)

RP = FR * FR'; 

D = pdist2(PS,PS);
RP(D==0)=1;

if ~isnan(T)
    RP(RP>=T)=1;
    RP(RP<T)=0;
end

RP = imcomplement(RP); % Dark pixels to indicate recurrences