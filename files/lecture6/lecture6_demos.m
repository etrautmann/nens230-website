% Cell Arrays and Indexing
% ========================================
clc
clear all

x = cell(3,1);
x{1} = 'foo';
x{2} = 'bar';
x{3} = 'bar2'

%% adding dissimilar data to cell array (no problem)

x{4} = 1:5

%% Indexing cell arrays

clc

x(4)
x{4}

%% Concatenating cell arrays
clc

x
y = cell(3,1)
z = [x;y]




%% Structs 
% ========================================
clear all
clc

load J20110809_M1

%%
singleDir = reachingData(1)


%%  Struct Arrays
clear all
clc

load J20110809_M1

reachingData
reachingData(1).numTrials
[binnedMat binStarts binEnds] = binSpikeTimes( spikeTimes, binT, startT, endT )

%%

reachingData(:).numTrials 

%%
allDirs = {reachingData(:).targetDir}




