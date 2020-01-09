classdef top_level_class
    methods (Static)
        function hello_static()
            logger.info('Called from static method in top-level class');
        end
    end
end

