function out = prettyprint(x)
%PRETTYPRINT Formatted output of array contents
%
% out = prettyprint(x)
%
% Displays a formatted, human-readable representation of the contents of a
% value. This is a detailed, multi-line output that typically displays all the
% individual values in an array, or drills down one or more levels into complex
% objects. In many cases, this is just like doing a DISP, but it respects the
% DISPSTR and DISPSTRS methods defined on user-defined objects inside complex
% types, where DISP does not.
%
% This output is for human consumption and its format may change over time. The
% format may also be dependent on settings in the Matlab session, such as
% `format` and the user's locale.
%
% The default PRETTYPRINT implementation has support for Matlab built-in types,
% structs, cells, and tables, and, unlike the default disp() behavior for them,
% respects DISPSTRS defined for values inside structs, cells, and tables.
% 
% The input x may be a value of any type.
%
% If the output is not captured, displays its results to the console. If the
% output is captured, returns its results as char.
%
% The intention is for user-defined classes to override this method, providing
% customized display of their values.
%

if isstruct(x)
    out = dispstrlib.internal.prettyprint_struct(x);
elseif iscell(x)
    out = dispstrlib.internal.prettyprint_cell(x);
elseif isa(x, 'tabular')
    out = dispstrlib.internal.prettyprint_tabular(x);
else
    out = dispstrlib.internal.dispc(x);
end

if nargout == 0
    disp(out);
    clear out
end