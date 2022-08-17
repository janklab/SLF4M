function out = isfolder(folderName)
%ISFOLDER Determine if input is folder (custom implementation)
%   This implementation supports using older MATLAB to execute some code
%   that relies on the function that was introduced in newer MATLAB.
%   For its purpose, this implementation does not need to be completely
%   faithful to the MathWorks implementation, and may not be suitable as
%   a general replacement.
%
%   MathWorks ISFOLDER was introduced in R2017b.
%   https://www.mathworks.com/help/matlab/ref/isfolder.html

out = isdir(folderName);

end
