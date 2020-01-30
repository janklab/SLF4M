function out = sprintfv(format, varargin)
%SPRINTFV "Vectorized" sprintf
%
% out = sprintfv(format, varargin)
%
% SPRINTFV is an array-oriented form of sprintf that applies a format to array
% inputs and produces a cellstr.
%
% This is not a high-performance method. It's a convenience wrapper around a
% loop around sprintf().
%
% Returns cellstr.

args = varargin;
sz = [];
for i = 1:numel(args)
    if ischar(args{i})
        args{i} = { args{i} };  %#ok<CCAT1>
    end
    if ~isscalar(args{i})
        if isempty(sz)
            sz = size(args{i});
        else
            if ~isequal(sz, size(args{i}))
                error('Inconsistent dimensions in inputs');
            end
        end
    end
end
if isempty(sz)
    sz = [1 1];
end

out = cell(sz);
for i = 1:numel(out)
    theseArgs = cell(size(args));
    for iArg = 1:numel(args)
        if isscalar(args{iArg})
            ix_i = 1;
        else
            ix_i = i;
        end
        if iscell(args{iArg})
            theseArgs{iArg} = args{iArg}{ix_i};
        else
            theseArgs{iArg} = args{iArg}(ix_i);
        end
    end
    out{i} = sprintf(format, theseArgs{:});
end