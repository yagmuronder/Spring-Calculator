function springCalculatorGUI
    %% Create the main figure
    fig = uifigure('Name', 'Spring Calculator', 'Position', [400, 300, 400, 275]);
    %100, 100, 600, 400 - left, bottom, width, height

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

        % Call other functions to calculate and display results
        totalCoils = calculateTotalCoils(endType, wireDiameter, solidLength);
        activeCoils = calculateActiveCoils(endType, totalCoils);
        pitch = calculatePitch(totalCoils, freeLength, wireDiameter, endType);

        % Display the results in a new figure
        displayResultsFigure(totalCoils, activeCoils, pitch);
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
    function activeCoils = calculateActiveCoils(endType, Na)
            % Default value, in case the end type is not recognized
            activeCoils = 0;
        
            % Use a switch statement to handle different end types
            switch endType
                case 'Plain' 
                    activeCoils = Na;
                    
                case 'Plain and ground'
                    activeCoils = Na - 1;
    
                case 'Squared or closed' 
                    activeCoils = Na - 2; 

                case 'Squared and ground'
                    activeCoils = Na - 2; 
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

 %% Display the results in a new figure
    function displayResultsFigure(totalCoils, activeCoils, pitch)
        % Create a new figure
        resultsFig = uifigure('Name', 'Spring Results', 'Position', [600, 300, 300, 150]);
        clf(resultsFig);

        % Create uicontrols to display the results
        uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 100, 250, 20], 'String', ['Total Coils (Nt): ' num2str(totalCoils)]);
        uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 70, 250, 20], 'String', ['Active Coils (Na): ' num2str(activeCoils)]);
        uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 40, 250, 20], 'String', ['Pitch (p): ' num2str(pitch)]);
    end
end