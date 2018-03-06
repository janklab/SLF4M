function helloWorld(x)
 
if nargin < 1 || isempty(x)
    x = 123.456;
    % These debug() calls will only show up if you set log level to DEBUG
    logm.debug('Got empty x input; defaulted to %f', x);
end
z = x + 42;

logm.info('Answer z=%f', z);
if z > intmax('int32')
    logm.warn('Large value z=%f will overflow int32', z);
end

try
    some_bad_operation(x);
catch err
    logm.error(err, 'Something went wrong in some_bad_operation(%f)', x);
end
 
end