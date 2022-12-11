function [elem,elem_flag,bedgeref,nflag] = getelem(filepath,nnode)
%Open the *.msh file
readmsh = fopen(filepath);
nflag = zeros(nnode,1);
%"nent" is the number of all entities understud as element in *.msh file
getmshdata = textscan(readmsh,'%u',1,'HeaderLines',7 + nnode);
%Attribute the data to "nnode"
nent = getmshdata{1};
%Swept the "elements" of "*.msh" in order to fill the parameters above. 
getmshdata = textscan(readmsh,'%*n %n %*n %n %*[^\n]',nent);
%Attribute the data to "auxmat"
auxmat = cell2mat(getmshdata);
%Fill "entitype"
entitype = auxmat(:,1);
%"nbe" verifies how many entities are edges which constitute the 
nbedge = sum(entitype == 2);
nelem = sum(entitype == 4);
%Close the *.msh file
fclose(readmsh);

%---------------------------
%Define the matrix ("elem"):
%Open again the *.msh file
readmsh = fopen(filepath);
%Create and initialize the parameter "elem"
elem = zeros(nelem,5);  %nelem rows and 5 columns
if nbedge > 0  
    H1 = 8 + nnode + sum(entitype == 15) + sum(entitype == 1);
    getmshdata = textscan(readmsh,'%*u %*u %*u %u %*u %u %u %u',nbedge,...
        'HeaderLines',H1);
    bedgeaux = cell2mat(getmshdata);
    bedgeref(1:nbedge,5) = bedgeaux(:,1); 
    bedgeref(1:nbedge,1:3) = bedgeaux(:,2:4); 
elseif nbedge == 0
    H1 = 7 + nnode + sum(entitype == 15) + sum(entitype == 1);
    getmshdata = textscan(readmsh,'%*u %*u %*u %u %*u %u %u %u',nbedge,...
        'HeaderLines',H1);
    bedgeref = [];
end  %End of second IF

if nelem > 0
    getmshdata = textscan(readmsh,'%*u %*u %*u %u %*u %u %u %u %u',nelem,...
        'HeaderLines',1);
    elemaux = cell2mat(getmshdata);
    %Attribute to "elem" (fifth column)
    elem(1:nelem,5) = elemaux(:,1); 
    %Attribute to "elem" (another column)
    elem(1:nelem,1:4) = elemaux(:,2:5); 
end  %End of second IF

for bi=1:size(bedgeref,1)
    vert = bedgeref(bi,1:3);
    nflag(vert) = bedgeref(bi,5);
end

%Close the *.msh file
fclose(readmsh);

%Open the *.msh file
readmsh = fopen(filepath);        
%"nent" is the number of all entities understud as element in *.msh file
getmshdata = textscan(readmsh,'%u',1,'HeaderLines',7 + nnode);
%Attribute the data to "nnode"
nent = getmshdata{1};
%Swept the "elements" of "*.msh" in order to fill the parameters above. 
getmshdata = textscan(readmsh,'%*n %n %*n %n %*[^\n]',nent);
%Attribute the data to "auxmat"
auxmat = cell2mat(getmshdata);
%Fill "entitype"
entitype = auxmat(:,1);
%"nbe" verifies how many entities are edges which constitute the 
espnode = sum(entitype == 15);
nflag(1:espnode) = auxmat(1:espnode,2);
%Close the *.msh file
fclose(readmsh);
elem_flag = elem(:,end);
elem = elem(:,1:4);
end