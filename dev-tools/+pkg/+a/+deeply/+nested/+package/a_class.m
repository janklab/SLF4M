classdef a_class
    methods (Static)
        function hello_static()
            logm.info('Called from static method on class in deep pkg tree');
        end
    end
end