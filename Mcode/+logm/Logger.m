classdef Logger
    % Main entry point through which logging happens
    %
    % The logger class provides method calls for performing logging, and the ability
    % to look up loggers by name. This is the main entry point through which all
    % SLF4M logging happens.
    %
    % Usually you don't need to interact with this class directly, but can just call
    % one of the error(), warn(), info(), debug(), or trace() functions in the logm
    % namespace. Those will log messages using the calling class's name as the name
    % of the logger. Also, don't call the constructor for this class. Use the static
    % getLogger() method instead.
    %
    % Use this class directly if you want to customize the names of the loggers to
    % which logging is directed.
    %
    % See also:
    % logm.error
    % logm.warn
    % logm.info
    % logm.debug
    % logm.trace
    %
    % Examples:
    %
    % log = logm.Logger.getLogger('foo.bar.FooBar');
    % log.info('Hello, world! Running on Matlab %s', version);
    
    properties (SetAccess = private)
        % The underlying SLF4J Logger object
        jLogger
    end
    
    properties (Dependent = true)
        % The name of this logger
        name
        % A list of the levels enabled on this logger
        enabledLevels
    end
    
    
    methods (Static)
        function out = getLogger(identifier)
        % Gets the named Logger
        jLogger = org.slf4j.LoggerFactory.getLogger(identifier);
        out = logm.Logger(jLogger);
        end
    end
    
    methods
        function this = Logger(jLogger)
        %LOGGER Build a new logger object around an SLF4J Logger object
        %
        % Generally, you shouldn't call this. Use logm.Logger.getLogger() instead.
        mustBeType(jLogger, 'org.slf4j.Logger');
        this.jLogger = jLogger;
        end
        
        function disp(this)
            disp(dispstr(this));
        end
        
        function out = dispstr(this)
            if isscalar(this)
                strs = dispstrs(this);
                out = strs{1};
            else
                out = sprintf('%s %s', size2str(size(this)), class(this));
            end
        end
        
        function out = dispstrs(this)
            out = cell(size(this));
            for i = 1:numel(this)
                out{i} = sprintf('Logger: %s (%s)', this(i).name, ...
                    strjoin(this(i).enabledLevels, ', '));
            end
        end
        
        function error(this, msg, varargin)
        % Log a message at the ERROR level.
        if ~this.jLogger.isErrorEnabled()
            return
        end
        msgStr = formatMessage(msg, varargin{:});
        this.jLogger.error(msgStr);
        end
        
        function warn(this, msg, varargin)
        % Log a message at the WARN level.
        if ~this.jLogger.isWarnEnabled()
            return
        end
        msgStr = formatMessage(msg, varargin{:});
        this.jLogger.warn(msgStr);
        end
        
        function info(this, msg, varargin)
        % Log a message at the INFO level.
        if ~this.jLogger.isInfoEnabled()
            return
        end
        msgStr = formatMessage(msg, varargin{:});
        this.jLogger.info(msgStr);
        end
        
        function debug(this, msg, varargin)
        % Log a message at the DEBUG level.
        if ~this.jLogger.isDebugEnabled()
            return
        end
        msgStr = formatMessage(msg, varargin{:});
        this.jLogger.debug(msgStr);
        end
        
        function trace(this, msg, varargin)
        % Log a message at the TRACE level.
        if ~this.jLogger.isTraceEnabled()
            return
        end
        msgStr = formatMessage(msg, varargin{:});
        this.jLogger.trace(msgStr);
        end
        
        function errorj(this, msg, varargin)
        % Log a message at the ERROR level.
        if ~this.jLogger.isErrorEnabled()
            return
        end
        this.jLogger.error(msg, varargin{:});
        end
        
        function warnj(this, msg, varargin)
        % Log a message at the WARN level.
        if ~this.jLogger.isWarnEnabled()
            return
        end
        this.jLogger.warn(msg, varargin{:});
        end
        
        function infoj(this, msg, varargin)
        % Log a message at the INFO level.
        if ~this.jLogger.isInfoEnabled()
            return
        end
        this.jLogger.info(msg, varargin{:});
        end
        
        function debugj(this, msg, varargin)
        % Log a message at the DEBUG level.
        if ~this.jLogger.isDebugEnabled()
            return
        end
        this.jLogger.debug(msg, varargin{:});
        end
        
        function tracej(this, msg, varargin)
        % Log a message at the TRACE level.
        if ~this.jLogger.isTraceEnabled()
            return
        end
        this.jLogger.trace(msg, varargin{:});
        end
        
        function out = isErrorEnabled(this)
        % True if ERROR level logging is enabled for this logger.
        out = this.jLogger.isErrorEnabled;
        end
        
        function out = isWarnEnabled(this)
        % True if WARN level logging is enabled for this logger.
        out = this.jLogger.isWarnEnabled;
        end
        
        function out = isInfoEnabled(this)
        % True if INFO level logging is enabled for this logger.
        out = this.jLogger.isInfoEnabled;
        end
        
        function out = isDebugEnabled(this)
        % True if DEBUG level logging is enabled for this logger.
        out = this.jLogger.isDebugEnabled;
        end
        
        function out = isTraceEnabled(this)
        % True if TRACE level logging is enabled for this logger.
        out = this.jLogger.isTraceEnabled;
        end
        
        function out = listEnabledLevels(this)
        % List the levels that are enabled for this logger.
        out = {};
        if this.isErrorEnabled
            out{end+1} = 'error';
        end
        if this.isWarnEnabled
            out{end+1} = 'warn';
        end
        if this.isInfoEnabled
            out{end+1} = 'info';
        end
        if this.isDebugEnabled
            out{end+1} = 'debug';
        end
        if this.isTraceEnabled
            out{end+1} = 'trace';
        end
        end
        
        function out = get.enabledLevels(this)
        out = this.listEnabledLevels;
        end
        
        function out = get.name(this)
        out = char(this.jLogger.getName());
        end
    end
    
end

function out = formatMessage(format, varargin)
args = varargin;
for i = 1:numel(args)
    if isobject(varargin{i})
        args{i} = dispstr(varargin{i});
    end
end
out = sprintf(format, args{:});
end