import 'dart:io';

String reader(String name) => File('test/test_data/$name.json').readAsStringSync();