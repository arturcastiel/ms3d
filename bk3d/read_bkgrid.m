function [elem,coord] = read_bkgrid(verifymshfile)
%read_bkgrid read the bkgrid from verifymshfile
%   Detailed explanation goes here
[coord,nnode] = read_coord(verifymshfile);
[elem] = read_elem(verifymshfile, nnode);
end



function [coord,nnode] = read_coord(verifymshfile)
%verifymshfile = [pwd '\Malhas\' verifymshfile];
verifymshfile = pwd+"\Malhas\"+verifymshfile;
%verifymshfile = strjoin(verifymshfile,'');
readmsh = fopen(verifymshfile);
%"nnode" is the number of nodes in the discrete domain
getmshdata = textscan(readmsh,'%u',1,'HeaderLines',4);
%Attribute the data to "nnode"
nnode = getmshdata{1};

%"coord" is a matrix which contain the coordinate of each point of domain
getmshdata = textscan(readmsh,'%*u %f64 %f64 %f64',nnode,'HeaderLines',1);
%Fill the matrix "coord" with the x, y and z coordinates.
coord = cell2mat(getmshdata);

%Clear "getmshdata"
clear getmshdata;

%Close the *.msh file
fclose(readmsh);
end

function [elem] = read_elem(verifymshfile, nnode)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
verifymshfile = [pwd '\Malhas\' verifymshfile];
verifymshfile = strjoin(verifymshfile,'');
A = openCell(verifymshfile);

flag = 0;
for index = nnode+9 : (size(A,2) - 2)
    tline = str2num(A{index});
    if (flag == 0) & ((tline(2) ~= 15) &  (tline(2) ~= 1) &   (tline(2) ~= 2)) &   (tline(2) ~= 3)
        flag = index;
    end
end
elem = zeros( ((size(A,2) - 2) - flag) + 1, 8);
A = A(flag:end-2);
for ii = 1:size(A,2)
    line = str2num(A{ii});
    if line(2) == 4
        elem(ii,1:4) = line(end-3:end);
    elseif line(2) == 5
        elem(ii,1:8) = line(end-7:end);
    end
end



end
