%%%% 函数-计算浮力

function B=Buoyancy(ZG,H0,V)
%需要输入ZG，H0，V
%ZG为潜艇相对于失联点深度，H0为失联点坐标，V为潜水艇体积
%常量
g=9.8;
%计算浮力
B=sea_density(ZG,H0)*V*g;