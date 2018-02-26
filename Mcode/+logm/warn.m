function warn(msg, varargin)
% Log a WARN level message from caller, with printf style formatting.
%
% logm.warn(msg, varargin)
% logm.warn(exception, msg, varargin)
%
% This accepts a message with printf style formatting, using '%...' formatting
% controls as placeholders.
%
% Examples:
%
% logm.warn('Some message. value1=%s value2=%d', 'foo', 42);

loggerCallImpl('warn', msg, varargin);

end