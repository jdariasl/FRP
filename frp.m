function FRP = frp(x,dim,tau,cluster,T,metric)
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
        metric = 'ppk';
    case 2
        tau=1;
        cluster=2;
        T=NaN;
        metric = 'ppk';
    case 3
        cluster=2;
        T=NaN;
        metric = 'ppk';
    case 4
        T=NaN;
        metric = 'ppk';
    case 5
        metric = 'ppk';
end

PS = Embeb(x,dim,tau);


[~, FR, ~] = fcm(PS, cluster); % use FCM from Matlab Toolbox

if strcmp(metric,'original')
    FRP = frp_pham(FR,PS,T);
elseif strcmp(metric,'transi')
    FRP = rp_transi(FR,PS,T);
elseif strcmp(metric,'ppk')
    FRP = rp_ppk(FR',PS,T);
end
%figure
%imshow(FRP)
end
