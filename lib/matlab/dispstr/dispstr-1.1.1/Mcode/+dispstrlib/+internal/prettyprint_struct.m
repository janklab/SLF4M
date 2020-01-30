function out = prettyprint_struct(s)
%PRETTYPRINT_STRUCT struct implementation of prettyprint

if isscalar(s)
    fields = fieldnames(s);
    if isempty(fields)
        out = 'Scalar struct with zero fields';
        return;
    end
    fieldLens = cellfun('length', fields);
    maxFieldLen = max(fieldLens);
    lines = cell(1, numel(fields));
    for iField = 1:numel(fields)
        field = fields{iField};
        lines{iField} = sprintf('    %*s: %s', maxFieldLen, field, dispstr(s.(field)));
    end
    out = strjoin(lines, newline);
else
    out = dispstrlib.internal.dispc(s);
end
    
end
