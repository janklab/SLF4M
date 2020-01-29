function out = cellrec(x)
%CELLREC Convert to cellrec
%
% Converts the input value to a "cellrec". A cellrec is an n-by-2 cell
% array with names in the first column that represents a list of name/value
% pairs.

if isstruct(x)
    if ~isscalar(x)
        error('Non-scalar structs cannot be converted to cellrec');
    end
    out = [fieldnames(x) struct2cell(x)];
elseif iscell(x)
    if iscellrec(x)
        out = x;
    else
        % Name-value lists can be converted
        if isrow(x) && mod(numel(x), 2) == 0 && iscellstr(x(1:2:end))
            out = reshape(x, [2 numel(x)/2])';
        else
            error('Value is a cell but not a valid cellrec or name-value list');
        end
    end
else
    error('jl:InvalidInput', 'Type ''%s'' cannot be converted to cellrec',...
        class(x));
end

end

function out = iscellrec(x)

if ~iscell(x)
    out = false;
    return;
end
if isequal(size(x), [0 0])
    out = true;
    return;
end

out = size(x,2) == 2 && iscellstr(x(:,1));

end