o = rand(100,1);

% first few have large amplitude
a = [100*o(1:50) o(51:100)];

b = [100*a(1:50) a(51:100)];

c = [a(1:50) a(51:100)];

corr(a,b)
corr(a,c)