function FRP = frp_pham(FR,PS,T)

cluster = size(FR,1);

cRP=zeros(length(FR),length(FR),cluster);

for c=1:cluster
    for i=1:length(FR)
        for j=1:length(FR)
            if norm(PS(i,:) - PS(j,:)) == 0
                cRP(i,j,c)= 1; % reflexivity
            elseif FR(c,i)>=FR(c,j)
                cRP(i,j,c)=FR(c,j);
            else
                cRP(i,j,c)=FR(c,i);
            end
        end
    end
end

FRP=zeros(length(cRP),length(cRP));

for c=1:cluster
    for i=1:length(cRP)
        for j=1:length(cRP)
            if c==1
                FRP(i,j)=cRP(i,j,c);
            else
                if cRP(i,j,c)>=FRP(i,j)
                    FRP(i,j)=cRP(i,j,c);
                end
            end
        end
    end
end
if ~isnan(T)
    FRP(FRP>=T)=1;
    FRP(FRP<T)=0;
end

FRP = imcomplement(FRP); % Dark pixels to indicate recurrences