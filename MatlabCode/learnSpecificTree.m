clear all;

load ./Movies.dat;
load ./Other.dat;

%% data plot
n_min = min(length(Movies(:,1)), length(Other(:,1)));
range_plot = 1:n_min;
plot(range_plot, Movies(range_plot,1), 'b-x', range_plot, Other(range_plot,1), 'g-o');
legend('Movie', 'Other')


labelIndex = 2;
other = 0;
movie = 1;

% Use 50 samples to compute the features
numSamples = 50;

featureMovie = createFeatureArr(Movies, numSamples, movie);
featureOther = createFeatureArr(Other, numSamples, other);

splitRate = 0.8;

[numRows1 numCols1] = size(featureMovie);
trainSetSize1 = ceil(splitRate*numRows1);

[numRows2 numCols2] = size(featureOther);
trainSetSize2 = ceil(splitRate*numRows2);

xTrain = [featureMovie(1:trainSetSize1,1:numCols1-1); ...
    featureOther(1:trainSetSize2,1:numCols2-1)];

yTrain = [featureMovie(1:trainSetSize1,numCols1); ...
    featureOther(1:trainSetSize2,numCols2)];

[numTrain numColTrain] = size(xTrain);


t = classregtree(xTrain, yTrain, 'method','classification','prune','off', ...
'Cost', [0 10; 150 0]);
%view(t);

%# test
t = prune(t, 'Level',10);
view(t);

xTest = [featureMovie(trainSetSize1+1:numRows1,1:numCols1-1); ...
    featureOther(trainSetSize2+1:numRows2,1:numCols2-1)]; 

yTest = [featureMovie(trainSetSize1+1:numRows1,numCols1); ...
    featureOther(trainSetSize2+1:numRows2,numCols2)];

%yPredicted = eval(t, xTest);
[yPredicted nodeVec] = eval(t, xTrain);

%cm = confusionmat(yTest, str2num(cell2mat(yPredicted)));   %# confusion matrix
cm = confusionmat(yTrain, str2num(cell2mat(yPredicted)));   %# confusion matrix
N = sum(cm(:));
err = ( N-sum(diag(cm)) ) / N;          %# testing error


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Get the distribution for D, X, and Y %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[leafNodes I J] = unique(nodeVec);
distribution = zeros(length(leafNodes), 1);

for i = 1:length(J)
    distribution(J(i)) = distribution(J(i)) + 1;
end