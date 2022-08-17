function out = string(varargin)
%STRING Create character array (string). (custom implementation)
%   This implementation supports using older MATLAB to execute some code
%   that relies on the function that was introduced in newer MATLAB.
%   For its purpose, this implementation does not need to be completely
%   faithful to the MathWorks implementation, and may not be suitable as
%   a general replacement.
%
%   R2015b STRING is a built-in method and throws an exception,
%       Error using string
%       string is obsolete and will be discontinued. Use char instead.
%   MathWorks new STRING (String array) was introduced in R2016b.
%   https://www.mathworks.com/help/matlab/ref/string.html

out = char(varargin{:});

end
