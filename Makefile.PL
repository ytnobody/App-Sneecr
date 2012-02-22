use inc::Module::Install;
name 'App-Sneecr';
all_from 'lib/App/Sneecr.pm';

requires 'JSON';
requires 'File::Slurp';
requires 'Data::DPath';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
