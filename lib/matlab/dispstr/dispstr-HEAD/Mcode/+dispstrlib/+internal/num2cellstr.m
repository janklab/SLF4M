function out = num2cellstr(x)
%NUM2CELLSTR Like num2str, but return cellstr of individual number strings
out = strtrim(cellstr(num2str(x(:))));
end