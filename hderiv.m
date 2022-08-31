% % % function hderiv
% % %     % this function computes centered difference
% % %     % approximations to first derivatives. at the
% % %     % edges it uses a one-sided second-order fda.
% % %     
% % %     %======================================================
% % % 	%Llamado de variables globales
% % %     global ghsubx ghsuby mx my g dx dy h
% % %     %======================================================
% % %       dxt2= g/(2.0*dx);
% % %       dyt2= g/(2.0*dy);
% % %       
% % %       for jj=2:mx
% % %           for ii=2:my
% % %       
% % % %                ghsubx(ii,jj)= (h(ii+1,jj)-h(ii-1,jj))*dxt2;
% % % %           
% % % %                ghsuby(ii,jj)= (h(ii,jj+1)-h(ii,jj-1))*dyt2;
% % %                ghsubx(jj,ii)= (h(jj,ii+1)-h(jj,ii-1))*dxt2;
% % %           
% % %                ghsuby(jj,ii)= (h(jj+1,ii)-h(jj-1,ii))*dyt2;
% % % 
% % %           end
% % %       end
% % % end

function hderiv
    % this function computes centered difference
    % approximations to first derivatives. at the
    % edges it uses a one-sided second-order fda.
    disp('HDERIV....................');

    %======================================================
	%Llamado de variables globales
    global ghsubx ghsuby mx my g dx dy h
    %======================================================
% % %       dxt2= g/(2.0*dx);
% % %       dyt2= g/(2.0*dy);
% % %       
% % %       for ii=2:mx
% % %           for jj=2:my
% % %       
% % %                ghsubx(ii,jj)= (h(ii+1,jj)-h(ii-1,jj))*dxt2;
% % %           
% % %                ghsuby(ii,jj)= (h(ii,jj+1)-h(ii,jj-1))*dyt2;
% % %                
% % %           end
% % %       end

    %=========================
    %INICIO calculos derivadas
    %=========================
    renglones = my;
    columnas = mx;
    
      dxt2= g/(2.0*dx);
      dyt2= g/(2.0*dy);   

    for renglon=1:renglones
        for columna=1:columnas
%             disp('============================');
%             disp('CALCULANDO DERIVADAS EN Y');
%             disp('============================');
            %=============================================================================================================================
            %CALCULANDO DERIVADAS EN Y
            %=============================================================================================================================        
            %=========================
            %Identificando frontera izquierda y calculando derivadas
            %=========================        
            if(sensado(renglon,columna-1,h)==-1000)
                if(sensado(renglon,columna,h)>-10 && sensado(renglon,columna+1,h)>-10 && sensado(renglon,columna+2,h)>-10)
                ndato = ( (-3*sensado(renglon,columna,h))+(4*sensado(renglon,columna+1,h))-(sensado(renglon,columna+2,h)) )*dxt2;
                ghsubx(renglon,columna) = ndato;
                end
            %=========================
            %Identificando frontera derecha y calculando derivadas
            %=========================        
            elseif(sensado(renglon,columna+1,h)==-1000)             
                if(sensado(renglon,columna,h)>-10 && sensado(renglon,columna-1,h)>-10 && sensado(renglon,columna-2,h)>-10)                               
                    ndato = ( (3*sensado(renglon,columna,h))-(4*sensado(renglon,columna-1,h))+(sensado(renglon,columna-2,h)) )*dxt2;
                    ghsubx(renglon,columna) = ndato;
                end
            %=========================
            %Calculando derivadas dentro de los limites de la matriz
            %=========================                    
            elseif (sensado(renglon,columna-1,h)>-10 && sensado(renglon,columna,h)>-10 && sensado(renglon,columna+1,h)>-10)
                ndato = (sensado(renglon,columna+1,h) - sensado(renglon,columna-1,h))*dxt2;
                ghsubx(renglon,columna) = ndato;
            end
%             disp('============================');
%             disp('CALCULANDO DERIVDAS EN X');
%             disp('============================');
            %=============================================================================================================================
            %CALCULANDO DERIVADAS EN X
            %=============================================================================================================================
            %=========================
            %Identificando frontera SUPERIOR y calculando derivadas
            %=========================        
            if(sensado(renglon-1,columna,h)==-1000)
                if(sensado(renglon,columna,h)>-10 && sensado(renglon+1,columna,h)>-10 && sensado(renglon+2,columna,h)>-10)
                ndato = ( (-3*sensado(renglon,columna,h))+(4*sensado(renglon+1,columna,h))-(sensado(renglon+2,columna,h)) )*dyt2;
                ghsuby(renglon,columna) = ndato;
                end
            %=========================
            %Identificando frontera INFERIOR y calculando derivadas
            %=========================        
            elseif(sensado(renglon+1,columna,h)==-1000)             
                if(sensado(renglon,columna,h)>-10 && sensado(renglon-1,columna,h)>-10 && sensado(renglon-2,columna,h)>-10)                               
                    ndato = ( (3*sensado(renglon,columna,h))-(4*sensado(renglon-1,columna,h))+(sensado(renglon-2,columna,h)) )*dyt2;
                    ghsuby(renglon,columna) = ndato;
                end
            %=========================
            %Calculando derivadas dentro de los limites de la matriz
            %=========================                    
            elseif (sensado(renglon-1,columna,h)>-10 && sensado(renglon,columna,h)>-10 && sensado(renglon+1,columna,h)>-10)
                ndato = (sensado(renglon+1,columna,h) - sensado(renglon-1,columna,h))*dyt2;
                ghsuby(renglon,columna) = ndato;
            end        

        end
    end

    %=========================
    %FIN calculos derivadas
    %=========================









end