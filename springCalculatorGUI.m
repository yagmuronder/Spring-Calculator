function springCalculatorGUI
    %% Create the main figure
    fig = uifigure('Name', 'Spring Calculator', 'Position', [400, 300, 400, 275]); %left, bottom, width, height

    % Create UI components
    % END TYPE
    endTypeLabel = uilabel(fig, 'Text', 'End Type:', 'Position', [20, 240, 100, 22]);
    endTypeDropDown = uidropdown(fig, 'Items', {'', 'Plain', 'Plain and ground', 'Squared or closed', 'Squared and ground' }, 'Position', [120, 240, 100, 22]);

    % MATERIAL
    materialLabel = uilabel(fig, 'Text', 'Material:', 'Position', [20, 200, 100, 22]);
    materialDropDown = uidropdown(fig, 'Items', {'', 'Music wire A228', 'Hard-drawn wire A227', 'Chrome-vanadium wire A232', 'Chrome-silicon wire A401', '302 stainless wire A313', 'Phosphor-bronze wire B159'}, 'Position', [120, 200, 100, 22]);

    % WIRE DIAMETER
    wireDiameterLabel = uilabel(fig, 'Text', 'Wire Diameter (mm):', 'Position', [20, 160, 120, 22]);
    wireDiameterEdit = uieditfield(fig, 'numeric', 'Position', [150, 160, 70, 22]);

    % OUTER DIAMETER
    outerDiameterLabel = uilabel(fig, 'Text', 'Outer Diameter (mm):', 'Position', [20, 120, 120, 22]);
    outerDiameterEdit = uieditfield(fig, 'numeric', 'Position', [150, 120, 70, 22]);

    % FREE LENGTH 
    freeLengthLabel = uilabel(fig, 'Text', 'Free Length (mm):', 'Position', [20, 80, 120, 22]);
    freeLengthEdit = uieditfield(fig, 'numeric', 'Position', [150, 80, 70, 22]);

    % SOLID LENGTH 
    solidLengthLabel = uilabel(fig, 'Text', 'Solid Length (mm):', 'Position', [20, 40, 120, 22]);
    solidLengthEdit = uieditfield(fig, 'numeric', 'Position', [150, 40, 70, 22]);

    calculateButton = uibutton(fig, 'push', 'Text', 'Calculate', 'Position', [250, 40, 100, 40], 'ButtonPushedFcn', @(btn,event) calculateSpring(endTypeDropDown.Value, materialDropDown.Value, wireDiameterEdit.Value, outerDiameterEdit.Value, freeLengthEdit.Value, solidLengthEdit.Value));

    %% calculate spring properties 
    % Callback function to calculate spring properties
    function calculateSpring(endType, material, wireDiameter, outerDiameter, freeLength, solidLength)
    
        % Check if end type and material are selected
        if isempty(endType) && isempty(material)
            errordlg('Please select End Type and Material', 'Error', 'modal');
            return;  % Exit the function if not selected
        elseif isempty(endType)
            errordlg('Please select End Type', 'Error', 'modal');
            return;  % Exit the function if not selected
        elseif isempty(material)
            errordlg('Please select Material', 'Error', 'modal');
            return;  % Exit the function if not selected
        end

         % Verification check for numeric values
    if ~isnumeric(wireDiameter) || ~isnumeric(outerDiameter) || ~isnumeric(freeLength) || ~isnumeric(solidLength)
        errordlg('Please enter numeric values for diameters and lengths', 'Error', 'modal');
        return;
    end

    % Wire diameter verification
    if wireDiameter < 0 
        errordlg('Invalid wire diameter. Please enter a positive value.', 'Error', 'modal');
        return;
    elseif wireDiameter == 0
        errordlg('Invalid wire diameter. Please enter a positive, non-zero value.', 'Error', 'modal');
        return;
    end

    % Outer diameter verification
    if outerDiameter < 0 
        errordlg('Invalid outer diameter. Please enter a positive value.', 'Error', 'modal');
        return;
    elseif outerDiameter == 0
        errordlg('Invalid outer diameter. Please enter a positive, non-zero value.', 'Error', 'modal');
        return;
    end

    % Free length verification
    if freeLength <= solidLength || freeLength < 0
        errordlg('Invalid Free Length. Please enter a positive value greater than Solid Length.', 'Error', 'modal');
        return;
    elseif freeLength == 0
        errordlg('Invalid Free Length. Please enter a non-zero, positive value greater than Solid Length', 'Error', 'modal');
        return;
    end

    % Solid length verification
    if solidLength < 0
        errordlg('Invalid Solid Length. Please enter a positive value.', 'Error', 'modal');
        return;
    elseif solidLength == 0
        errordlg('Invalid Solid Length. Please enter a non-zero, positive value.', 'Error', 'modal');
        return;
    end

        % Call other functions to calculate and display results
        %use round to ensure the outcome is an integer 
        totalCoils = round(calculateTotalCoils(endType, wireDiameter, solidLength));
        activeCoils = round(calculateActiveCoils(endType, totalCoils));
        pitch = calculatePitch(activeCoils, freeLength, wireDiameter, endType);
        springRate = calculateSpringRate(wireDiameter, outerDiameter, activeCoils, material);
        force = calculateForce(freeLength, solidLength, springRate);

        % Display the results in a new figure
        displayResultsFigure(totalCoils, activeCoils, pitch, springRate, force);
    end

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

%% calculate spring rate k 
    function springRate = calculateSpringRate(d, Do, Na, material)
        springRate = 0;

        %Do = outer diameter
        D = Do - d; %mean diameter of the spring

        % Use a switch statement to handle different materials 
        switch material
            case 'Music wire A228'
                %Table 10-5 Shigley
                if d < 0.8128
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

        springRate = d^4 * G / (8 * D^3 * Na); %k

    end

%% calculate force - The force needed to compress the spring to its solid length 
    function force = calculateForce(L0, Ls, k)
        force = k * (L0 - Ls); %F=kx
    end
%% calculate factor of safety 
% UNCOMPLETED 
%FROM PDF: 
% the factor of safety for static yielding when the spring is compressed to solid length
% For a static load, the Spring Calculator should find the factor of safety.
% For a cyclic load (i.e., Fmax and Fmin), the Spring Calculator should find the factor of safety for infinite life.
% but are we given a cyclic load? we only know the static load from the force needed to compress the spring to its solid length 

 %% Display the results in a new figure
    function displayResultsFigure(totalCoils, activeCoils, pitch, springRate, force)
        % Create a new figure
        resultsFig = uifigure('Name', 'Spring Results', 'Position', [600, 300, 800, 150]);
        clf(resultsFig);

        % Create uicontrols to display the results
        uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 130, 700, 20], 'String', ['Total Coils, Nt: ' num2str(totalCoils)]);
        uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 100, 700, 20], 'String', ['Active Coils, Na: ' num2str(activeCoils)]);
        uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 70, 700, 20], 'String', ['Pitch, p [mm]: ' num2str(pitch)]);
        uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 40, 700, 20], 'String', ['Spring Rate, k [N/m]: ' num2str(springRate)]); %check units in the function 
        uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 10, 700, 20], 'String', ['Force needed to compress spring to solid length, F [N/m]: ' num2str(force)]); %check units in the function 
    end
end