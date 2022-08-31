function respuesta = sensado(renglon,columna,matriz)

    respuesta=0;
try
    if( isnan( matriz(renglon,columna)) == 0) 
        respuesta=matriz(renglon,columna); %Es dato valido
    else
        respuesta = -2000; %Es NAN
    end    
catch
    respuesta=-1000; % Es frontera
end


 
end % function 