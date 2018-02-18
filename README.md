SLF4M
======================

SLF4M is a simple but flexible logging framework for Matlab, built on top of [SLF4J](https://www.slf4j.org/) and [Apache log4j](https://logging.apache.org/log4j/2.0/). You can
use it to do runtime-configurable logging from your Matlab scripts and programs.
This can be more informative and more manageable than commenting in and out
`fprintf()` statements.

The API is simple enough that you can get up and running with it quickly, or even use it casually in scripts, but it's flexible and powerful enough to be useful for larger systems.

SLF4M consists of a Matlab binding layer for SLF4J, along with a new `dispstr` API for customizing object display. (The `dispstr` part is mostly optional; you don't have to learn it in order to use SLF4M logging.)

##  Usage

To install, unzip the distribution somewhere, and add its `Mcode/` directory
to your Matlab path.

In your Matlab program, call `logm.Log4jConfigurator.configureBasicConsoleLogging()`
to set up basic logging. This will write log output to the Matlab console.

The logging functions are in the `+logm` package. Call them from within your Matlab
code.

```
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
    logm.error('Something went wrong in some_bad_operation(%f): %s', ...
        x, err.message);
end

end
```

The output looks like this:

```
>> helloWorld
08:57:47.178 INFO  helloWorld() - Answer z=165.456000
08:57:47.179 ERROR helloWorld() - Something went wrong in some_bad_operation(123.456000): Undefined function 'some_bad_operation' for input arguments of type 'double'.
```

Thanks to `dispstr()`, you can also pass Matlab objects to the `%s` conversions.

```
>> m = containers.Map;
>> m('foo') = 42; m('bar') = struct;
>> logm.info('Hello, world! %s', m)
09:52:29.809 INFO  base - Hello, world! 2-by-1 containers.Map
```

For more details, see the [User's Guide](doc/User Guide.md).

##  Requirements

A kind of recent version of Matlab. SLF4M was developed and tested on Matlab R2016b and R2017b, but it will probably work on some older Matlab versions too.

##  Implementation

SLF4M is a thin layer built on top of SLF4J and log4j. It is compatible with any
other Java or Matlab code that uses SLF4J or log4j.

log4j was chosen as the back-end because that's what ships with Matlab.

##  License

SLF4M is dual licensed under the business-friendly Apache 2.0 and BSD 2-clause licenses. Pick whichever you like.
