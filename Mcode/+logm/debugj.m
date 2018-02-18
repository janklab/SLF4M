function debugj(msg, varargin)
% Log a DEBUG level message from caller.
%
% logm.debug(msg, varargin)
%
% This accepts a message with SLF4J style formatting, using '{}' as placeholders for
% values to be interpolated into the message.
%
% Examples:
%
% logm.debug('Some message. value1={} value2={}', 'foo', 42);

loggerCallImpl('debug', msg, varargin, 'j');

end