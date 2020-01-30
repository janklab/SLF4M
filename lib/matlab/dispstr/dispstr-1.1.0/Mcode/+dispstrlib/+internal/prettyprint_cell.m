function out = prettyprint_cell(c)
%PRETTYPRINT_CELL Cell implementation of prettyprint

%TODO: Maybe justify each cell independently based on its content type

strs = cellfun(@dispstr, c, 'UniformOutput',false);
colWidths = NaN(1, size(c,2));
colFormats = cell(1, size(c,2));
for i = 1:size(c, 2)
    colWidths(i) = max(cellfun('length', strs(:,i)));
    colFormats{i} = ['{ %' num2str(colWidths(i)) 's }'];
end

rowFormat = ['  ' strjoin(colFormats, '   ')];
lines = cell(1, size(c,1));
for i = 1:size(c, 1)
    lines{i} = sprintf(rowFormat, strs{i,:});
end

out = strjoin(lines, newline);

end