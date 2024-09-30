
%
% file i/o
%
close all;
clear all;
%
% Part B) Process Imported Data - final_scores_example.xlsm
%
% - right click on final_scores_example.xlsm and select Import Data
% - with your mouse select all rows and columns of data
% - then go to Output Type and select Numeric Matrix
% - lastly, click on Import Selection button
% - then in Workspace click on finalscoresexample matrix to display the data
%
% open in Workspace the matrix finalscoresexample and by hand
% change NaN with the number 0
%
% read file newdatafile.mat
% get size of matrix
%

% Clear previous data and close figures (optional but recommended)
clear all;
close all;
clc;

% Load the data
load newdatafile;

% Verify that 'finalscoresexample' exists
if ~exist('finalscoresexample', 'var')
    error('finalscoresexample variable not found in newdatafile.mat.');
end

% Get size of the matrix
sizefse = size(finalscoresexample);
disp(['Size of finalscoresexample: ', mat2str(sizefse)]);

% [Optional] Display column names for reference
disp('Variable Names in finalscoresexample:');
disp(finalscoresexample.Properties.VariableNames);

% Extract numbers in column 11 as a numeric array
% Option 1: Using numeric indexing
col11 = finalscoresexample{:,11};  % Changed from (:) to {:) to extract data

% Option 2: Using variable name (uncomment and modify if applicable)
% col11 = finalscoresexample.Score;  % Replace 'Score' with actual column name

% Verify that col11 is numeric
if ~isnumeric(col11)
    error('col11 is not numeric. Please ensure that column 11 contains numeric data.');
end

% Replace NaN with 0
col11(isnan(col11)) = 0;

% Display basic statistics
disp(['Number of Students: ', num2str(length(col11))]);
disp(['Minimum Score: ', num2str(min(col11))]);
disp(['Maximum Score: ', num2str(max(col11))]);

[r, c] = size(col11);

% Plot Student Scores
figure(1);
plot(col11, 'rs-', 'MarkerFaceColor', 'b', 'MarkerSize', 8, 'MarkerEdgeColor', 'g');
title('Student Scores');
xlabel('Number of Students');
ylabel('Scores');
axis([0 length(col11)+1 -5 max(col11)*1.2]);  % Added +1 to include last student
grid minor;

% Calculate statistics
meanscores = mean(col11);
var_scores = var(col11);
std_scores = sqrt(var_scores);
meanL = ones(length(col11), 1) * meanscores;

% Histogram of scores using 50 bins
figure(2);
histogram(col11, 50);
title('Histogram of Student Scores');
xlabel('Scores');
ylabel('Number of Students');
grid minor;

% Sort scores in ascending and descending order
[scoresa, indexsa] = sort(col11);
scoresd = scoresa(end:-1:1);
indexsd = indexsa(end:-1:1);

% Display sorted scores
figure(3);
stem(scoresa, 'k-o', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'MarkerEdgeColor', 'g');
title('Student Scores - Ascending Order');
xlabel('Number of Students');
ylabel('Scores');
grid minor;

% Display scores with student numbers and mean line
figure(4);
hold on;
stem(indexsa, scoresa, 'b-o', 'MarkerFaceColor', 'b', 'MarkerSize', 8, 'MarkerEdgeColor', 'g');
plot(meanL, 'r:o', 'LineWidth', 2);
title('Student Scores - Student Number');
xlabel('Student Number');
ylabel('Scores');
axis([0 length(col11)+1 0 max(col11)*1.2]);
grid minor;
hold off;

% Calculate spread from mean
spread_mean = col11 - meanscores;

% Plot spread from mean
figure(5);
hold on;
stem(spread_mean, 'b-o', 'MarkerFaceColor', 'b', 'MarkerSize', 8, 'MarkerEdgeColor', 'g');
title('Student Scores - Spread from Mean');
xlabel('Student Number');
ylabel('Scores from the Mean');
grid minor;
hold off;

% Find minimum and maximum scores and their indices
[maxs, maxi] = max(col11);
[mins, mini] = min(col11);
disp(['Maximum Score: ', num2str(maxs), ' by Student ', num2str(maxi)]);
disp(['Minimum Score: ', num2str(mins), ' by Student ', num2str(mini)]);

% Categorize scores into grades
s90 = find(col11 >= 90);
AS = length(s90);
S90 = (col11 >= 90) .* col11;

s80_90 = find(col11 >= 80 & col11 < 90);
BS = length(s80_90);
S80_90 = (col11 >= 80 & col11 < 90) .* col11;

s70_80 = find(col11 >= 70 & col11 < 80);
CS = length(s70_80);
S70_80 = (col11 >= 70 & col11 < 80) .* col11;

s60_70 = find(col11 >= 60 & col11 < 70);
DS = length(s60_70);
S60 = (col11 >= 60 & col11 < 70) .* col11;

% Display grade counts
disp(['Number of A grades: ', num2str(AS)]);
disp(['Number of B grades: ', num2str(BS)]);
disp(['Number of C grades: ', num2str(CS)]);
disp(['Number of D grades: ', num2str(DS)]);

% Pie chart of final grades
figure(6);
data = [AS BS CS DS];
explode = [1 0 0 0];
labels = {'A', 'B', 'C', 'D'};
pie(data, explode, labels);
title('Final Grades');
legend(labels, 'Location', 'best');

disp('>>> END of arrays_final_scores_9b.m <<<');
