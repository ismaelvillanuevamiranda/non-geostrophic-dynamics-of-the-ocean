function varidt
    % CALCULA UN PASO TEMPORAL VARIABLE.
    
    %======================================================
	%Llamado de variables globales
    global dt dx u v fnot n
    %======================================================
      phi= 0.05;
      wmax= 0.0;
      
      for in=1:n;
         
         w= sqrt(u(in)*u(in)+v(in)*v(in));
         
         if w > wmax;
            wmax= w;
         end
      end
      
      %%%%%%%%%
      dmin=dx;%
      %%%%%%%%%
      
      dt= phi*dmin/wmax;
      
      xinvf= 6.28/fnot;
      
      if dt > xinvf;
         dt= xinvf;
      end
end