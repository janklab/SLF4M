function infoj(msg, varargin)
% Log an INFO level message from caller, using SLF4M style formatting.
%
% logm.infoj(msg, varargin)
%
% This accepts a message with SLF4J style formatting, using '{}' as placeholders for
% values to be interpolated into the message.
%
% Examples:
%
% logm.infoj('Some message. value1={} value2={}', 'foo', 42);

loggerCallImpl('info', msg, varargin, 'j');

end