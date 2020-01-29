function out = prettyprint_array(strs)
%PRETTYPRINT_ARRAY Pretty-print an array from dispstrs
%
% out = prettyprint_array(strs)
%
% strs (cellstr) is an array of display strings of any size.

if ismatrix(strs)
    out = prettyprint_matrix(strs);
else
    sz = size(strs);
    high_sz = sz(3:end);
    high_ixs = {};
    for i = 1:numel(high_sz)
        high_ixs{i} = [1:high_sz(i)]';
    end
    page_ixs = dispstrlib.internal.mycombvec(high_ixs);
    chunks = {};
    for i_page = 1:size(page_ixs, 1)
        page_ix = page_ixs(i_page,:);
        chunks{end+1} = sprintf('(:,:,%s) = ', ...
            strjoin(dispstrlib.internal.num2cellstr(page_ix), ':')); %#ok<*AGROW>
        page_ix_cell = num2cell(page_ix);
        page_strs = strs(:,:,page_ix_cell{:});
        chunks{end+1} = prettyprint_matrix(page_strs);
    end
    out = strjoin(chunks, '\n');
end
if nargout == 0
    disp(out);
    clear out;
end
end

function out = prettyprint_matrix(strs)
if ~ismatrix(strs)
    error('Input must be matrix; got %d-D', ndims(strs));
end
lens = cellfun('prodofsize', strs);
widths = max(lens);
formats = dispstrlib.internal.sprintfv('%%%ds', widths);
format = strjoin(formats, '   ');
lines = cell(size(strs,1), 1);
for i = 1:size(strs, 1)
    lines{i} = sprintf(format, strs{i,:});
end
out = strjoin(lines, '\n');
end