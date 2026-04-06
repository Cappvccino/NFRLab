fig = figure('Units', 'centimeters', 'Position', [1, 1, 20, 12], 'Color', 'w');

opts = detectImportOptions('File_101.s1p', 'FileType', 'text', 'Delimiter', '\t');
data = readtable('File_101.s1p', opts);
data.Properties.VariableNames(1) = "freq";
data.Properties.VariableNames(2) = "ampl";
data.Properties.VariableNames(3) = "phase";

freq = data.freq/1e9;
ampl = data.ampl;
phase_deg = data.phase;
phase_uw = rad2deg(unwrap(deg2rad(phase_deg)));

semilogx(freq, ampl, 'black', 'LineWidth', 1.5);
grid on; grid minor;
ylabel('Amplitúdó |S_{21}| (dB)');
xlabel('Frekvencia (GHz)');

%subplot(2, 1, 2);
%semilogx(freq, phase_uw, 'r', 'LineWidth', 1.5);
%axis tight;
%xlabel('Frekvencia (GHz)');
%ylabel('Fázistolás (deg)');

set(gcf);
set(gcf, 'PaperPositionMode', 'auto');
exportgraphics(gcf, 'Antenna_Phase_Plot_101.pdf', 'ContentType', 'vector');