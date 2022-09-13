function varargout = throwExceptions(varargin)
%THROWEXCEPTIONS is an alias for RAISEEXCEPTIONS
%   RAISEEXCEPTIONS is inspired by the Python standard library
%   framework.
%   In MATLAB, exceptions are 'thrown' rather than 'raised', so 
%   THROWEXCEPTIONS is provided as a more MATLAB-consistent alias. 
%
%   Usage
%       % suppress exceptions during logging framework message handling
%       logger.throwExceptions(false)

[varargout{1:nargout}] = logger.raiseExceptions(varargin{:});
