function out = newline
%NEWLINE Create newline character (custom implementation)
%   This implementation supports using older MATLAB to execute some code
%   that relies on the function that was introduced in newer MATLAB.
%   For its purpose, this implementation does not need to be completely
%   faithful to the MathWorks implementation, and may not be suitable as
%   a general replacement.
%
%   MathWorks NEWLINE was introduced in R2016b.
%   https://www.mathworks.com/help/matlab/ref/newline.html

persistent val

if isempty(val)
    val = sprintf('\n');
end

out = val;

end
