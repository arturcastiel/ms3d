function [ caso, malha, tipopeso, calcpeso, limitadora, fractarch, bcflag ] = readopt3D
%
opt = fopen('Options3D.txt','r'); 
celcaso = textscan(opt,'%u',1,'headerlines',4); caso = celcaso{1};
celmalha = textscan(opt,'%s',1,'headerlines',3); malha = char(celmalha{1});
celtipopeso = textscan(opt,'%s',1,'headerlines',3); tipopeso = char(celtipopeso{1});
celcalcpeso = textscan(opt,'%s',1,'headerlines',3); calcpeso = char(celcalcpeso{1});
cellimitadora = textscan(opt,'%s',1,'headerlines',3); limitadora = char(cellimitadora{1});
celfractarch = textscan(opt,'%s',1,'headerlines',6); fractarch = char(celfractarch{1});
bcflag = [101 0; 102 1; 103 2; 201 0; 202 -1; 203 1];
fclose(opt);

end