classdef calling_Logger_directly
    properties (Constant, Access = private)
        log = logm.Logger.getLogger('foo.bar.baz.qux.MyLoggerID');
    end
    
    methods
        function hello(this)
            this.log.info('Hello, world!');
        end
    end
end
