classdef calling_Logger_directly
    properties (Constant, Access = private)
        logger = logger.Logger.getLogger('foo.bar.baz.qux.MyLoggerID');
    end
    
    methods
        function hello(this)
            this.logger.info('Hello, world!');
        end
    end
end
