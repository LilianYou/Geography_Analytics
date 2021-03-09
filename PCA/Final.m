%%% 1. Use the following steps to redo the PCA analysis of X = V*Z and
%%% calculate V and Z.

X = [2 0 4 -2; 2 -2 0 -2];
a = (X * X')/4;
[v, d] = eig(a);
eigval = diag(d);
eigval = eigval(end:-1:1);
v = fliplr(v)
Z = v' * X

%%%2
data = load('var.mat');
lat1 = data.lat1;
lon1=data.lon1;
var = data.var;
%%2.1 Plot the first four EOFs and PCS and indicate how much of total
%%variance of var each EOF could explain.
lat = 21:41;
lat2 = lat1(21:41);
var1 = var(:,lat,:);
var1 = reshape(var1,[2520,456]); 
a1 = (var1 * var1');
[v1, d1] = eig(a1);
eigval1 = diag(d1);
eigval1 = eigval1(end:-1:1);
v1 = fliplr(v1); 
Z1 = v1'*var1;
v2 = reshape(v1,[120,21,2520]); % EOF

% get the first four EOFs
EOF1 = v1(:,1);
EOF2 = v1(:,2);
EOF3 = v1(:,3);
EOF4 = v1(:,4);

% get the first four PCs
PC1 = Z1(1,:);
PC2 = Z1(2,:);
PC3 = Z1(3,:);
PC4 = Z1(4,:);

% plot
figure(1)
subplot(1,2,1)
for i = 1:120
    for j = 1:21
        map(j,i)=v2(i,j,1);
    end
end
pcolor(lon1,lat2,map)
shading interp
colorbar
title('the First EOF');

subplot(1,2,2)
plot(PC1);
title('the First PC');

figure(2)
subplot(1,2,1)
for i = 1:120
    for j = 1:21
        map(j,i)=v2(i,j,2);
    end
end
pcolor(lon1,lat2,map)
shading interp
colorbar
title('the Second EOF');

subplot(1,2,2)
plot(PC2);
title('the Second PC');

figure(3)
subplot(1,2,1)
for i = 1:120
    for j = 1:21
        map(j,i)=v2(i,j,3);
    end
end
pcolor(lon1,lat2,map)
shading interp
colorbar
title('the Third EOF');

subplot(1,2,2)
plot(PC3);
title('the Third PC');

figure(4)
subplot(1,2,1)
for i = 1:120
    for j = 1:21
        map(j,i)=v2(i,j,4);
    end
end
pcolor(lon1,lat2,map)
shading interp
colorbar
title('the Fourth EOF');

subplot(1,2,2)
plot(PC4);
title('the Fourth PC');

Sum_EOF = sumsqr(Z1);
PERCENT_EOF1 = sumsqr(PC1)/Sum_EOF; % 0.1218
PERCENT_EOF2 = sumsqr(PC2)/Sum_EOF; % 0.0923
PERCENT_EOF3 = sumsqr(PC3)/Sum_EOF; % 0.0495
PERCENT_EOF4 = sumsqr(PC4)/Sum_EOF; % 0.0405

% According to my calculation, 12.18% of total variance of var the first
% EOF could explain. 9.23% of total variance of var the second EOF could
% explain. 4.95% of total variance of var the third EOF could explain.
% 4.05% of var the fourth EOF could explain.

%% 2. Do you think how many leading EOFs are necessary to reconstruct original data with 90% accuracy? Show original var and the reconstructed one (with 90% accuracy) at time step (year=100) and the difference between the two at that time step. 

%2.1
Sum = 0;
for n = 1:1:2520
    if Sum < 0.9*Sum_EOF
        Sum = Sum + sumsqr(Z1(n,:));
    else
        return
    end
end

% n = 117
% 117 leading EOFs are necessary to reconstruct original data with 90% accuracy

%2.2 

Z1_90_percent = Z1(1:117,:);
v1_90_percent = v1(:,1:117);
var_new = v1_90_percent*Z1_90_percent; % reconstructed var
var_90 = var_new(:,100);
var_90_2 = reshape(var_90,[120,21]); 

figure(5);
for i = 1:120
    for j = 1:21
        map1(j,i)=var_90_2(i,j);
    end
end
pcolor(lon1,lat2,map1)
shading interp
colorbar
title('Original Var at Time Step of Year 100');

figure(6);
for i = 1:120
    for j = 1:21
        map2(j,i)=var(i,j+20,100);
    end
end
pcolor(lon1,lat2,map2)
shading interp
colorbar
title('Reconstructed Var at Time Step of Year 100');

figure(7);
for i=1:120
    for j=1:21
        map_dif_100(j,i) = map2(j,i)-map1(j,i);
    end
end
pcolor(lon1,lat2,map_dif_100)
shading interp
colorbar
title('Difference Between Original and Reconstructed Var at Time Step of Year 100');


%% 3. calculate to illustrate that the first four PCs and EOFs are orthogonal functions, respectively

%3.1 illustrate the first four PCs are orthogonal

PC1*PC2';% -7.9439e-12
PC1*PC3';%1.3337e-11
PC1*PC4';%-1.8585e-12
PC2*PC3';%3.1264e-13
PC3*PC4';%-1.0996e-12
PC3*PC4';%-1.0996e-12

%3.2 illustrate the first four EOFs are orthogonal
dot(EOF1,EOF2');%-1.3970e-16
dot(EOF1,EOF3');%3.1496e-16
dot(EOF1,EOF4');%3.6744e-16
dot(EOF2,EOF3');%-9.5730e-17
dot(EOF2,EOF4');%7.4481e-17
dot(EOF3,EOF4');%-1.8226e-16

% From the above calculations, the dot product of each pair of the first
% four PCs and EOFs, respectively, almost equal to zero which illustrate
% that they are orthogonal functions, respectively.

%%4
%4.1 calculate the power spectrum of the PC1

[pxx, f] = periodogram(PC1);
figure(8);
plot(f, pxx), grid;
title('power spectrum of the PC1 as a Function of the Frequency');

%4.2 calculate the correlation between PC1 with the original var in a
%global scale
figure(9);
for i=1:120
    for j=1:61
        for t=1:456
            newp1(t)=var(i,j,t);
            newp2(t)=PC1(t);
        end
 
        ttt=corrcoef(newp1,newp2); %[1,0.0474;0.0474,1]
        map(j,i)=ttt(1,2);
    end
end
pcolor(lon1,lat1,map)
shading interp
colorbar
title('the correlation between PC1 with the original var in a global scale')
    