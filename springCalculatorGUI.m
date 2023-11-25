function springCalculatorGUI
    % Create the main figure
    fig = uifigure('Name', 'Spring Calculator', 'Position', [100, 100, 400, 300]);

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
    end

end