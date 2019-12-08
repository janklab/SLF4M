function warnj(msg, varargin)
% Log a WARN level message from caller, using SLF4M style formatting.
%
% logm.warnj(msg, varargin)
%
% This accepts a message with SLF4J style formatting, using '{}' as placeholders for
% values to be interpolated into the message.
%
% Examples:
%
% logm.warnj('Some message. value1={} value2={}', 'foo', 42);

loggerCallImpl('warn', msg, varargin, 'j');

end