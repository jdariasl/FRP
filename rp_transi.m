function FRP = rp_transi(FR,PS,T)

cluster = size(FR,1);

cRP=zeros(length(FR),length(FR),cluster);

mTemp(:,:,1) = FR;
mTemp(:,:,2) = FR;

D = pdist2(PS,PS);

for i=1:length(FR)
    mTemp(:,:,1) = FR(:,i)*ones(1,length(FR));
    cRP(i,:,:) = min(mTemp,[],3)';
    indx = D(i,:) == 0;
    cRP(i,indx,:) = 1;
end

FRP = max(cRP,[],3);

if ~isnan(T)
    FRP(FRP>=T)=1;
    FRP(FRP<T)=0;
end

FRP = imcomplement(FRP); % Dark pixels to indicate recurrences