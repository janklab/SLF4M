function out = copyfields(s, s2)
%COPYFIELDS Copy field values between structs
%
% out = jcopyfields(s, s2)
%
% Copies fields from s2 to s. S2 and s may be structs, or any other type which
% supports field access by dot-referencing and the fieldnames() function.

out = s;
fields = fieldnames(s2);
for i = 1:numel(fields)
    out.(fields{i}) = s2.(fields{i});
end
end