%% calculate total coils - Shigley Table 10-1
    function totalCoils = calculateTotalCoils(endType, d, Ls)
        % Default value, in case the end type is not recognized
        totalCoils = 0;
    
        % Use a switch statement to handle different end types
        switch endType
            case 'Plain'
                totalCoils = Ls / d - 1;

            case 'Squared or closed'
                totalCoils = Ls / d - 1;
                
            case 'Plain and ground'
                totalCoils = Ls / d;

            case 'Squared and ground'
                totalCoils = Ls / d;
        end
    end