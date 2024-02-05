%%%% 函数-理论运动微分方程（不考虑随机因素）


function s=lilunyundong(~,y,m,V,Iy,H0,d,L)

[X,Y,Z,M]=Hydrodynamic(y(7),H0,d,L,y(1),y(2),y(3),y(4)); %阻力计算

G=Gravity(m); %重力计算

B=Buoyancy(y(7),H0,V); %浮力计算

% 运动微分方程组
s1=(X-(G-B)*sin(y(8)))/m-y(3)*y(4);
s2=-Y/m;
s3=(Z-(G-B)*cos(y(8)))/m+y(1)*y(4);
s4=(M-G*(y(4)*cos(y(8))-y(5)*sin(y(8))))/Iy;
s5=y(1);
s6=y(2);
s7=y(3);
s8=y(4);
s=[s1;s2;s3;s4;s5;s6;s7;s8];