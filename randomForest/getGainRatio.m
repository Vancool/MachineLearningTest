function result=getGainRatio(gainResult,lessSet,moreSet)
%count gain ratio
%input:
%	gainResult   -the gain value
%   lessSet		 -the sample set whose feature value less than feature
%	moreSet		 -the sample set whose feature value more than feature
%output:
%	result       -the gain ratio
IVResult=countIV(lessSet,moreSet);
if IVResult==0
	result=inf;
else
	result=gainResult/IVResult;
end
end