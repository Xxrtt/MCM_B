
%%%% 程序-计算潜艇运动轨迹

clc
clear
rng('shuffle') %重新设置随机数生成器

%% 初始参数设置
m=22e+03; %潜艇质量
V=161; %潜艇体积
Iy=1.2327e+05; %转动惯量
H0=10*rand(1); %初始失联潜艇所处深度
L=8.2; %潜艇长度
d=2.5; %潜艇半径

%% 调用ode45求解器求解
%初始条件
tspan=[0,1];

%设置初始的u,w,q,XG,YG,ZG,theta
y0=zeros(8,1);

y0(1)=10+rand(1)-0.5; %加入随机影响
y0(2)=10+rand(1)-0.5;
y0(3)=10+rand(1)-0.5;
y0(4)=10+rand(1)-0.5;




%% 使用ode45求解 ODE

[t,y]=ode45(@shijiyundong,tspan,y0,[],m,V,Iy,H0,d,L);%计算潜艇实际运动轨迹

%% 绘图
XG=y(:,5); 
YG=y(:,6);
ZG=y(:,7);
figure
plot3(XG,YG,ZG,'LineWidth', 3);
grid on;
xlabel('XG');
ylabel('YG');
zlabel('ZG');
title('Submersible Three-dimensional Operational Trajectory');

%% 逐秒展示位置
hold on;
%for i= 1:size(ZG)
    %scatter3(XG(i), YG(i), ZG(i), 'Marker', 'o', 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'g');
   % pause(0.02); % 暂停一秒，以模拟实时更新
%end
