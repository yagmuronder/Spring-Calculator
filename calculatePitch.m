  %% calculate pitch - Shigley Table 10-1
    function pitch = calculatePitch(Na, L0, d, endType)
        % Default value, in case the end type is not recognized
        pitch = 0;
    
        % Use a switch statement to handle different end types
        switch endType
            case 'Plain' 
                pitch = (L0-d)/Na;
                
            case 'Plain and ground'
                pitch = L0/(Na+1);

            case 'Squared or closed' 
                pitch = (L0 - 3*d)/Na;    

            case 'Squared and ground'
                pitch = (L0 - 2*d)/Na; 
        end
    end