classdef DispstrHelper
    
    methods (Static)
        function disparray(x)
        strs = dispstrs(x);
        out = dispstrlib.internal.prettyprint_array(strs);
        disp(out);
        end
    end
end