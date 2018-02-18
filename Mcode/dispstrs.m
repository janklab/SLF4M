function out = dispstrs(x)
%DISPSTRS Display strings for array elements
%
% out = dispstrs(x)
%
% DISPSTRS returns a cellstr array containing display strings that represent the
% values in the elements of x. These strings are concise, single-line strings
% suitable for incorporation into multi-element output. If x is a cell, each
% element cell's contents are displayed, instead of each cell.
%
% This is used for constructing display output for functions like DISP.
% User-defined objects are expected to override DISPSTRS to produce suitable,
% readable output.
%
% The output is human-consumable text. It does not have to be fully precise, and
% does not have to be parseable back to the original input. Full type
% information will not be inferrable from DISPSTRS output. The primary audience
% for DISPSTRS output is Matlab programmers and advanced users.
%
% Returns a cellstr the same size as x.
%
% DISPSTRS is intended to be overridden by user-defined objects in order to
% customize their display output. It must return a cellstr of the same size as
% its input.
%
% Examples:
%
% % Contrast the output of dispstr and dispstrs
% dispstr(1:5)
% dispstrs(1:5)
%
% See also: DISPSTR

if isempty(x)
	out = reshape({}, size(x));
elseif isnumeric(x)
	out = dispstrsNumeric(x);
elseif iscellstr(x)
	out = x;
elseif isstring(x)
    out = cellstr(x);
elseif iscell(x)
	out = dispstrsGenericDisp(x);
elseif ischar(x)
	% An unfortunate consequence of the typical use of char and dispstrs' contract
	out = num2cell(x);
elseif isa(x, 'datetime')
	out = reshape(cellstr(datestr(x)), size(x));
elseif isa(x, 'struct')
	out = repmat({'1-by-1 struct'}, size(x));
else
	out = dispstrsGenericDisp(x);
end

end

function out = dispstrsNumeric(x)
out = reshape(strtrim(cellstr(num2str(x(:)))), size(x));
end

function out = dispstrsGenericDisp(x)
out = cell(size(x));
for i = 1:numel(x)
	if iscell(x)
		xi = x{i}; %#ok<NASGU>
	else
		xi = x(i); %#ok<NASGU>
	end
	str = evalc('disp(xi)');
	str(end) = []; % chomp newline
	out{i} = str;
end
end

