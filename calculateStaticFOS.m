%% calculate factor of safety - STATIC

    function fos_static = calculateStaticFOS(material, d, F, D)
        % Use a switch statement to handle different materials 
        switch material
            case 'Music wire A228'
                %Table 10-4 Shigley
                A = 2211; %MPa * mm^m
                m = 0.145; %exponent
                elasticpercent = .45;
                
            case 'Hard-drawn wire A227'
                %Table 10-4 Shigley
                A = 1783; %MPa * mm^m
                m = 0.190; %exponent
                elasticpercent = .45;

            case 'Chrome-vanadium wire A232' 
                %Table 10-4 Shigley
                A = 2005; %MPa * mm^m
                m = 0.168; %exponent
                elasticpercent = .65;

            case 'Chrome-silicon wire A401'
                %Table 10-4 Shigley
                A = 1974; %MPa * mm^m
                m = 0.108; %exponent
                elasticpercent = .65;

            case '302 stainless wire A313'
                %Table 10-4 Shigley
                if d < 2.5
                    A = 1867;
                    m = 0.146;                    
                elseif d < 5
                    A = 2065;
                    m = 0.263;                 
                elseif d <= 10
                    A = 2911;
                    m = 0.478;
                end
                elasticpercent = .45;

            case 'Phosphor-bronze wire B159'
                %Table 10-4 Shigley
                if d < 0.6
                    A = 1000;
                    m = 0;
                elseif d < 2
                    A = 913;
                    m = 0.028;
                elseif d <= 7.5
                    A = 932;
                    m = 0.064;
                end
                elasticpercent = .45;
        end

        S_ut = A / (d^m);
        S_sy = elasticpercent*S_ut; 
        tao = 8*F*D/(pi*d^3) + 4*F/(pi*d^2);
        fos_static = S_sy / tao;
    end