function test_log

top_level_function;
top_level_class.hello_static;
pkg.func_in_pkg;
pkg.class_in_pkg.hello_static;
pkg.a.deeply.nested.package.a_class.hello_static;

anon_fcn = @() logm.info('Called from anonymous function in top-level function');
anon_fcn();

cld = calling_Logger_directly;
cld.hello;
end