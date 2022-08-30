function varargout = raiseExceptions(newval)
%RAISEEXCEPTIONS gets/sets a flag for handling exceptions during logging
%   RAISEEXCEPTIONS gets or sets a flag that is used by the logic that
%   controls the handling of exceptions raised/thrown during logging.
%   The default flag value is true.
%
%   Usage
%       % suppress exceptions during logging framework message handling
%       logger.raiseExceptions(false)

%{
This mechanism is inspired by a comment from Martijn Pieters in
https://stackoverflow.com/questions/66587941/what-happens-if-a-python-logging-handler-raises-an-exception

"The Python standard-library handlers have been build with robustness in 
mind.  If an exception is raised ..., all standard library 
implementations catch the exception and ...
By default, ... re-raises the exception.  In production systems you want 
to set logging.raiseExceptions = False, at which point the exceptions 
are silently ignored, and logging continues as if nothing happened.

From the documentation: ... If the module-level attribute 
raiseExceptions is False, exceptions get silently ignored. This is what 
is mostly wanted for a logging system - most users will not care about 
errors in the logging system, they are more interested in application 
errors.  ... (The default value of raiseExceptions is True, as that is 
more useful during development)."
%}

persistent flag

if isempty(flag)
    flag = true;
end

switch nargin
    case 0  % get
        varargout{1} = flag;
    case 1  % set
        assert(isscalar(newval) & islogical(newval), 'bad usage')
        flag = newval;
    otherwise
        assert(false, 'impossible')
end

end
