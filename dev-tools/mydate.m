classdef mydate < logger.Displayable
    % An example of using Displayable
    %
    % (Don't actually implement dates like this! It's super slow; you need to use
    % planar-organized objects instead.)
    properties
        theDatenum double = NaN
    end
    
    methods
        function this = mydate(dnums)
            if nargin == 0
                return;
            end
            this = repmat(this, size(dnums));
            for i = 1:numel(dnums)
                this(i).theDatenum = dnums(i);
            end
        end
        
        function out = dispstrs(this)
            out = cell(size(this));
            for i = 1:numel(this)
                dn = this(i).theDatenum;
                if isnan(dn)
                    out{i} = 'NaN';
                else
                    out{i} = datestr(this(i).theDatenum);
                end
            end
        end
    end
end