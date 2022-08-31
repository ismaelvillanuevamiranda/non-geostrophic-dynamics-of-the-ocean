function hgrid9
    %hgrid9
    %This subroutine uses a nine grid point scheme to spread the mass of one
    %particle. Saves the weights (wts) to be used in the interpolation routine.
    
    %======================================================
	%Llamado de variables globales
    global n xorxp yoryp halfdx halfdy dx dy wts ids forwts
    %======================================================
      for in=1:n;
         
         ii= fix(xorxp(in)/dx+.5);
         fi= ii*dx;
         
         jj= fix(yoryp(in)/dy+.5);
         fj= jj*dy;
         
         ids(in,1)= ii;
         ids(in,2)= jj;
         
         dix0= xorxp(in)-fi;
         diy0= yoryp(in)-fj;
         dix1= halfdx-dix0;
         dix2= halfdx+dix0;
         diy1= halfdy-diy0;
         diy2= halfdy+diy0;
         
         ds11= dix1*diy1;
         ds12= dix1*diy2;
         ds21= dix2*diy1;
         ds22= dix2*diy2;
         
         wts(in,1,1)= ds11*forwts;
         wts(in,1,2)= (ds11+ds12)*forwts;
         wts(in,1,3)= ds12*forwts;
         wts(in,2,1)= (ds11+ds21)*forwts;
         wts(in,2,2)= (dx*dy)*forwts;
         wts(in,2,3)= (ds12+ds22)*forwts;
         wts(in,3,1)= ds21*forwts;
         wts(in,3,2)= (ds21+ds22)*forwts;
         wts(in,3,3)= ds22*forwts;

      end
end