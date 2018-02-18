function info(msg, varargin)
% Log an INFO level message from caller, with printf style formatting.
%
% logm.info(msg, varargin)
%
% This accepts a message with printf style formatting, using '%...' formatting
% controls as placeholders.
%
% Examples:
%
% logm.info('Some message. value1=%s value2=%d', 'foo', 42);

loggerCallImpl('info', msg, varargin);

end