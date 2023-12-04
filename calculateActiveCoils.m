%% calculate active coils - Shigley Table 10-1
    function activeCoils = calculateActiveCoils(endType, Nt)
            % Default value, in case the end type is not recognized
            activeCoils = 0;
        
            % Use a switch statement to handle different end types
            switch endType
                case 'Plain' 
                    activeCoils = Nt;
                    
                case 'Plain and ground'
                    activeCoils = Nt - 1;
    
                case 'Squared or closed' 
                    activeCoils = Nt - 2; 

                case 'Squared and ground'
                    activeCoils = Nt - 2; 
            end
    end