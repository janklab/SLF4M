function helloWorld(x)
 
if nargin < 1 || isempty(x)
    x = 123.456;
    % These debug() calls will only show up if you set log level to DEBUG
    logger.debug('Got empty x input; defaulted to %f', x);
end
z = x + 42;

timestamp = datetime;
logger.info('Answer: z=%f, calculated at %s', z, timestamp);
if z > intmax('int32')
    logger.warn('Large value z=%f will overflow int32', z);
end

try
    some_bad_operation(x);
catch err
    logger.error(err, 'Something went wrong in some_bad_operation(%f)', x);
end
 
end