# SLF4M

[![View SLF4M on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/85740-slf4m)

SLF4M is a simple but flexible logging framework for Matlab, built on top of [SLF4J](https://www.slf4j.org/) and [Apache Log4j](https://logging.apache.org/log4j/1.2/). You can use it to do runtime-configurable logging from your Matlab scripts and programs. This can be more informative and more manageable than commenting in and out `fprintf()` statements.

WARNING: SLF4M does not work with Matlab R2021b or later! A change in R2021b's bundled Java libraries broke SLF4M. Please see the "Requirements" section below.

SLF4M provides:

* Logging functions (a Matlab layer of bindings for SLF4J).
* A "Dispstr" API for customizing object display.
* A Log4j configuration GUI.

The API is simple enough that you can get up and running with it quickly, or even use it casually in scripts, but it’s flexible and powerful enough to be useful for larger systems.

(The `dispstr` part is optional; you don't have to learn it in order to use SLF4M logging.)

![SLF4M screenshot showing log output and configuration GUI](docs/images/SLF4M-configurator-screenshot-scaled.png)

## Usage

To install, unzip the distribution somewhere, and add its `Mcode/` directory to your Matlab path.

The logging functions are in the `+logger` package. Call them from within your Matlab code to emit log messages. In order of descending severity of logging level, they are:

* logger.error()
* logger.warn()
* logger.info()
* logger.debug()
* logger.trace()

The logging functions take sprintf()-style formatting arguments. You can also pass
an `MException` as the first argument to include the error message and stack
trace in the log message.

```matlab
function helloWorld(x)

if nargin < 1 || isempty(x)
    x = 123.456;
    % These debug() calls will only show up if you set log level to DEBUG
    logger.debug('Got empty x input; defaulted to %f', x);
end
z = x + 42;

logger.info('Answer z=%f', z);
if z > intmax('int32')
    logger.warn('Large value z=%f will overflow int32', z);
end

try
    some_bad_operation(x);
catch err
    logger.error(err, 'Something went wrong in some_bad_operation(x=%f)', x);
end

end
```

The output looks like this:

```text
>> helloWorld
16:53:18.279 INFO helloWorld() - Answer z=165.456000
16:53:18.291 ERROR helloWorld() - Something went wrong in some_bad_operation(123.456000)
Undefined function 'some_bad_operation' for input arguments of type 'double'.
Error in helloWorld (line 16)
    some_bad_operation(x);
```

Thanks to `dispstr()`, you can also pass Matlab objects to the `%s` conversions.

```text
>> m = containers.Map;
>> m('foo') = 42; m('bar') = struct;
>> logger.info('Hello, world! %s', m)
09:52:29.809 INFO  base - Hello, world! 2-by-1 containers.Map
```

If you want to customize how logging is displayed and where it goes, call `logger.Log4jConfigurator.configureBasicConsoleLogging()` at the beginning of your program to set up basic logging. If you want your logs to be saved to a file somewhere, call Matlab's `diary` function.

To launch an interactive configuration GUI, run `logger.Log4jConfigurator.showGui`. This GUI lets you see and set the logging levels and other attributes of the various loggers in your Matlab session.

For more details, see the [User's Guide](UserGuide.html).

## Requirements

A kind of recent version of Matlab, but older than R2021b. SLF4M was developed and tested on Matlab R2016b, R2017b, and R2019b, but it will probably work on some older and newer Matlab versions too.

WARNING: SLF4M does not work with Matlab R2021b or later! R2021b changed the versions of Log4j and SLF4J it ships with, and is using an unusual SLF4J/Log4j binding arrangement. This breaks SLF4M. As of 2022-04, I'm working on fixing it; see [Issue #7](https://github.com/janklab/SLF4M/issues/7) or MathWorks Tech Support Case #05490191. I'm afraid it's nontrivial.

If you're using a Matlab older than R2016b and would like SLF4M to work on it but are having problems, feel free to [submit a bug report](https://github.com/janklab/SLF4M/issues)! I'm happy to work on supporting older Matlabs if I know there are actual users out there.

## Implementation

SLF4M is a thin layer built on top of SLF4J and Log4j. It is compatible with any other Java or Matlab code that uses SLF4J or Log4j.

Log4j was chosen as the back-end because that’s what ships with Matlab.

## License

SLF4M is dual licensed under the business-friendly Apache 2.0 and BSD 2-clause licenses. Pick whichever you like.

## Author

SLF4M is developed by [Andrew Janke](https://apjanke.net). View its [home page](https://slf4m.janklab.net) or get the code from [the repo on GitHub](https://github.com/janklab/SLF4M).
