% Get a list of all .txt files in the current folder
files = dir('X-band Horn * GHz *-*.txt');

if isempty(files)
    disp('No matching files found in the current directory.');
else
    for i = 1:length(files)
        file = files(i).name;
        fprintf('Processing: %s\n', file);
        
        % --- 1. Extract N, M1, and M2 using Regular Expressions ---  

   opts = detectImportOptions(file, 'FileType', 'text', 'Delimiter', ',');
   data = readtable(file, opts);

   data.Properties.VariableNames(1) = "ang";
    data.Properties.VariableNames(2) = "ampl";

    ampl = data.ampl;
    ang = data.ang;

[~, max_idx] = max(ampl);
mid_idx = floor(length(ang) / 2);
shift_amount = mid_idx - max_idx;
ampl_aligned = circshift(ampl, shift_amount);

fig = figure('Units', 'centimeters', 'Position', [1, 1, 20, 12], 'Color', 'w');

        if strcmp(M, 'V-V')
            plot_title = 'E-síkú Iránykarakterisztika';
        elseif strcmp(M, 'H-H')
            plot_title = 'H-síkú Iránykarakterisztika';
        else
            plot_title = 'Keresztpolarizációs Iránykarakterisztika';
            ampl_aligned = ampl;
        end    

plot(ang, ampl_aligned, 'b', 'LineWidth', 1);
    grid on;
    grid minor;

    title(plot_title);
    xlabel('Forgatási szög (deg)');
    ylabel('Amplitudó (dB)');
    
    text(0.95, 0.95, sprintf('f = %s GHz', freq_N), 'Units', 'normalized', ...
             'VerticalAlignment', 'top', 'HorizontalAlignment', 'right', ...
             'FontSize', 10, 'FontWeight', 'bold', 'EdgeColor', 'k');

    xlim([-180 180]);
    xticks(-180:30:180);

    [~, name, ~] = fileparts(file); 
    export_name = strcat(freq_N," GHz "," ",M,"_Plot.pdf");

    set(gcf);
    set(gcf, 'PaperPositionMode', 'auto');
    exportgraphics(gcf, export_name, 'ContentType', 'vector');
    hold off;
    end
end