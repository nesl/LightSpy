clear all;

load starwar.txt_labelled.dat;
load browsing.txt_labelled.dat;

[nRow1 nCol1] = size(starwar_txt_labelled);
[nRow2 nCol2] = size(browsing_txt_labelled);

mat1 = zeros(nRow1+nRow2, 2);
mat1(1:nRow1, 1) = starwar_txt_labelled(:,1);
mat1(nRow1+1:nRow1+nRow2,2) = browsing_txt_labelled(:,1);
plot(mat1(:,1),'r');
hold on;
plot(mat1(:,2),'b');
hold off;