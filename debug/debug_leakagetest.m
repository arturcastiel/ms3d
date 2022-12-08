global face pcoarse

el = 27;
%for jj = el
for jj = 1:max(pcoarse.elemloc)
    ii = jj;
    water_old = pcoarse.elemloc==ii;
    index = 1;

    postprocessor3D( boundary_support(:,ii), 'support', 1 );
    while true
        ref = ...
            any(ismember([face.inner.montelem face.inner.juselem],find(water_old)),2);
        ind = unique([face.inner.montelem(ref); face.inner.juselem(ref)]);
        water_new = false(size(water_old ));
        water_new(ind) = true;
        water_new(boundary_support(:, ii)) = false;
        if all(water_old == water_new) %| index == 30
            disp(num2str(jj) + ": Teste terminado com sucesso com " + num2str(index))
            break
        end
       water_old = water_new;
       %postprocessor3D(water_old, 'leaking', index);    
       index = index + 1;
    end
end

%postprocessor3D( boundary_support(:,ii), 'all_faces', 1 );
%postprocessor3D( pcoarse.elemloc==ii, 'volumes', 1 );

