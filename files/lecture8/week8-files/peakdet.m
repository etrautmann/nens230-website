function [pks,dep,pidx,didx] = peakdet(sig, th, type)
%PEAKDET  Detect Peaks and Depressions in a signal
%   returns peaks and depressions (local maxima and minimum) in the input signal.
%   It can detect peaks/dep crossing the threshold or zero.
%   Signal data requires a row or column vector with real-valued elements.
%   If there are no local minimum/maxima returns empty.
%
% Inputs:
%   sig - Signal column vector
%    th - threshold scalar absolute value
%  type - Detection crossing 'threshold' or 'zero'
%
% Outputs:
%   pks - peaks values that are greater than th
%   dep - depressions values that are less than th
%  pidx - peaks indices
%  pidx - depressions indices
%
% Example:
%   t = [0:.01:1]';                     % time vector
%   s = -sin(2*pi*5*t);                 % signal vector
%   s = s + .4*randn(length(s),1);      % add noise
%   th = 0.5;                           % choose th
%   [pks,dep,pidx,didx] = peakdet(s,th);% perform peak-dep detection
%   plot(t,s,'k'); hold on;             % plot signal
%   stem(t(pidx),pks,'g')               % plot peaks
%   stem(t(didx),dep,'r')               % plot depressions
%   line([t(1) t(end)],[th th], ...     % plot thresholds
%       'LineStyle','--','color','m');
%   line([t(1) t(end)],[-th -th],'LineStyle','--','color','m');
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: crossdet;

% Author: Marco Borges, Ph.D. Student, Computer/Biomedical Engineer
% UFMG, PPGEE, Neurodinamica Lab, Brazil
% email address: marcoafborges@gmail.com
% Website: http://www.cpdee.ufmg.br/
% Jul 2014; Version: v2; Last revision: 2014-07-18
% References:
% Eli Billauer's peakdet ver 3.4.05
%   SOURCE: http://billauer.co.il/peakdet.html
%
% Changelog:
%   v1 - fix th, return like matlab findpeaks and choose first peak or dep
%   v2 - accept row vector
%------------------------------- BEGIN CODE -------------------------------
pks = [];
dep = [];
pidx = [];
didx = [];

[m,n] = size(sig);
if m == 1 && n > 1
    sig = sig';
    [m,n] = size(sig);
end

if nargin < 2
    th = .5;
end

if length(th) > 1
    error('Input argument th (threshold) must be a scalar');
end

if th <= 0
    error('Input argument th (threshold) must be positive');
end

if ~exist('type', 'var')
    type = 'theshold';
end

if ~ischar(type)
    error('Input argument type must be string "theshold" or "zero"');
end

if strcmp(type,'theshold')
    cross = th;
elseif strcmp(type,'zero')
    cross = 0;
else
    error('Input argument type must be string "theshold" or "zero"');
end

mn = Inf; mx = -Inf;
mnpos = NaN; mxpos = NaN;

idx = find(sig>th,1,'first');
idn = find(sig<th,1,'first');
if idx < idn
    lookpks = true;
else
    lookpks = false;
end

for ii = 1:m
    this = sig(ii);
    if this > mx, mx = this; mxpos = ii; end
    if this < mn, mn = this; mnpos = ii; end
    
    if lookpks
        if this < cross
            if mx >= th
                pks = [pks; mx];
                pidx = [pidx; mxpos];
            end
            mn = this; mnpos = ii;
            lookpks = false;
        end
    else
        if this > -cross
            if mn <= -th
                dep = [dep; mn];
                didx = [didx; mnpos];
            end
            mx = this; mxpos = ii;
            lookpks = true;
        end
    end
end
%-------------------------------- END CODE --------------------------------