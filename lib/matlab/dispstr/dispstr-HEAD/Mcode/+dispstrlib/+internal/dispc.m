function out = dispc(x) %#ok<INUSD>
%DISPC Display, with capture

out = evalc('disp(x)');
out(end) = []; % chomp
end