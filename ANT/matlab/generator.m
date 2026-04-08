fig = figure('Units', 'centimeters', 'Position', [1, 1, 20, 12], 'Color', 'w');

opts = detectImportOptions('File_101.s1p', 'FileType', 'text', 'Delimiter', '\t');
data = readtable('File_101.s1p', opts);
opts = detectImportOptions('File_100.s1p', 'FileType', 'text', 'Delimiter', '\t');
data_cal = readtable('File_100.s1p', opts);
data.Properties.VariableNames(1) = "freq";
data.Properties.VariableNames(2) = "ampl";
data.Properties.VariableNames(3) = "phase";
data_cal.Properties.VariableNames(1) = "freq";
data_cal.Properties.VariableNames(2) = "ampl";
data_cal.Properties.VariableNames(3) = "phase";


calibrated_ampl = data.ampl - data_cal.ampl;
calibrated_phase = data.phase - data_cal.phase;
freq = data.freq/1e9;
phase_uw = rad2deg(unwrap(deg2rad(calibrated_phase)));

semilogx(freq, ampl, 'black', 'LineWidth', 1.5);
grid on; grid minor;
ylabel('Teljesítmény |S_{21}| (dB)');
xlabel('Frekvencia (GHz)');

%subplot(2, 1, 2);
%semilogx(freq, phase_uw, 'r', 'LineWidth', 1.5);
%axis tight;
%xlabel('Frekvencia (GHz)');
%ylabel('Fázistolás (deg)');

set(gcf);
set(gcf, 'PaperPositionMode', 'auto');
exportgraphics(gcf, 'Antenna_Phase_Plot.pdf', 'ContentType', 'vector');