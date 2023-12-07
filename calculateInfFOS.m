%% FOS inf life

    function fos_inf = calculateInfFOS(Fmin, Fmax, D, d, peenedStatus, material)
        Fa = (Fmax-Fmin)/2;
        Fm = (Fmax+Fmin)/2;

        switch material
            case 'Music wire A228'
                %Table 10-4 Shigley
                A = 2211; %MPa * mm^m
                m = 0.145; %exponent
                
            case 'Hard-drawn wire A227'
                %Table 10-4 Shigley
                A = 1783; %MPa * mm^m
                m = 0.190; %exponent

            case 'Chrome-vanadium wire A232' 
                %Table 10-4 Shigley
                A = 2005; %MPa * mm^m
                m = 0.168; %exponent

            case 'Chrome-silicon wire A401'
                %Table 10-4 Shigley
                A = 1974; %MPa * mm^m
                m = 0.108; %exponent

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
        end
        C = D / d;
        Kb = (4*C + 2)/(4*C - 3);
        tao_a = Kb * (8*Fa*D)/(pi*d^3);
        tao_m = Kb * (8*Fm*D)/(pi*d^3);
        S_ut = A / (d^m);
        S_su = 0.67*S_ut;
        %add S_se based on peened or unpeened 
        switch peenedStatus 
            case 'Peened'
                S_sa = 398; %MPa
                S_sm = 534; % MPa

            case 'Unpeened'
                S_sa = 241; %MPa
                S_sm = 379; % MPa

        end

        S_se = S_sa / (1 - S_sm/S_su);
        
        middleStep = (tao_a / S_se + tao_m / S_su);
        fos_inf = 1/middleStep;

        %fos_inf = (tao_a / S_se + tao_m / S_su)^(-1);
        
        
    end