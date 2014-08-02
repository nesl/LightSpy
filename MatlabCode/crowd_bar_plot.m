clear;

%% river 
% 10 0
% 6 4

a = [1 2];
b = [2 8];

my_figure(1/5, 1/4);
h = bar(a,diag(b),'stacked'); 
ylabel('Number of responses', 'fontsize', 18);

for i = 1:2
    text(a(i)-0.05, b(i)+0.6, num2str(b(i)), 'fontsize', 18);
end

xlim([0.5 2.5]);
ylim([0 12]);
colormap summer

set(gca, 'fontsize', 18, 'XTickLabel', {'Yes', 'No'});
