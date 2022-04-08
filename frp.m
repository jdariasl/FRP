function FRP = frp(x,dim,tau,cluster,T)
%------------------------------------------------------------------------
% Reference: Pham TD (2016) Fuzzy recurrence plots, EPL 116: 50008.
%------------------------------------------------------------------------
% Input:
%
%  x: time series
%
% dim: embedding dimension (default = 3)
%
%  tau: time delay (default = 1)
%
%  cluster: number of clusters (default = 2)
%
%  T: cuttoff fuzzy membership threshold to change grayscale to
%
%  black and white.
%
%  If T not given, FRP takes values in [0 1]. (default = NaN)
%
% Output:
%
% FRP: Fuzzy recurrence plot
% Test:
%
% x1 = randi([0 5],1,500); dim=3; tau=1; cluster=3; T=0.5;
%
% FRP=frp(x1,dim,tau,cluster,T);
%
% x2 = randi([0 255],1,500);
%
% FRP=frp(x2);
%------------------------------------------------------------------------
switch nargin
    case 1
        dim=3;
        tau=1;
        cluster=2;
        T=NaN;
    case 2
        tau=1;
        cluster=2;
        T=NaN;
    case 3
        cluster=2;
        T=NaN;
    case 4
        T=NaN;
end

PS = Embeb(x,dim,tau);

[~, FR, ~] = fcm(PS, cluster); % use FCM from Matlab Toolbox

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

figure
imshow(FRP)
end
