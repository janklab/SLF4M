function out = prettyprint_tabular(t)
%PRETTYPRINT_TABULAR Tabular implementation of prettyprint

%TODO: Probably put quotes around strings

varNames = t.Properties.VariableNames;
nVars = numel(varNames);
if nVars == 0
    out = sprintf('%s table with zero variables', dispstrlib.internal.size2str(size(t)));
    return;
end
varVals = cell(1, nVars);

for i = 1:nVars
    varVals{i} = t{:,i};
end

out = prettyprint_tabular_generic(varNames, varVals);

end

function out = prettyprint_tabular_generic(varNames, varVals)
% A generic tabular pretty-print that can be used for tabulars or relations

nVars = numel(varNames);
nRows = numel(varVals{1});

varStrs = cell(1, nVars);
varStrWidths = NaN(1, nVars);
for i = 1:nVars
    varStrs{i} = dispstrs(varVals{i});
    varStrWidths(i) = max(cellfun('length', varStrs{i}));
end
varNameWidths = cellfun('length', varNames);
colWidths = max([varNameWidths; varStrWidths]);

lines = cell(1, nRows+2);

headerFormat = ['    ' strjoin(repmat({'%-*s'}, [1 nVars]), '   ')];
rowVals = rowData2sprintfArgs(colWidths, varNames);
lines{1} = sprintf(headerFormat, rowVals{:});

colFormats = cell(1, nVars);
for i = 1:nVars
    if isnumeric(varVals{i})
        colFormats{i} = '%*s';
    else
        colFormats{i} = '%-*s';
    end
end
rowFormat = ['    ' strjoin(colFormats, '   ')];

underlines = arrayfun(@(n) repmat('_', [1 n]), colWidths, 'UniformOutput',false);
rowVals = rowData2sprintfArgs(colWidths, underlines);
lines{2} = sprintf(rowFormat, rowVals{:});

varStrs = cat(2, varStrs{:});
for i = 1:nRows
    rowVals = rowData2sprintfArgs(colWidths, varStrs(i,:));
    lines{i+2} = sprintf(rowFormat, rowVals{:});
end

out = strjoin(lines, newline);

end

function out = rowData2sprintfArgs(widths, strs)
x = [num2cell(widths(:)) strs(:)];
x = x';
out = x(:);
end