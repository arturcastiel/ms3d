clear
clc
path(path,'bkgrid3d');
path(path,'preprocessor');
path(path,'tools');
path(path,'debug');

global vertex element face options sist fracture

preconfig = create_preprocessor_config_structure();
msconfig = create_multiscale_config_structure();

for caso = 20

for malha = 1:1

% nomemalha = sprintf('cubosimplesregular_%u.msh',i);
% nomemalha = sprintf('cubodeyang_%u.msh',i);
%nomemalha = sprintf('fivespot3D_%u.msh',malha);
% nomemalha = sprintf('benchtetra_%u.msh',malha);
nomemalha = sprintf('hollowcube_%u.msh',malha);
nomemalha = sprintf('2halfhollowcube_4.msh');
nomemalha = sprintf('benchtetra_.msh');
%nomemalha = sprintf('cube_tet.msh');

nomemalha = sprintf('benchtetra_8.msh');
% nomemalha = sprintf('2halfhollowcube_%u.msh',malha);
% nomemalha = sprintf('oblique-fracture_%u.msh',i);

tp1 = 'LPEW1'; tp2 = 'LPEW2'; tp3 = 'LPEW3'; tp4 = 'LSW'; tp5 = 'IDW'; tp6 = 'YG2019';
tp = char(tp1,tp2,tp3,tp4,tp5,tp6);

for interp = 3:3
    
tipopeso = tp(interp,:);

for slope = 2:2
    
%     if slope==1, querlim = 'sim'; else querlim = 'nao'; end
%     
%     opt = fopen('Options3D.txt','w'); 
%     fprintf(opt,'\n\n\n\n');
%     fprintf(opt,'%u\n\n\n',caso);
%     fprintf(opt,'%s\n\n\n',nomemalha);
%     fprintf(opt,'%s\n\n\n',tipopeso);
%     fprintf(opt,'%s\n\n\n','compexp');
%     fprintf(opt,'%s\n\n\n\n\n\n',querlim); 
%     fprintf(opt,'%s','Teste_1');
%     fclose(opt);
%     
%% new preprocessor
    tic
    [vertex, element, face, wells] = mesh_processor(preconfig);
    toc
%%
    debug_mesh_processor
%%%
    %[ vertex, element, face, options, sist, fracture, wells ] = preprocessor3D;
  
if msconfig.run_ms
    [bkgrid, pcoarse, dcoarse] = create_msentities(msconfig);
end
   

toc

     
     %calculo das transm TPFA, calculo do GV e ASSMBY
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
