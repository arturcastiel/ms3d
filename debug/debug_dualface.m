global vertex element

%% plotting centroid of the analyzed coarse volumes
plot_points(element.centroid(mref,:))

postprocessor3D( mref*10, 'coarse_volumes',1 );
postprocessor3D( cmref, 'coarse_face',1 );