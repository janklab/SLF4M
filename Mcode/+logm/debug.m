function debug(msg, varargin)
% Log a DEBUG level message from caller, with printf style formatting.
%
% logm.debug(msg, varargin)
%
% This accepts a message with printf style formatting, using '%...' formatting
% controls as placeholders.
%
% Examples:
%
% logm.debug('Some message. value1=%s value2=%d', 'foo', 42);

loggerCallImpl('debug', msg, varargin);

end