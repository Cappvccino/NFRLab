% Get a list of all .txt files in the current folder
files = dir('X-band Horn * GHz *-*.txt');

if isempty(files)
    disp('No matching files found in the current directory.');
else
    for i = 1:length(files)
        file = files(i).name;
        %fprintf('Processing: %s\n', file);
        
        % --- 1. Extract N, M1, and M2 using Regular Expressions ---  
pattern = '(\d+\.?\d*)\s+GHz\s+([A-Z]-[A-Z])';

tokens = regexp(file, pattern, 'tokens');

if ~isempty(tokens)
    freq_N = tokens{1}{1}; % Result is a string, e.g., '10'
    M = tokens{1}{2};      % Result is a string, e.g., 'V-V'
    %fprintf('Extracted: Freq=%s GHz, Pol=%s\n', freq_N, M);
else
    error('Filename pattern does not match expected format.');
end
   opts = detectImportOptions(file, 'FileType', 'text', 'Delimiter', ',');
   data = readtable(file, opts);

   data.Properties.VariableNames(1) = "ang";
    data.Properties.VariableNames(2) = "ampl";

    ampl = data.ampl;
    ang = data.ang;

[~, max_idx] = max(ampl);
mid_idx = floor(length(ang) / 2);
shift_amount = mid_idx - max_idx;
if contains(file, 'V-V') || contains(file, 'H-H')
            ampl = circshift(ampl, shift_amount);
end
% --- NEW: 3dB (HPBW) CALCULATION ---
        [peak_val, peak_idx] = max(ampl);
        target_3dB = peak_val - 3;
        
        % Find where the curve crosses the -3dB line
        % Logic: Find indices where amplitude is >= target
        idx_above_3dB = find(ampl >= target_3dB);
        
        if ~isempty(idx_above_3dB)
            left_idx = idx_above_3dB(1);
            right_idx = idx_above_3dB(end);
            
            theta_left = ang(left_idx);
            theta_right = ang(right_idx);
            hpbw = abs(theta_right - theta_left);
        else
            hpbw = 0;
        end

fprintf('%s GHz %s\t|\t%.2f dB\t|\t%.2f°\n',freq_N,M,peak_val,hpbw);

fig = figure('Units', 'centimeters', 'Position', [1, 1, 20, 12], 'Color', 'w');

        if strcmp(M, 'V-V')
            plot_title = 'E-síkú Iránykarakterisztika';
        elseif strcmp(M, 'H-H')
            plot_title = 'H-síkú Iránykarakterisztika';
        else
            plot_title = 'Keresztpolarizációs Iránykarakterisztika';
        end    

plot(ang, ampl, 'b', 'LineWidth', 1);
    grid on;
    %grid minor;
    y_min = min(ampl)-10;
    xlim([-180 180]);
    xticks(-180:30:180);
    hold on;
    % Horizontal line spanning the width of the lobe at the -3dB level
    line([theta_left-5, theta_right+5], [target_3dB, target_3dB], ...
        'Color', 'green', 'LineWidth', 1.2, 'LineStyle', '-');
    
    % Vertical dashed lines to mark the boundaries

    line([theta_left, theta_left], [y_min, target_3dB+5], ...
        'Color', 'green', 'LineStyle', ':');
    line([theta_right, theta_right], [y_min, target_3dB+5], ...
        'Color', 'green', 'LineStyle', ':');

    title(plot_title);
    xlabel('Forgatási szög (deg)');
    ylabel('Amplitudó (dB)');
    
    text(0.95, 0.95, sprintf('f = %s GHz', freq_N), 'Units', 'normalized', ...
             'VerticalAlignment', 'top', 'HorizontalAlignment', 'right', ...
             'FontSize', 10, 'FontWeight', 'bold', 'EdgeColor', 'k');



    [~, name, ~] = fileparts(file); 
    export_name = strcat(freq_N,"_GHz_",M,"_Plot.pdf");

    set(gcf);
    set(gcf, 'PaperPositionMode', 'auto');
    exportgraphics(gcf, export_name, 'ContentType', 'vector');
    hold off;
    end
end