%% calculate force - The force needed to compress the spring to its solid length 
    function force = calculateForce(L0, Ls, k)
        force = k * ((L0 - Ls)/1000); %F=kx, newtons
    end