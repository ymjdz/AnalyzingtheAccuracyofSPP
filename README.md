# Analyzing-the-Accuracy-of-SPP
### Analyzing the accuracy of single point position using Matlab.
Read RINEX navigation file reformat into Matlab Eph matrix.
Open a RINEX observation file (GPS-only or GPS-GLONASS mixd) analyse the header and identify observation types. 
The function fepoch0 finds epoch time and observed PRNs. Next we read the observations and use recpo_ls to get a least-squares estimate for the (stand alone) receiver position.

Thanks for the help of Kai Borre and his GPS Easy Suite.
