function result = contains(str, pat)

% CONTAINS Determine if pattern is in strings
% CONTAINS Introduced in R2016b
% https://www.mathworks.com/help/matlab/ref/contains.html

result = length(strfind(str, pat)) > 0;

end  % function contains
