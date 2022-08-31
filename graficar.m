function graficar(lon,lat,plon,plat,timestep,subtimestep,variable)
    clf
    
    cantidadPuntos = length(plat);
    
    title('Titulo');
    %m_proj('mercator','lon',[260 280],'lat',[17 32]);
    m_proj('mercator','lon',[255 315],'lat',[0 55]);
    m_gshhs_l('line','Color','k') % plot coastline at intermediate resolution, as black line
    hold on
    m_grid('box','fancy','linestyle','none','backcolor',[.9 .99 1]);
    
    [LON,LAT]=meshgrid(lon,lat);
    m_contourf(LON,LAT,variable);    

     
    %caxis([-0.5673,1.1558])
    %caxis([-1,1])
    %caxis([0.1,max(max(variable))])
    caxis([min(min(variable)),max(max(variable))])
    colormap(jet);
    colorbar
   
    for punto=1:cantidadPuntos
        ph=m_plot(plon(punto),plat(punto),'w.');
        set(ph,'MarkerSize',30);
    end     
    
    print(['figuras/particulas' '_' int2str(timestep) '-' int2str(subtimestep)],'-dpng')
    
end   