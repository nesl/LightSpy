clear all; 

distances = [5 10 15 20 25 30 35 40 50 60 70 80 90 100];
% energyArr = zeros(length(distances), 1);
illuminanceArr = zeros(length(distances), 1);
% intensityArr = zeros(length(distances), 1);
dirName = 'distances/';
for i = 1:length(distances)
    fileName = sprintf('%s%s%d%s',dirName, 'aladdin-data-',distances(i),'cm.txt');
    data = importdata(fileName);
    % energyArr(i) = dot(data(:,2), data(:,2))/length(data(:,2));
    illuminanceArr(i) = sum(data(:,2))/length(data(:,2));
    % intensityArr(i) = illuminanceArr(i)*(distances(i)^2);
end
figure;
plot(distances', illuminanceArr,'-s','linewidth', 3);
xlabel('Distance (in cm)','fontsize', 16);
ylabel('Illuminance', 'fontsize',16);
grid on;
% figure;
% plot(distances', intensityArr,'-s','linewidth', 3);
% xlabel('Distance (in cm)','fontsize', 16);
% ylabel('Light Intensity', 'fontsize',16);
% grid on;