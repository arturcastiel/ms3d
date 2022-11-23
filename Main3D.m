clear
clc
path(path,'bk3d');
path(path,'debug');

global vertex element face options sist fracture

for caso = 20

for malha = 1:1

% nomemalha = sprintf('cubosimplesregular_%u.msh',i);
% nomemalha = sprintf('cubodeyang_%u.msh',i);
%nomemalha = sprintf('fivespot3D_%u.msh',malha);
% nomemalha = sprintf('benchtetra_%u.msh',malha);
nomemalha = sprintf('hollowcube_%u.msh',malha);
nomemalha = sprintf('2halfhollowcube_4.msh');
nomemalha = sprintf('benchtetra_6.msh');


% nomemalha = sprintf('2halfhollowcube_%u.msh',malha);
% nomemalha = sprintf('oblique-fracture_%u.msh',i);

tp1 = 'LPEW1'; tp2 = 'LPEW2'; tp3 = 'LPEW3'; tp4 = 'LSW'; tp5 = 'IDW'; tp6 = 'YG2019';
tp = char(tp1,tp2,tp3,tp4,tp5,tp6);

for interp = 3:3
    
tipopeso = tp(interp,:);

for slope = 2:2
    
    if slope==1, querlim = 'sim'; else querlim = 'nao'; end
    
    opt = fopen('Options3D.txt','w'); 
    fprintf(opt,'\n\n\n\n');
    fprintf(opt,'%u\n\n\n',caso);
    fprintf(opt,'%s\n\n\n',nomemalha);
    fprintf(opt,'%s\n\n\n',tipopeso);
    fprintf(opt,'%s\n\n\n','compexp');
    fprintf(opt,'%s\n\n\n\n\n\n',querlim); 
    fprintf(opt,'%s','Teste_1');
    fclose(opt);

    [ vertex, element, face, options, sist, fracture, wells ] = preprocessor3D;
    
    %% adding the centers of the faces to the original preprocessor
    face.bound.centroid = findcentelem(vertex.coord, face.bound.vertices);
    face.inner.centroid = findcentelem(vertex.coord, face.inner.vertices);

    %%


    coarse_example = "2halfhollowcube_1.msh";
    coarse_example = "cube03.msh";

    [coord, elem, F, fElem, bfaces] = create_msentities(coarse_example)



    [ Keq, GV ] = complementaprep3D;

    pesos3D( Keq, GV );

    p = solver3D( wells, Keq, GV );

    [ q, influx, bflux, G, NG ] = flowbalance3D( p, Keq, GV );

    [ eL2, gradL2 ] = Erro3D( p, G, NG );

    postprocessor3D( p, 'Output',1 );
    
end

end

end

end