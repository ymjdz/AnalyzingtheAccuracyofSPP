% single_point_position	  
% Read RINEX navigation file reformat into Matlab Eph matrix.
% Open a RINEX observation file analyse the header and identify
% observation types. The function fepoch_0 finds epoch time and 
% observed PRNs. Next we read the observations and use recpo_ls 
% to get a least-squares estimate for the (stand alone) receiver 
% position.

% Dongzhi Jiang 27-04-2016
% Copyright (c) by Dongzhi Jiang
% $Revision: 1.0 $  $Date: 2016/04/27  $

clear all;
clc;


% Read RINEX ephemerides file and convert to
% internal Matlab format
rinexe('SITE247J.01N','eph.dat');
Eph = get_eph('eph.dat');


% We identify the observation file and open it
ofile1 = 'SITE247J.01O';
fid1 = fopen(ofile1,'rt');
[Obs_types1, ant_delta1, ifound_types1, eof11] = anheader(ofile1);
NoObs_types1 = size(Obs_types1,2)/2;%观测值个数



Pos = [];


%================跳过头文件部分================
lin = fgets(fid1);
answer = findstr(lin,'END OF HEADER');
while isempty(answer);
    lin = fgetl(fid1);
    answer = findstr(lin,'END OF HEADER');
end;
%================跳过头文件部分================


% We can define how much epochs do we want
for q = 1:200
    [time1, sats1, NoSv0, eof1] = fepoch_0(fid1);%NoSv0:真实的卫星数，包括G和R
    NoSv1 = size(sats1,1);
    obs1 = grabdata(fid1, NoSv1, NoObs_types1, NoSv0);
    i = fobs_typ(Obs_types1,'C1');%找到需要的观测值类型
    pos = recpo_ls(obs1(:,i),sats1,time1,Eph);
    Pos = [Pos pos];
end
% me = mean(Pos,2);

plot((Pos(1:3,:)-Pos(1:3,1)*ones(1,q))','linewidth',2)
% plot((Pos(1:2,:)-Pos(1:2,1)*ones(1,q))','linewidth',2)
title('Positions Over Time','fontsize',16)
legend('X','Y','Z')
% legend('X','Y')
xlabel('Epochs [1 s interval]','fontsize',16)
ylabel('Variation in Coordinates, Relative to the First Epoch [m]','fontsize',16)
set(gca,'fontsize',16)
legend
%%%%%%%%%%%%%%%%%%%%% end single_point_position.m %%%%%%%%%%%%%%%



