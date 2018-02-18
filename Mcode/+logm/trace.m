function trace(msg, varargin)
% Log a TRACE level message from caller, with printf style formatting.
%
% logm.trace(msg, varargin)
%
% This accepts a message with printf style formatting, using '%...' formatting
% controls as placeholders.
%
% Examples:
%
% logm.trace('Some message. value1=%s value2=%d', 'foo', 42);

loggerCallImpl('trace', msg, varargin);

end