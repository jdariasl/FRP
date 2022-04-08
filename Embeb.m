% function[atractor]=Embeb(vSignal,iDim,iTao)
% Funci�n para reconstruir el espacio de embebimiento de una se�al empleando 
% el m�todo de Takens (time-delay).
%
%  $Id:$
%
function[mAtractor]=Embeb(vSignal,iDim,iTao)



mAtractor=vSignal((1:length(vSignal)-((iDim-1)*iTao))'*ones(1,iDim)+ones(length(vSignal)-((iDim-1)*iTao),1)*(0:iDim-1)*iTao);