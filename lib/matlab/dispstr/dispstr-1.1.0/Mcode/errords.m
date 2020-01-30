function errords(varargin)
% errords A variant of error() that supports dispstr functionality
%
% errords(fmt, varargin)
% errords(errorId, fmt, varargin)
%
% This is just like Matlab's error(), except you can pass objects
% directly to '%s' conversion specifiers, and they will be automatically
% converted using dispstr.

args = dispstrlib.internal.convertArgsForPrintf(varargin);

if dispstrlib.internal.isErrorIdentifier(args{1})
  id = args{1};
  args = args(2:end);
else
  id = '';
end

err = MException(id, args{:});
throwAsCaller(err);

end