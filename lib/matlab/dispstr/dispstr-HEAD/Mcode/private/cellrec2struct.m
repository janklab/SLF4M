function out = cellrec2struct(c)
%CELLREC2STRUCT Convert a cellrec to a struct

c = cellrec(c);
fieldNames = c(:,1);
fieldValues = c(:,2);
out = cell2struct(fieldValues, fieldNames, 1);

end