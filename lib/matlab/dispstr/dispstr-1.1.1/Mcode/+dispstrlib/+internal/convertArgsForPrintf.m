function out = convertArgsForPrintf(args)

out = args;
for i = 1:numel(args)
  arg = args{i};
  if isobject(arg)
    if isstring(arg) && isscalar(arg)
      % NOP; we want to keep the single string and let it be interpolated
      % as normal
    elseif isa(arg, 'datetime') || isa(arg, 'duration') || isa(arg, 'calendarDuration')
      % NOP; these already support %s conversions
    else
      out{i} = dispstr(arg);
    end
  end
end

end