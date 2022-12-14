function hdpoin
    %hdpoin
    %this subroutine interpolates back to the particles positions.
    
    %======================================================
	%Llamado de variables globales
    global ghsubx ghsuby wts n ids ghxp ghyp
    %======================================================
    disp('HDPOIN....................');
      for in=1:n;
         
         ii= ids(in,1);
         jj= ids(in,2);
         
%          ghxp(in)= wts(in,1,1)*ghsubx(ii-1,jj-1)+wts(in,2,1)*ghsubx(ii,jj-1)+wts(in,3,1)*ghsubx(ii+1,jj-1)+wts(in,1,2)*ghsubx(ii-1,jj)+wts(in,2,2)*ghsubx(ii,jj)+wts(in,3,2)*ghsubx(ii+1,jj)+wts(in,1,3)*ghsubx(ii-1,jj+1)+wts(in,2,3)*ghsubx(ii,jj+1)+wts(in,3,3)*ghsubx(ii+1,jj+1);
%          
%          ghyp(in)= wts(in,1,1)*ghsuby(ii-1,jj-1)+wts(in,2,1)*ghsuby(ii,jj-1)+wts(in,3,1)*ghsuby(ii+1,jj-1)+wts(in,1,2)*ghsuby(ii-1,jj)+wts(in,2,2)*ghsuby(ii,jj)+wts(in,3,2)*ghsuby(ii+1,jj)+wts(in,1,3)*ghsuby(ii-1,jj+1)+wts(in,2,3)*ghsuby(ii,jj+1)+wts(in,3,3)*ghsuby(ii+1,jj+1);

         ghxp(in)= wts(in,1,1)*ghsubx(jj-1,ii-1)+...
             wts(in,1,2)*ghsubx(jj,ii-1)+...
             wts(in,1,3)*ghsubx(jj+1,ii-1)+...
             wts(in,2,1)*ghsubx(jj-1,ii)+...
             wts(in,2,2)*ghsubx(jj,ii)+...
             wts(in,2,3)*ghsubx(jj+1,ii)+...
             wts(in,3,1)*ghsubx(jj-1,ii+1)+...
             wts(in,3,2)*ghsubx(jj,ii+1)+...
             wts(in,3,3)*ghsubx(jj+1,ii+1);
         
         ghyp(in)= wts(in,1,1)*ghsuby(jj-1,ii-1)+...
             wts(in,1,2)*ghsuby(jj,ii-1)+...
             wts(in,1,3)*ghsuby(jj+1,ii-1)+...
             wts(in,2,1)*ghsuby(jj-1,ii)+...
             wts(in,2,2)*ghsuby(jj,ii)+...
             wts(in,2,3)*ghsuby(jj+1,ii)+...
             wts(in,3,1)*ghsuby(jj-1,ii+1)+...
             wts(in,3,2)*ghsuby(jj,ii+1)+...
             wts(in,3,3)*ghsuby(jj+1,ii+1); 
         
      end    
    
end