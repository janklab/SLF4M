SLF4M User's Guide
===========================

# API

SLF4M provides:

* A set of logging functions to log events at various levels
 * Regular and "J" variants for sprintf-style or SLF4J-style formatting
* A log4j configurator tool

All the code is in the `+logm` package. I chose a short, readable name because if you're using logging, it'll show up a lot in your code.

## Logging functions

| Level  |  Function  |  J Variant |
| ------ | ---------  | ---------  |
| `ERROR`  | `logm.error`      | `logm.errorj`    |
| `WARNING` | `logm.warn`      | `logm.warnj`   |
| `INFO`   | `logm.info`   | `logm.infoj`    |
| `DEBUG`  | `logm.debug`  | `logm.debugj` |
| `TRACE`  | `logm.trace`  | `logm.tracej` |

##  Regular and "J" variants

The regular ("`m`") versions of the logging functions take `fprintf`-style formatting and arguments, with `%s`/`%f`/`%d`/etc placeholders. These calls look like normal Matlab `fprintf()` calls. The argument conversion and formatting is done at the Matlab level before the message is passed along to the SLF4J Java library. These are the functions you should usually be using.

There are also "`j`"" variants of all the the logging functions which use SLF4J style formatting. These use `{}` as the placeholders, and the arguments are passed down to the SLF4J Java layer to be converted there. These variants are useful if you're working with actual Java objects in your Matlab code, and you want Java to handle the type conversion. In the `j` variants, all the input arguments are converted to Java objects using Matlab's default auto-conversion.

In both cases, the formatting and conversion is done lazily: if the logger is not enabled at the level you are logging the event, the function returns without doing the conversion. So you only pay the cost of the `sprintf()` or Java conversion and formatting if the logger is enabled.

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

For uniformity, if you define `dispstr`, I recommend that you override `disp` to make use of it.

```
    function disp(this)
        disp(dispstr(this));
    end
```

As a convenience, there is a `logm.Displayable` mix-in class which provides standard implementations of `disp` and `dispstr` in terms of `dispstrs`. If you inherit from `logm.Displayable`, you only need to define `dispstrs`.

### The `dispstr` interface

The `dispstr` function/method takes a single argument, which may be an array of any size, and returns a single one-line string.

The `dispstrs` function/method takes a single argument, which may be an array of any size, and returns a `cellstr` array of exactly the same size as the input. For `strs = dispstrs(x)`, the string in `strs{i}` corresponds to the input `x(i)`.

## `dispstr` and SLF4M interaction

When you call the normal ("`m`") variants of the logging functions, `dispstr()` is applied to any inputs which are objects, so they're converted automatically and may be passed as parameters for the `%s` conversion. (In the normal Matlab `sprintf`, most objects cannot be passed to `%s`; it results in an error.)

```
    d = database;
    logm.info('Database: %s', d);
```

For most Matlab-defined objects, this just results in a "`m-by-n <classname>`" output. (But at least it doesn't raise an error, which is especially problematic when your functions are receiving inputs of the wrong type.) It gets particularly useful when you define custom `dispstr` overrides so your objects have useful string representations.

(You used to be able to monkeypatch new methods in to Matlab-provided datatypes, but that doesn't seem to work on newer versions of Matlab.)