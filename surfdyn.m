% modelo para circulacion superficial a partir de altimetría
%
% Edgar Pavia

clear all;
close all;
format long g

hFig = figure(1);
colormap jet
% Cambiar el tamaÒo de la figura a 800x800 pixeles
set(hFig, 'Position', [0 0 800 800]);

%[var,lat,lon] = leerNetcdf('madt-ssh-1993-2014.nc','adt');
[fechaNETCDF,adt,lat,lon,longitude_max,longitude_min,latitude_max,latitude_min] = leerNetcdf('madt-ssh-1993-2014.nc','adt');
%============================================================
% Declaracion e inicializacion de variables globales
    global mx my mxp1 myp1 xl yl dx dy... 
       ds fnot g n x y u v ids wts...
       xorxp yoryp halfdx halfdy forwts...
       ghsubx ghsuby h ghxp ghyp dt...
       ghsubxG ghsubyG ghxpG ghypG xorxpG yorypG wtsG idsG

   

      


%============================================================
% Obtener el timestep inicial y final para la simulacion (del NetCDF) a partir de la fecha.
    %nd=1;
    %Meses: Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec
    timestepInicial = getTimestep('01-Jan-2013',fechaNETCDF)
    timestepFinal = getTimestep('31-Jan-2013',fechaNETCDF)
   
    %mx=80; my=80;			
    %[my,mx] = size(yq);

    % Resolucion 1km
    %mx = 2000;
    %my=1000;    
    %DX=1000;
    
    % Resolucion 10km
%     mx = 200;
%     my=100;    
%     DX=10000;
    
    % Resolucion 5km
    mx = 400;
    my=200;    
    DX=5000;    

    xl = mx*DX; yl=my*DX;    
    dx=xl/mx; dy=yl/my; ds=dx*dy;		
    fnot=1.e-4; g=10.0;
    % Numero de particulas n
    n=5;


    halfdx= 0.5*dx;	halfdy= 0.5*dy;			
    forwts= 1.0/(4.0*ds);	
    
%     x = randi([700000 1200000],1,n);
%     y = randi([480000 580000],1,n);

    x = randi([1250000 1750000],1,n);
    y = randi([425000 625000],1,n);

%     x = 1580000;
%     y = 480000;
    % Posicion inicial de las particulas
    
    


            u(1:n)=.1
            v(1:n)=.1             
    

    xorxp=x; yoryp=y;
    %Geostrofia
    xorxpG=x; yorypG=y;
    xG = x; yG = y;

for timestep=timestepInicial:timestepFinal

        %===============================================
        % MALLA RECTANGULAR E INTERPOLACION

            % Leer el campo de h
            ht = double(adt(:,:,timestep));
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
            [xq,yq] = meshgrid(-1100000:DX:4000000, -6300000:DX:-3100000);
            % Interpolando los datos a la nueva malla
            vq = griddata(double(xc),double(yc),double(vint),double(xq),double(yq));   
            % Recortando la malla a la region del golfo
            h = vq(1:my,1:mx);  
        
        % MALLA RECTANGULAR E INTERPOLACION            
        %===============================================

        
   
    %============================================================

    %============================================================
    % Declaracion e inicializacion de variables locales
        nd=1;
        endtime=nd*86400;

        time=0;
        timehora=0;

        %ifilm=1;
    %============================================================

    hderiv
    
    % Calculando u,v geostroficas   
            vg = (1/fnot)*ghsubx;
            ug = (-1/fnot)*ghsuby;
            ghsubxG=vg;
            ghsubyG=ug;     
    
    while time < endtime



        %===============================================
        % hgrid9
        % This function uses a nine grid point scheme to 
        % spread the mass of one particle. 
        % Saves the weights (wts) to be used in the 
        % interpolation routine.    
            %Geostrofia
            hgrid9G
            hgrid9
        %===============================================

        %===============================================
        % hderiv
        % this function computes centered difference
        % approximations to first derivatives. at the
        % edges it uses a one-sided second-order fda.
        %%%    hderiv
        %===============================================

        %===============================================
        % hdpoin
        % this function interpolates back to the 
        % particles positions.
            hdpoinG
            hdpoin
        %===============================================    

        %===============================================
        % varidt
        % CALCULA UN PASO TEMPORAL VARIABLE.
        % Se calcula el valor de la variable dt
            varidt
        %===============================================     




        %===============================================     
        % ADVANCES POINTS USING A PREDICTOR-CORRECTOR METHOD %
        %===============================================     
            for in=1:n;
               xp(in)= x(in)+dt*u(in);
               yp(in)= y(in)+dt*v(in);
               a1(in)= fnot*v(in)-ghxp(in);
               b1(in)=-fnot*u(in)-ghyp(in);
               
               %Geostrofia
               xG(in) = xG(in) + dt * ghypG(in); %u(in)
               yG(in) = yG(in) + dt * ghxpG(in); %v(in)
               
            end


            %BEGINING OF CORRECTOR CYCLE

            xorxp=xp;
            yoryp=yp;
            xorxpG=xG;
            yorypG=yG;

        %===============================================
        % hgrid9
        % This function uses a nine grid point scheme to 
        % spread the mass of one particle. 
        % Saves the weights (wts) to be used in the 
        % interpolation routine.
            hgrid9
        %===============================================


        %===============================================
        % hdpoin
        % this function interpolates back to the 
        % particles positions.
            hdpoin
        %===============================================    

        %===============================================    
        % ACTUALIZACIÓN DE x, y, u, v
          halfdt= 0.5*dt;
          for in=1:n;
             up= u(in)+dt*a1(in);
             vp= v(in)+dt*b1(in);
             ap= fnot*vp-ghxp(in);
             bp=-fnot*up-ghyp(in);
             x(in)= x(in)+halfdt*(u(in)+up);
             y(in)= y(in)+halfdt*(v(in)+vp);
             u(in)= u(in)+halfdt*(a1(in)+ap);
             v(in)= v(in)+halfdt*(b1(in)+bp);
          end		
        %===============================================    


        time=time+dt

        if time > timehora
            contourf(h,50);
            hold on;
            plot (x/dx,y/dy,'b.','markers',18);
            hold on;
            plot (xG/dx,yG/dy,'g.','markers',18);
            
            legend('Altimetria','Modelo','Geostrofico')
            
            caxis([-1,1])
            colormap(jet(50));
            colorbar            
            
            cb=colorbar
            cb.Label.String = 'Elevacion (mts)';
            %axis([0 80 0 80])
            axis([0 mx 0 my])
            
            date = datestr(fechaNETCDF(timestep)+datenum('1950-01-01 00:00:00'),'dd-mmm-yyyy');
            title(['Absolute Dynamic Topography ' date '- ' int2str(((timehora)/60)/60) 'hrs']);
            %figure
            %F(ifilm)=getframe;
            %ifilm=ifilm+1;
            
            print(['figuras/video4_30dias/particulas' '_' int2str(timestep) '-' int2str(timehora)],'-dpng')

            %timehora=timehora+6*3600;
            timehora=timehora+(6*3600);
            hold off
        end



    end
    %movie(F,2)
end         