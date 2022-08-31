function [time,var,lat,lon,longitude_max,longitude_min,latitude_max,latitude_min] = leerNetcdf(nombre,variable)
    %Leer archivo NETCDF
    %archivo=['madt-ssh-1993-2014.nc'];
    archivo=nombre;
    %Cargar variable lat (latitud)
    lat=ncread(archivo,'lat');
    %Cargar variable lon (longitud)
    lon=ncread(archivo,'lon');
    %Cargar 
    %adt=ncread(archivo,'adt');
    var=ncread(archivo,variable);
    time=ncread(archivo,'time');
    
    longitude_max=ncreadatt(archivo,'/','longitude_max');
    longitude_min=ncreadatt(archivo,'/','longitude_min');
    latitude_min=ncreadatt(archivo,'/','latitude_min');
    latitude_max=ncreadatt(archivo,'/','latitude_max');
end   