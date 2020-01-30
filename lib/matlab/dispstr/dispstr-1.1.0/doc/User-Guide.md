# Dispstr User's Guide

## Motivation

Matlab lacks a conventional method for polymorphic data display that works across (almost) all types, like Java's `toString()` does. This makes it hard to write generic code that can take arbitrary inputs and include a string representation of them in debugging data. It also means that

Dispstr provides an API that includes a conventional set of functions/methods for doing polymorphic display, and a display method that respects them and supports Matlab's own composite types like `struct`, `table`, and `cell`.

This comes up when writing larger systems with "software engineering" style code, or when using custom classes to represent your data types.

## Examples

The code for these examples is in `Mcode-examples` in the Dispstr repo.

### Polymorphic display of arbitrary inputs

Let's say you have a function foo that you wish to log the operation of, using some logging framework in a `+logger` package. You want to record the input that it received, and you want that to be a readable message regardless of what input received and whether it was of an expected type.

```matlab
function out = foo(x)

    logger.info('Received input x=%s', ???);

    % ... do some work on x ...
end
```

What do you do there? `mat2str()` and `num2str()` don't work on all types; `char()` doesn't provide readable output when it's called on numerics. `disp()` doesn't return its output for you to stick in to the string, and its output can often be too long to be usable here.

`dispstr()` solves this problem.

```matlab
    logger.info('Received input x=%s', dispstr(x));
```

### Display of custom objects inside tables or structs

Or let's say you have some data identifying users on your corporate network that you want to process using tables.

```
Name     = {'Alice',            'Bob',               'Carol'}';
UserID   = [UserID('HR\alice')  UserID('Sales\bob')  UserID('Sales\carol')]';
Birthday = [Birthday(5, 24)     Birthday(12, 14)     Birthday(4, 20)]';
tbl = table(Name, UserID, Birthday);
disp(tbl)
```

Matlab's normal output is not very useful here. All the user-defined objects are displayed as opaque values just indicating their type.

```matlab
>> disp(tbl)
    Name         UserID          Birthday   
    _______    ____________    ______________
    'Alice'    [1x1 UserID]    [1x1 Birthday]
    'Bob'      [1x1 UserID]    [1x1 Birthday]
    'Carol'    [1x1 UserID]    [1x1 Birthday]
```

`dispstrs()` and `prettyprint()` solve this problem. By having your custom classes (`UserID` and `Birthday`, in this case) define `dispstrs()`, you can then call `prettyprint()` on the table and get useful display output.

```matlab
>> prettyprint(tbl)
    Name    UserID        Birthday
    _____   ___________   ________
    Alice   HR\alice      May 24  
    Bob     Sales\bob     Dec 14  
    Carol   Sales\carol   Apr 20  
```

## Using Dispstr

### Installation

To install Dispstr, just download the repo or distribution, and get its `Mcode` directory on your Matlab path. My preferred way of doing this is downloading the whole thing, including a copy of it in your own project's source tree, and having your project's initialization code add the Dispstr `Mcode` directory to the path.

No initialization beyond path setup is necessary to use the Dispstr library; it's just a collection of class and function definitions.

### Using dispstr and disptrs

Out of the box, `dispstr()` and `dispstrs()` can be useful, because they work on Matlab-supplied datatypes and produce output that is inconvenient to produce using base Matlab functions.

### Defining your classes

Dispstr becomes more powerful when you customize your own classes to conform to the API and produce their own custom output.

To do this, write your classes as normal, and then define `dispstr` and `dispstrs` methods on them.

The `dispstr` method should return a single, concise string that describes the array as a whole. The `dispstrs` method should return a cell array that is the same size as your object, and provides a single string describing the contents or value of each element of your object array.

Then, for consistency and easy access, override `disp` in your object to use `dispstr`.

```matlab
function disp(this)
    %DISP Custom display
    disp(dispstr(this));
end
```

### Using `dispstrlib.Displayable` for convenience

To save some of that work, you can just have your class inherit from `dispstrlib.Displayable` and define only a `dispstr_scalar` method. Then `dispstrlib.Displayable` will take care of the work of defining `dispstr` and `dispstrs` methods, overriding `disp` to use it, and supporting `sprintf()`, `fprintf()`, `error()`, and `warning()`.

### Customizing prettyprint

The `prettyprint` function produces a detailed display of the contents of an object or array. It's usually used on Matlab-supplied types like `table` and `struct`. But if you've defined a complex object that contains other data types (like your own tabular data structure), you can override `prettyprint` to provide a custom detailed display.

For hierarchical objects, I recommend that you have your `prettyprint` only drill down one level or so, to avoid output that explodes in size and is hard to read.

### Technical Details

Custom `dispstr` and `dispstrs` methods should always produce the same output for a given input, regardless of the Matlab session's global settings. That is, the settings of `format` and the user's locale should not affect the behavior of `dispstr` or `dispstrs`. If you you need display output that is responsive to the global `format` or locale, you should define alternate string conversion methods that don't interact with the Dispstr API.

It's okay for `prettyprint` methods to respect `format`, locale, and other global display preference settings.

`dispstr` and `dispstrs` methods should produce output for all valid values of their inputs, and preferably for invalid values too, instead of raising an error. This includes things like `NaN`s, `NaT`s, and extreme values.

All undefined input arguments for `dispstr`, `dispstrs`, and `prettyprint` are reserved for future use. Do not define them in your overridden methods.
