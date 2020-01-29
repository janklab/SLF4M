function fprintfds(varargin)
%FPRINTFDS A fprintf that respects dispstr()
%
% out = fprintfds(fmt, varargin)
% out = fprintfds(fid, fmt, varargin)
%
% This is a variant of fprintf that respects the dispstr() function.
% See the documentation for SPRINTFDS for details on how it works.
% 
% Examples:
%
% bday = Birthday(3, 14);
% fprintfds('The value is: %s', bday)
%
% See also:
% SPRINTFDS

args = varargin;
if isnumeric(args{1})
  fid = args{1};
  args(1) = [];
else
  fid = [];
end

fmt = args{1};
args(1) = [];

str = sprintfds(fmt, args{:});

if isempty(fid)
  fprintf('%s', str);
else
  fprintf(fid, '%s', str);
end

end