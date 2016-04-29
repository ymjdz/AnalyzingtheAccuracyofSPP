function Obs = grabdata(fid, NoSv1, NoObs, NoSv0)
%GRABDATA Positioned in a RINEX file at a selected epoch
%  	    reads observations of NoSv satellites

%Kai Borre 09-13-96
%Copyright (c) by Kai Borre
%$Revision: 1.0 $  $Date: 1997/09/23  $

global lin

Obs = zeros(NoSv1, NoObs);%行：卫星，列：观测值类型

if NoObs <= 5	  % This will typical be Turbo SII data，观测值类型小于5
   for u = 1:NoSv1
      lin = fgetl(fid);
      for k = 1:NoObs
         Obs(u,k) = str2num(lin(2+16*(k-1):16*k-2)); 
      end
   end
else		        % This will typical be Z12 data
   Obs = Obs(:,[1 2 3 4 5]); % We cancel the last two columns 6 and 7
   NoObs = 5;
   for u = 1:NoSv1
       lin = fgetl(fid);
       lin_doppler = fgetl(fid);%观测值类型多于5，需要跳过一行
       for k = 1:NoObs  %-1
           if isempty(str2num(lin(1+16*(k-1):16*k-2))) == 1, Obs(u,k) = nan;%截掉数据的最后两位
           else                                 %
               Obs(u,k) = str2num(lin(1+16*(k-1):16*k-2));
           end
           % Obs(u,NoObs) = str2num(lin(65:78));
       end
   end
end
if NoSv0 > NoSv1
    for i = 1:(NoSv0-NoSv1)
        lin = fgetl(fid);
        lin_doppler = fgetl(fid);
    end
end
%%%%%%%%% end grabdata.m %%%%%%%%%
