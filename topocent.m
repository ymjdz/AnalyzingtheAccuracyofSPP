function [Az, El, D] = topocent(X,dx)
%TOPOCENT  Transformation of vector dx into topocentric coordinate
%          system with origin at X.
%          将卫地坐标差（dx）转换到站心坐标系中，原点为接收机坐标。
%          Both parameters are 3 by 1 vectors.
%          所有的参数都是3*1的向量。
%          Output: D    vector length in units like the input
%                  Az   azimuth from north positive clockwise, degrees 卫星方位角
%                  El   elevation angle, degrees 卫星高度角


dtr = pi/180;
[phi,lambda,h] = togeod(6378137,298.257223563,X(1),X(2),X(3));%转换为大地坐标系
cl = cos(lambda*dtr); sl = sin(lambda*dtr);
cb = cos(phi*dtr); sb = sin(phi*dtr);
F = [-sl -sb*cl cb*cl;
      cl -sb*sl cb*sl;
       0    cb   sb];
local_vector = F'*dx;
E = local_vector(1);
N = local_vector(2);
U = local_vector(3);
hor_dis = sqrt(E^2+N^2);
if hor_dis < 1.e-20
   Az = 0;
   El = 90;
else
   Az = atan2(E,N)/dtr;
   El = atan2(U,hor_dis)/dtr;%弧度制转换为角度制
end
if Az < 0
   Az = Az+360;
end
D = sqrt(dx(1)^2+dx(2)^2+dx(3)^2);
%%%%%%%%% end topocent.m %%%%%%%%%
