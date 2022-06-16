function out = readdir(pth)
% A slightly better version of Matlab's DIR function.
%
% Returns just the names of directory entries, and excludes "." and "..".
d = dir(pth);
d(ismember({d.name}, {'.','..'})) = [];
out = {d.name};
end
