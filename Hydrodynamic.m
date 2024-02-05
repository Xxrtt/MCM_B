%%%% 函数-计算阻力

function [X,Y,Z,M]=Hydrodynamic(ZG,H0,d,L,u,v,w,q)
%ZG为潜艇相对于失联点深度，H0为失联点坐标，L为潜水艇长度，d为直径，u、w、q为速度
%流体常数
Cx=0.38;%用半球体近似
Cy=1.2;%弧形柱状曲面
Cz=1.2;%弧形柱状曲面
Cm=1.2;

%密度
rho=sea_density(ZG,H0);

%阻力项计算
X=1/2*rho*pi*(d/2)^2*u^2*Cx;
Y=1/2*rho*L*(d/2)*v^2*Cy;
Z=1/2*rho*L*(d/2)*w^2*Cz;
M=1/4*rho*d*q^2*Cm*(L/2)^4;


