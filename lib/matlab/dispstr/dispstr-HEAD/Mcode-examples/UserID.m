classdef UserID < dispstrlib.Displayable
    
    properties
        id
    end
    
    methods
        function this = UserID(idstr)
            this.id = idstr;
        end
    end
    
    methods (Access = private)
        function out = dispstr_scalar(this)
            out = sprintf('[UserId: %s]', this.id);
        end
    end
    
end
