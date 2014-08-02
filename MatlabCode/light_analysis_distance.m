clear;

fileNameSet = {'L20cmA4', 'L40cmA4', 'L60cmA4', 'L80cmA4', 'L100cmA4'};

nFile= length(fileNameSet);

%% Folder names for storing templates and test files
templateFileName = 'L20cmA4new'; % fileNameSet{2};

scoreMatSelf = zeros(nFile, 2);
scoreMatOther = zeros(nFile, 2);

for i = 1:nFile
    testFileName = fileNameSet{i};
    fileName = ['label_score_' templateFileName '_' testFileName '_1200_50_corr.mat'];
    load(fileName);
    idx_same = label_score_mat(:,1) == label_score_mat(:,2);
    sum(idx_same)
    idx_diff = ~idx_same;   
    scoreMatSelf(i,:) = [mean(label_score_mat(idx_same,3)) std(label_score_mat(idx_same,3))];
    scoreMatOther(i,:) = [mean(label_score_mat(idx_diff,3)) std(label_score_mat(idx_diff,3))];
end

%% bar plot - mean
scoreMean = [scoreMatSelf(:,1) scoreMatOther(:,1)];
scoreStd = [scoreMatSelf(:,2) scoreMatOther(:,2)];

%% manually entered
scoreMean = [
    0.9187    0.5714
    0.8848    0.5704
    0.8365    0.5693
    0.8124    0.5574
    0.8056    0.5509];

scoreStd = [ 
    0.1091    0.1947
    0.1181    0.1847
    0.1405    0.1747
    0.1578    0.1731
    0.1495    0.1699];

% bar
numgroups = size(scoreMean, 1);
numbars = size(scoreMean, 2);

my_figure(1/2.5, 1/4);
bar(scoreMean, 'group');
xlabel('Distance from the display (cm)','fontsize', 18);
ylabel('Mean matching score', 'fontsize', 18);
legend('Same', 'Different');
set(gca, 'XTickLabel', {'20', '40', '60', '80', '100'}, 'Ygrid', 'on', 'fontsize', 18);
xlim([0.5 numgroups+0.5]);

colormap gray % jet

hold on;

% plot error bars
groupwidth = min(0.8, numbars/(numbars+1.5));
    for i = 1:numbars
        % location of error bar
        x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars);
        errorbar(x, scoreMean(:,i), scoreStd(:,i), '.k', 'linewidth', 1.5);
    end
