function icol = find_eph(Eph,sv,time)
%FIND_EPH  Finds the proper column in ephemeris array

%Kai Borre and C.C. Goad 11-26-96
%Copyright (c) by Kai Borre
%$Revision: 1.2 $  $Date: 2004/02/09  $

icol = 0;%用于在星历中位于第几列的标记
isat = find(Eph(1,:) == sv);%在第几列
n = size(isat,2);%isat的列数赋给n
if n == 0%n=0就是一列都没有，就是没找到
   return
end;
icol = isat(1);
dtmin = Eph(21,icol)-time;

%{
下面这部分没看懂
%}
for t = isat%不明白什么作用
   dt = Eph(21,t)-time;
   if dt < 0
      if abs(dt) < abs(dtmin)
         icol = t;
         dtmin = dt;
      end
   end
end
%%%%%%%%%%%%  find_eph.m  %%%%%%%%%%%%%%%%%
