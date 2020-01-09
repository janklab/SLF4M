SLF4M User's Guide
===========================

# Setup

To use SLF4M in your code:

* Get the SLF4M `Mcode` directory on your Matlab path
* Call `logger.initSLF4M` to initialize the library before doing any logging calls
* Add calls to the `logger` functions in your code

# API

SLF4M provides:

* A set of logging functions to log events at various levels
 * Regular and "`j`" variants for sprintf-style or SLF4J-style formatting
* A Logger class for doing logging with more control over its behavior
* A Log4j configurator tool and GUI
* `dispstr`, a customizable string-conversion API

All the code is in the `+logger` package. I chose a short, readable name because if you're using logging, it'll show up a lot in your code.

## Logging functions

| Level     |  Function    |  J Variant    |
| --------- | ------------ | ------------- |
| `ERROR`   | `logger.error` | `logger.errorj` |
| `WARNING` | `logger.warn`  | `logger.warnj`  |
| `INFO`    | `logger.info`  | `logger.infoj`  |
| `DEBUG`   | `logger.debug` | `logger.debugj` |
| `TRACE`   | `logger.trace` | `logger.tracej` |

##  Calling logging functions

In your code, put calls to `logger.info(...)`, `logger.debug(...)`, and so on, as appropriate.

```
    ...
    logger.info('Working on item %d of %d: %s', i, n, description);
    logger.debug('Intermediate value: %f', someDoubleValue);
    ...
```

##  Regular and "`j`" variants

The regular ("`m`") versions of the logging functions take `fprintf`-style formatting and arguments, with `%s`/`%f`/`%d`/etc placeholders. These calls look like normal Matlab `fprintf()` calls. The argument conversion and formatting is done at the Matlab level before the message is passed along to the SLF4J Java library. These are the functions you should usually be using.

There are also "`j`"" variants ("`j`" is for "Java") of all the the logging functions which use SLF4J style formatting. These use `{}` as the placeholders, and the arguments are passed down to the SLF4J Java layer to be converted there. These variants are useful if you're working with actual Java objects in your Matlab code, and you want Java to handle the type conversion. In the `j` variants, all the input arguments are converted to Java objects using Matlab's default auto-conversion.

Some Matlab objects may not convert to Java objects at all, so you'll get errors when trying to use the `j` variants with them.

```
	>> d = database;
	>> logger.infoj('My database: {}', d)
	No method 'info' with matching signature found for class 'org.slf4j.impl.Log4jLoggerAdapter'.
	Error in logger.Logger/infoj (line 146)
	        this.jLogger.info(msg, varargin{:});
	Error in loggerCallImpl (line 69)
	                logger.infoj(msg, args{:});
	Error in logger.infoj (line 13)
	loggerCallImpl('info', msg, varargin, 'j');
```

To avoid this, use the regular variants.

In both cases, the formatting and conversion is done lazily: if the logger is not enabled at the level you are logging the event, the function returns without doing the conversion. So you only pay the cost of the `sprintf()` or Java conversion and formatting if the logger is enabled.

##  Logger names

The logging functions in `+logger` use the caller's class or function name as the logger name. (This is
in line with the Java convention of using the fully-qualified class name as the logger name.) This is accomplished with a trick with `dbstack`, looking up the call stack to see who invoked it.

You can use anything for a logger name; if no logger of that name exists, one is created automatically. Logger names are arranged in a hierarchy using dot-qualified prefixes, like package names in Java or Matlab. For example, if you have the following loggers:

* foo.Thing
* foo.bar.Thing
* foo.bar.OtherThing
* foo.bar.baz.Whatever

Then:

* All these loggers are children of the logger `foo`
* `foo.bar.Thing` and `foo.bar.OtherThing` are children of `foo.bar`, which in turn is a child of `foo`.
* `foo.bar.baz.Whatever` is a child of `foo.bar.baz`, which is a child of `foo.bar`, which is a child of `foo`.

### The Logger object

You can also use the object-oriented `logger.Logger` API directly. This allows you to set custom logger names. It'll also be a bit faster, because it doesn't have to spend time extracting the caller name from the call stack. To use the Logger object directly, get a logger object by calling `logger.Logger.getLogger(name)` where `name` is a string holding the name of the logger you want to use. 

```
logger = logger.Logger.getLogger('foo.bar.baz.MyThing');
logger.info('Something happened');
```

If you use `logger.Logger` in object-oriented Matlab code, I recommend you do it like this, which looks like the SLFJ Java conventions.

```
classdef CallingLoggerDirectlyExample

    properties (Constant, Access=private)
        log = logger.Logger.getLogger('foo.bar.baz.qux.MyLoggerID');
    end

    methods
        function hello(this)
            this.log.info('Hello, world!');
        end

        function doWork(this)
            label = 'thingy';
            x = 1 + 2;
            timestamp = datetime;
            this.log.debug('Calculation result: label=%s, x=%f at %s', label, x, timestamp);
         end
    end
    
end
```

Evn though `log` is a `Constant` (static) property, I like to call it via `this` because it's more concise, and then you can copy and paste your code that makes logging calls between classes. Make the `log` property `private` so you can have `log` properties defined in your subclasses, too; they may want to use different IDs.

# The `dispstr` API

In addition to the SLF4J adapter layer, SLF4M provides a new API for generic value formatting and customizing the display of user-defined objects. This consists of a pair of functions, `dispstr` and `dispstrs`. They take values of any type and convert them to either a single string, or an array of strings corresponding to the input array's elements.

This is the equivalent of Java's `toString()` method, which is defined for almost everything and customized extensively. (Well, really it's equivalent to Java's `""+x` string concatenation operation, which really is defined for everything.)

```
    str = dispstr(x)     % Returns char string
    strs = dispstrs(x)   % Returns cellstr array
```

The input `x` may be *any* type.

Normally when writing a library, I avoid defining any global functions, to avoid polluting the shared namespace. But `dispstr` and `dispstrs` *must* be global functions, because they are polymorphic over all input types, including those which are themselves unaware of `dispstr`.

This provides an extension point for defining custom string conversions for your own user-defined classes. You can override `dispstr` and `dispstrs` in your classes, and SLF4M will recognize it. I find this is useful for other string formatting, too.

For uniformity, if you define `dispstr`, I recommend that you override `disp` to make use of it. And you'll typically want to make `dispstr` and `dispstrs` consistent.

```
    function disp(this)
        disp(dispstr(this));
    end

    % Standard implementation of dispstr
    function out = dispstr(this)
        if isscalar(this)
            strs = dispstrs(this);
            out = strs{1};
        else
            out = sprintf('%s %s', size2str(size(this)), class(this));
        end
    end

```

As a convenience, there is a `logger.Displayable` mix-in class which takes care of this boilerplate for you. It provides standard implementations of `disp` and `dispstr` in terms of `dispstrs`. If you inherit from `logger.Displayable`, you only need to define `dispstrs`.

### The `dispstr` interface

The `dispstr` function/method takes a single argument, which may be an array of any size, and returns a single one-line string.

The `dispstrs` function/method takes a single argument, which may be an array of any size, and returns a `cellstr` array of exactly the same size as the input. For `strs = dispstrs(x)`, the string in `strs{i}` corresponds to the input `x(i)`.

## How `dispstr` and SLF4M interact

When you call the normal ("`m`") variants of the logging functions, `dispstr()` is applied to any inputs which are objects, so they're converted automatically and may be passed as parameters for the `%s` conversion. (In the normal Matlab `sprintf`, most objects cannot be passed to `%s`; it results in an error.)

```
    d = database;
    logger.info('Database: %s', d);
```

For most Matlab-defined objects, this just results in a "`m-by-n <classname>`" output. (But at least it doesn't raise an error, which is especially problematic when your functions are receiving inputs of the wrong type.) It gets particularly useful when you define custom `dispstr` overrides so your objects have useful string representations.

(You used to be able to monkeypatch new methods in to Matlab-provided datatypes to customize their output, but that doesn't seem to work on newer versions of Matlab.)

## Configuration

All the actual logging goes through the Log4j back end; you can configure it as with any Log4j installation. See the [Log4j 1.2 documentation](http://logging.apache.org/log4j/1.2/) for details. (Note: you have to use the old 1.2 series doco, because that's what Matlab currently ships with.)

The `logger.Log4jConfigurator` class provides a convenient Matlab-friendly interface for configuring Log4j to do basic stuff. It's enough for simple cases. But all the configuration state is passed on the the Log4j back end; none of it is stored in the Matlab layer.

## Implementation notes

I chose Log4j as the back end because it's what ships with Matlab: Matlab includes the Log4j JARs and the SLF4J-to-Log4j binding, so it's already active, and it's hard to swap out another back end. (I probably would have chosen `logback` if I had my druthers.)

Matlab's internals don't seem to make much use of logging, even though they've bundled it. But some of the third-party JARs they redistributed use it. Turn the levels up to `TRACE` and see what happens.

Aside from the `dispstr` formatting, everything is done purely in terms of the underlying SLF4J interface, so SLF4M is compatible with any other code or tools that use SLF4J or Log4j.

Matlab ships with older versions of SLF4J and Log4j. (They're slow to update their Java libraries.) Hopefully that's not a problem for people.

| Matlab Version | SLF4J Version | Log4j Version   |
| -------------- | ------------- | --------------- |
| R2016b         | 1.5.8         | 1.2.15          |
| R2017b         | 1.5.8         | 1.2.15          |
| R2019b         | 1.5.8         | 1.2.15          |
