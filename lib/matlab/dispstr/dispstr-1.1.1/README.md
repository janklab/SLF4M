# dispstr

[![View dispstr on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/73960-dispstr)

The Dispstr API is a Matlab API for extensible, polymorphic custom object display. This means it's an API you can code against to support generic display of user-defined objects and their data. It also supports using those custom displays when the objects are contained inside a complex type such as a `struct` or `table`.

## Motivation

Matlab lacks a conventional method for polymorphic data display that works across (almost) all types, like Java's `toString()` does. This makes it hard to write generic code that can take arbitrary inputs and include a string representation of them in debugging data. It also means that custom classes don't display well when they're inside a `struct` or `table`.

Dispstr provides an API that includes a conventional set of functions/methods for doing polymorphic display, and a display method that respects them and supports Matlab's own composite types like `struct`, `table`, and `cell`.

This fixes Matlab output that looks like this:

```
>> disp(tbl)
    Name       UserID          Birthday
    _______    ____________    ______________
    'Alice'    [1x1 UserID]    [1x1 Birthday]
    'Bob'      [1x1 UserID]    [1x1 Birthday]
    'Carol'    [1x1 UserID]    [1x1 Birthday]
```

to look more useful, like this:

```
>> prettyprint(tbl)
    Name    UserID        Birthday
    _____   ___________   ________
    Alice   HR\alice      May 24  
    Bob     Sales\bob     Dec 14  
    Carol   Sales\carol   Apr 20  
```

There's not a whole lot of code in this library. I think the major value in it is in establishing the function convention and signatures, not in the implementation code itself.

## Functions

### `dispstr` and `dispstrs`

`dispstr` and `dispstrs` are polymorphic functions that can display a concise, human-readable summary of any input data. Their implementation in the API is as global functions that have support for Matlab's built-in data types, and generic display formats for user-defined objects. User-defined classes can define `dispstr` and `dispstrs` methods to override them and provide customized displays.

`dispstr` produces a single string that describes an entire array.

`dispstr` produces a string for each element in an array, that describes that particular element's value or contents.

### `sprintfds`, `fprintfds`, `errords`, and `warningds`

`sprintfds` and `fprintfds` are variants of `sprintf` and `fprintf` that respect dispstr() methods defined on their arguments, so you can pass objects to '%s' conversion specifiers and get nice output.

Similarly, `errords` and `warningds` are variants of Matlab’s `error` and `warning` that support dispstr functionality, so you can pass objects to their '%s' conversion specifiers, too.

### `prettyprint` and `pp`

`prettyprint` is a function that produces a verbose, multi-line, formatted output describing an object's contents. The main implementation can handle Matlab built-in types, `struct`s, and `table`s, respecting the custom `dispstr` implementations of objects inside those structs and tables.

Classes can implement their own `prettyprint` methods to customize their own display. This is typically only needed for classes that implement complex, hierarchical structures like tabular objects, trees, and whatnot.

`pp` is a command wrapper around `prettyprint` for interactive use. It does the same thing as `prettyprint`, except that it also accepts variable names as `char` for its input.

### `dispstrlib.Displayable`

`dispstrlib.Displayable` is a convenience mixin class that makes it easier for you to write classes that use dispstr and dispstrs.

## Usage

Get the Dispstr library on your path, and then define `dispstr()` and `dispstrs()` methods on your classes. Have their `disp()` methods use `dispstr()`. Or, for convenience, have them inherit from `dispstrlib.Displayable` and just define `dispstrs()` on them.

See [the Documentation](doc/Index.md) for details.

## License

BSD 2-Clause License. Share and enjoy.
