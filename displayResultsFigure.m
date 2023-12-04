 %% Display the results in a new figure
 function displayResultsFigure(totalCoils, activeCoils, pitch, springRate, force, fMin, fos, force_FOS, units)
    % Create a new figure
    resultsFig = uifigure('Name', 'Spring Results', 'Position', [600, 300, 800, 150]);

    % Create uicontrols to display the results
    uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 120, 300, 20], 'String', ['Total Coils, Nt: ' num2str(totalCoils)]);
    uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 90, 300, 20], 'String', ['Active Coils, Na: ' num2str(activeCoils)]);

        % Check if the units are in English and perform conversions if needed
    if strcmp(units, 'English')
        convertToEnglish_length = @(value) value / 25.4;  % from m to inches
        convertToEnglish_springRate = @(value) value * 0.00571; % from N/m to lbf/in
        convertToEnglish_force = @(value) value * 0.224809; %from newtons to pound force 
        
        % Convert results to English units (replace with your conversion logic)
        pitch = convertToEnglish_length(pitch);
        springRate = convertToEnglish_springRate(springRate);
        force = convertToEnglish_force(force);

        uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 60, 300, 20], 'String', ['Pitch, p [in]: ' sprintf('%.4f', pitch)]);
        uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 30, 300, 20], 'String', ['Spring Rate, k [lbf/in]: ' sprintf('%.3f', springRate)]);
        uicontrol(resultsFig, 'Style', 'text', 'Position', [400, 120, 400, 20], 'String', ['Force needed to compress spring, F [lbf]: ' sprintf('%.3f', force)]);
    else 
        uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 60, 300, 20], 'String', ['Pitch, p [mm]: ' sprintf('%.4f', pitch)]);
        uicontrol(resultsFig, 'Style', 'text', 'Position', [20, 30, 300, 20], 'String', ['Spring Rate, k [N/m]: ' sprintf('%.3f', springRate)]);
        uicontrol(resultsFig, 'Style', 'text', 'Position', [400, 120, 400, 20], 'String', ['Force needed to compress spring, F [N]: ' sprintf('%.3f', force)]);
    end

    
    uicontrol(resultsFig, 'Style', 'text', 'Position', [400, 90, 400, 20], 'String', ['Associated FOS with Force needed to compress spring: ' sprintf('%.1f', force_FOS)]);
    
    % Display Factor of Safety with one decimal place
    if fMin == 0
        uicontrol(resultsFig, 'Style', 'text', 'Position', [400, 60, 400, 20], 'String', ['Factor of Safety (static): ' sprintf('%.1f', fos)]);
    else
        uicontrol(resultsFig, 'Style', 'text', 'Position', [400, 60, 400, 20], 'String', ['Factor of Safety (inf life): ' sprintf('%.1f', fos)]);
    end
    

end