function errorj(msg, varargin)
% Log an ERROR level message from caller, using SLF4M style formatting.
%
% logm.errorj(msg, varargin)
%
% This accepts a message with SLF4J style formatting, using '{}' as placeholders for
% values to be interpolated into the message.
%
% Examples:
%
% logm.errorj('Some message. value1={} value2={}', 'foo', 42);

loggerCallImpl('error', msg, varargin, 'j');

end