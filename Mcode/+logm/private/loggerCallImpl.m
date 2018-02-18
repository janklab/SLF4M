function loggerCallImpl(logLevel, msg, args, form)
%LOGGERCALLIMPL Implementation for the top-level logger functions
%
if nargin < 3 || isempty(args);  args = {};  end
if nargin < 4 || isempty(form);  form = 'm'; end

% Can't use a regular dbstack call here because the stack info doesn't include
% package names. Resort to parsing the human-readable formatted stack trace.
strStack = evalc('dbstack(2)');
stackLine = regexprep(strStack, '\n.+', '');
% BUG: Caller name detection doesn't work right for anonymous functions.
% This pattern isn't quite right. But truly parsing the HTML would be expensive.
caller = regexp(stackLine, '>([^<>]+)<', 'once', 'tokens');
if isempty(caller)
    % This will happen if you call the log functions interactively
    % Use a generic logger name
    callerId = 'base';
else
    callerEl = caller{1};
    if contains(callerEl, '.')
        % It's a class, or function inside a package
        % We can't differentiate a 'package.class.method' from a
        % 'package.function', so calls from package functions will get logged
        % using the package name, unfortunately.
        callerId = regexprep(callerEl, '/.*', '');
        % Strip off the function name
        ix = find(callerId == '.', 1, 'last');
        if ~isempty(ix)
            callerId = callerId(1:ix-1);
        end
    else
        % Plain function
        callerId = [callerEl '()'];
    end
end

logger = logm.Logger.getLogger(callerId);

switch form
    case 'm'
        switch logLevel
            case 'error'
                logger.error(msg, args{:});
                return
            case 'warn'
                logger.warn(msg, args{:});
                return
            case 'info'
                logger.info(msg, args{:});
                return
            case 'debug'
                logger.debug(msg, args{:});
                return
            case 'trace'
                logger.trace(msg, args{:});
                return
            otherwise
                error('logm:InvalidInput', 'Invalid logLevel: %s', logLevel);
        end
    case 'j'
        switch logLevel
            case 'error'
                logger.errorj(msg, args{:});
                return
            case 'warn'
                logger.warnj(msg, args{:});
                return
            case 'info'
                logger.infoj(msg, args{:});
                return
            case 'debug'
                logger.debugj(msg, args{:});
                return
            case 'trace'
                logger.tracej(msg, args{:});
                return
            otherwise
                error('logm:InvalidInput', 'Invalid logLevel: %s', logLevel);
        end
end

end