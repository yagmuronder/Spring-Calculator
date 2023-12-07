function springCalculatorGUI
    % Create the main figure
    fig = uifigure('Name', 'Spring Calculator', 'Position', [400, 360, 400, 400]); % left, bottom, width, height

    % Create UI components

    % END TYPE
    endTypeLabel = uilabel(fig, 'Text', 'End Type:', 'Position', [20, 330, 80, 22]);
    endTypeDropDown = uidropdown(fig, 'Items', {'', 'Plain', 'Plain and ground', 'Squared or closed', 'Squared and ground' }, 'Position', [120, 330, 120, 22]);

    % MATERIAL
    materialLabel = uilabel(fig, 'Text', 'Material:', 'Position', [20, 300, 80, 22]);
    materialDropDown = uidropdown(fig, 'Items', {'', 'Music wire A228', 'Hard-drawn wire A227', 'Chrome-vanadium wire A232', 'Chrome-silicon wire A401', '302 stainless wire A313', 'Phosphor-bronze wire B159'}, 'Position', [120, 300, 200, 22]);

    % Units Dropdown
    unitsLabel = uilabel(fig, 'Text', 'Units:', 'Position', [20, 270, 50, 22]);
    unitsDropDown = uidropdown(fig, 'Items', {'Metric', 'English'}, 'Position', [80, 270, 80, 22]);

    % WIRE DIAMETER
    wireDiameterLabel = uilabel(fig, 'Text', 'Wire Diameter (mm/in):', 'Position', [20, 240, 150, 22]);
    wireDiameterEdit = uieditfield(fig, 'numeric', 'Position', [180, 240, 70, 22]);

    % OUTER DIAMETER
    outerDiameterLabel = uilabel(fig, 'Text', 'Outer Diameter (mm/in):', 'Position', [20, 210, 150, 22]);
    outerDiameterEdit = uieditfield(fig, 'numeric', 'Position', [180, 210, 70, 22]);

    % FREE LENGTH 
    freeLengthLabel = uilabel(fig, 'Text', 'Free Length (mm/in):', 'Position', [20, 180, 120, 22]);
    freeLengthEdit = uieditfield(fig, 'numeric', 'Position', [150, 180, 70, 22]);

    % SOLID LENGTH 
    solidLengthLabel = uilabel(fig, 'Text', 'Solid Length (mm/in):', 'Position', [20, 150, 120, 22]);
    solidLengthEdit = uieditfield(fig, 'numeric', 'Position', [150, 150, 70, 22]);

    % Input Fmin and Fmax
    fMinLabel = uilabel(fig, 'Text', 'Fmin [N/lbf] (write 0 if static load is applied):', 'Position', [20, 120, 250, 22]);
    fMaxLabel = uilabel(fig, 'Text', 'Fmax [N/lbf]:', 'Position', [20, 90, 120, 22]);
    fMinEdit = uieditfield(fig, 'numeric', 'Position', [250, 120, 70, 22]);
    fMaxEdit = uieditfield(fig, 'numeric', 'Position', [150, 90, 70, 22]);

    % Peening Status
    peeningStatusLabel = uilabel(fig, 'Text', 'Peening Status:', 'Position', [20, 60, 120, 22]);
    peeningStatusDropDown = uidropdown(fig, 'Items', {'', 'Peened', 'Unpeened'}, 'Position', [150, 60, 100, 22]);

    calculateButton = uibutton(fig, 'push', 'Text', 'Calculate', 'Position', [250, 20, 100, 40], ...
        'ButtonPushedFcn', @(btn, event) calculateSpring(...
        endTypeDropDown.Value, materialDropDown.Value, unitsDropDown.Value, wireDiameterEdit.Value, ...
        outerDiameterEdit.Value, freeLengthEdit.Value, solidLengthEdit.Value, ...
        fMinEdit.Value, fMaxEdit.Value, peeningStatusDropDown.Value));
end