%% calculate spring rate k 
    function springRate = calculateSpringRate(d, Do, Na, material)
        %springRate = 0;

        %Do = outer diameter
        D = Do - d; %mean diameter of the spring

        % Use a switch statement to handle different materials 
        switch material
            case 'Music wire A228'
                %Table 10-5 Shigley
                if d < 0.8128 % converted to mm 
                    G = 82.7; %Gpa
                elseif d < 1.6256
                    G = 81.7; %GPa
                elseif d <= 3.175
                    G = 81.0; %GPa
                elseif d > 3.175
                    G = 80.0; %GPa
                end
  
            case 'Hard-drawn wire A227'
                %Table 10-5 Shigley
                if d < 0.8128
                    G = 80.7; %Gpa
                elseif d < 1.6256
                    G = 80.0; %GPa
                elseif d <= 3.175
                    G = 79.3; %GPa
                elseif d > 3.175
                    G = 78.6; %GPa
                end

            case 'Chrome-vanadium wire A232' 
                %Table 10-5 Shigley
                G = 77.2; %GPa

            case 'Chrome-silicon wire A401'
                %Table 10-5 Shigley
                G = 77.2; %GPa

            case '302 stainless wire A313'
                %Table 10-5 Shigley
                G = 69.0; %GPa

            case 'Phosphor-bronze wire B159'
                %Table 10-5 Shigley
                G = 41.4; %GPa
        end

        springRate = (d/1000)^4 * (G*10^9) / (8 * (D/1000)^3 * Na); %k, N/m

    end