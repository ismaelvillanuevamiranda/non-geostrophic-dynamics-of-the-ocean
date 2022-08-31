            %[fechaNETCDF,adt,lat,lon,longitude_max,longitude_min,latitude_max,latitude_min] = leerNetcdf('madt-ssh-1993-2014.nc','adt');
            % Leer el campo de h
            ht = double(adt(:,:,1));
            % Rotar el campo de h
            h=rot90(flipud(ht),-1);
            % Pasar la malla a vector
            indice=0;
            for renglon=1:length(lat)
                for columna=1:length(lon)
                    indice = indice+1;
                    xint(indice) = lon(columna);
                    yint(indice) = lat(renglon);
                    vint(indice) = h(renglon,columna);
                end
            end
            % Transformar de coordenadas esfericas a rectangulares
            [xc,yc,zc] = sph2cart(xint*(pi/180),yint*(pi/180),earthRadius);
            % Crear la nueva malla a la que se va a interpolar
            [xq,yq] = meshgrid(-1100000:1000:4000000, -6300000:1000:-3100000);
            % Interpolando los datos a la nueva malla
            vq = griddata(double(xc),double(yc),double(vint),double(xq),double(yq));   
            % Recortando la malla a la region del golfo
            h = vq(1:100,1:200); 