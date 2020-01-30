function out = isErrorIdentifier(str)
str = char(str);
out = ~isempty(regexp(str, '^[\w:]$', 'once')) && any(str == ':');
end