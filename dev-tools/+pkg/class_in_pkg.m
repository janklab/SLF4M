classdef class_in_pkg
    methods (Static = true)
        function hello_static()
            logm.info('hello_static() called on class_in_pkg');
        end
    end
end