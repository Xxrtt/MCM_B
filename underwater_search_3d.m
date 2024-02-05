
%%%% 程序-计算搜救成功的概率

clc
clear
rng('shuffle') % 重新设置随机数生成器

%% 计算搜救成功的概率

p = zeros(101, 1); % 变量矩阵预定义

for tt = 50:150
    s = 0;
    for i = 1:500
        s = s + underwater_rescue_3d(tt);
    end
    clc
    p(tt - 49) = s / 500;
end
xx = 50:150;

% 绘制可视化
figure;
plot(xx, p, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'r');
grid on;
xlabel('Time to Rescue the Submarine');
ylabel('Probability of Successful Rescue');

% 添加坐标轴范围
xlim([50, 150]);
ylim([0, 1]);

% 添加图例
legend('Probability of Successful Rescue', 'Location', 'best');

% 调整图表大小和位置
set(gcf, 'Position', [100, 100, 800, 400]);



%% 搜索函数
function ss=underwater_rescue_3d(tt)
ss=0;
%% 初始参数设置
m=22e+03; %潜艇质量
V=161; %潜艇体积
Iy=1.2327e+05; %转动惯量
H0=10*rand(1); %初始失联潜艇所处深度
L=8.2; %潜艇长度
d=2.5; %潜艇半径

%% 获得理论与实际运动位置坐标信息

tspan=[0,1];  

%设置初始的u,w,q,XG,ZG,theta
y0=zeros(8,1);
y0(1)=10+rand(1)-0.5;
y0(2)=10+rand(1)-0.5;
y0(3)=10+rand(1)-0.5;
y0(4)=1+0.1*rand(1)-0.05;

%计算
[t,y1]=ode45(@shijiyundong,tspan,y0,[],m,V,Iy,H0,d,L);%计算实际运动

[t,y2]=ode45(@lilunyundong,tspan,y0,[],m,V,Iy,H0,d,L);%计算理论运动

%获得实际与理论位置信息
XG1=100*y1(:,5); 
YG1=100*y1(:,6);
ZG1=100*y1(:,7);

XG2=100*y2(:,5); 
YG2=100*y2(:,6);
ZG2=100*y2(:,7);

    % 定义两个初始锚点2锚点
    anchor1 = [XG2(tt),YG2(tt),ZG2(tt)];
    anchor2 = [XG2(tt)+XG2(tt)*(rand(1)-0.5),YG2(tt)+YG2(tt)*(rand(1)-0.5),ZG2(tt)+ZG2(tt)*(rand(1)-0.5)];
    
    % 初始化潜水员的起始位置
    diver_position = anchor1;
    
    % 设置搜寻区域大小
    search_area_size = 100;  %更小的搜寻区域，以便更容易观察
    
    % 设置搜寻步长
    search_step = 15;
    
    % 设置搜寻次数
    search_iterations =50;

    % 设置目标点
    target_point = [XG1(tt),YG1(tt), ZG1(tt)];
   
    for i = 1:search_iterations
      
        % 沿着杰克斯塔线搜索
        diver_position = diver_position + (anchor2 - anchor1) * search_step / norm(anchor2 - anchor1);
        
        % 计算潜水员当前位置与目标位置的距离
        current_distance = norm(diver_position - target_point);
        
        % 显示潜水员位置
        if current_distance < search_step
            ss=1; % 搜救成功函数返回值为1
            break;
        else
        end

        % 移动第二个锚点
        anchor2_new = moveAnchor(search_area_size);
        
        % 计算潜水员下一步的位置
        next_position = diver_position + (anchor2_new - anchor1) * search_step / norm(anchor2_new - anchor1);
        
        % 计算潜水员下一步的距离
        next_distance = norm(next_position - target_point);
        
        % 判断是否需要更新第二个锚点的位置
        if next_distance < current_distance
            anchor2 = anchor2_new;
        end
    end
    
end

function new_anchor = moveAnchor(search_area_size)
    % 将第二个锚点移动到搜索区域内的新位置
    new_anchor = rand(1, 3) * search_area_size;
end
