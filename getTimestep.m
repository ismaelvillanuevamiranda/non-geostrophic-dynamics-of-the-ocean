function timestep = getTimestep(fecha,time)
    n = size(time);    
    timestep = 0;
    for i=1:n(:,1)
        date = datestr(time(i)+datenum('1950-01-01 00:00:00'),'dd-mmm-yyyy');
        if(strcmp(fecha,date) == 1)
            timestep = i;
            break;
        end
    end
end