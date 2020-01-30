function out = mycombvec(vecs)
  %MYCOMBVEC All combinations of values from vectors
  %
  % This is similar to Matlab's combvec, but has a different signature.
  if ~iscell(vecs)
    error('Input vecs must be cell');
  end
  switch numel(vecs)
    case 0
      error('Must supply at least one input vector');
    case 1
      out = vecs{1}(:);
    case 2
      a = vecs{1}(:);
      b = vecs{2}(:);
      out = repmat(a, [numel(b) 2]);
      i_comb = 1;
      for i_a = 1:numel(a)
        for i_b = 1:numel(b)
          out(i_comb,:) = [a(i_a) b(i_b)];
          i_comb = i_comb + 1;
        end
      end
    otherwise
      a = vecs{1}(:);
      rest = vecs(2:end);
      rest_combs = dispstrlib.internal.mycombvec(rest);
      n_combs = numel(a) * size(rest_combs, 1);
      out = repmat(a(1), [n_combs 1+size(rest_combs, 2)]);
      for i = 1:numel(a)
        n = size(rest_combs, 1);
        this_comb = [repmat(a(i), [n 1]) rest_combs];
        out(1+((i-1)*n):1+(i*n)-1,:) = this_comb;
      end
  end
end
