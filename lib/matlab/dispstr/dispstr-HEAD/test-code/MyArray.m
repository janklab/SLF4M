classdef MyArray < dispstrable
    properties
        x
    end
    
    methods
        function this = MyArray(x)
        this.x = x;
        end
        
        function out = size(this)
        out = size(this.x);
        end
        
        function out = numel(this)
        out = numel(this.x);
        end
        
        function out = dispstrs(this)
        out = dispstrs(this.x);
        end
        
        function prettyprint(this)
        dispstrlib.internal.prettyprint_array(dispstrs(this));
        end
    end
end