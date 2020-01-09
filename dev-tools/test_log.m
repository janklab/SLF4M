function test_log

top_level_function;
top_level_class.hello_static;
pkg.func_in_pkg;
pkg.class_in_pkg.hello_static;
pkg.a.deeply.nested.package.a_class.hello_static;

anon_fcn = @() logger.info('Called from anonymous function in top-level function');
anon_fcn();

cld = calling_Logger_directly;
cld.hello;

try
    fcn_a();
catch err
    logger.warn(err, 'Caught error during processing.');
end

end

function fcn_a
x = 42;
fcn_b(x);
end

function fcn_b(x) %#ok<INUSD>
fcn_c();
end

function fcn_c()
error('This error happened down the call stack.');
end