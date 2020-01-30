function warningds(varargin)
% warningds A variant of warning() that supports dispstr functionality
%
% warningds(fmt, varargin)
% warningds(id, fmt, varargin)
%
% This is just like Matlab's warning(), except you can pass objects
% directly to '%s' conversion specifiers, and they will be automatically
% converted using dispstr.

args = dispstrlib.internal.convertArgsForPrintf(varargin);
warning(args{:});

end