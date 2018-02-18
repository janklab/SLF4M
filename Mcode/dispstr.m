function out = dispstr(x)
%DISPSTR Display string for data
%
% out = dispstr(x)
%
% DISPSTR returns a one-line string representing the input value, in a format
% suitable for inclusion into multi-element output. This is a generic formatting
% function, equivalent to Java's `toString()` method. It can take input of any
% type.
%
% DISPSTRS is intended to be overridden by user-defined objects in order to
% customize their display output. It must return a string as char vector, and that string
% should be a single line.
%
% See also: DISPSTRS

if ~ismatrix(x)
    out = sprintf('%s %s', size2str(size(x)), class(x));
elseif isempty(x)
    if ischar(x) && isequal(size(x), [0 0])
        out = '''''';
    elseif isnumeric(x) && isequal(size(x), [0 0])
        out = '[]';
    else
        out = sprintf('Empty %s %s', size2str(size(x)), class(x));
    end
elseif isnumeric(x)
    if isscalar(x)
        out = num2str(x);
    else
        strs = strtrim(cellstr(num2str(x(:))));
        out = formatArrayOfStrings(strs);
    end
elseif ischar(x)
    if isrow(x)
        out = ['''' x ''''];
    else
        strs = strcat({''''}, num2cell(x,2), {''''});
        out = formatArrayOfStrings(strs);
    end
elseif iscell(x)
    if iscellstr(x)
        strs = strcat('''', x, '''');
    else
        strs = cellfun(@dispstr, x, 'UniformOutput',false);
    end
    out = formatArrayOfStrings(strs, {'{','}'});
elseif isstring(x)
    strs = strcat('"', cellstr(x), '"');
    out = formatArrayOfStrings(strs, {'[',']'});
else
    out = sprintf('%s %s', size2str(size(x)), class(x));
end

end

function out = formatArrayOfStrings(strs, brackets)
if nargin < 2 || isempty(brackets);  brackets = { '[' ']' }; end
rowStrs = cell(size(strs,1), 1);
for iRow = 1:size(strs,1)
    rowStrs{iRow} = strjoin(strs(iRow,:), ' ');
end
out = [brackets{1} strjoin(rowStrs, '; ') brackets{2}];
end

function out = size2str(sz)
%SIZE2STR Format a matrix size for display
%
% out = size2str(sz)
%
% Sz is an array of dimension sizes, in the format returned by SIZE.

strs = cell(size(sz));
for i = 1:numel(sz)
	strs{i} = sprintf('%d', sz(i));
end

out = strjoin(strs, '-by-');
end
