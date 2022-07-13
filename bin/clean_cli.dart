import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart';

import 'generate.dart';

void main(List<String> arguments) {
  var data = BuilderData(
    Directory(join(Directory.current.path, "lib")),
    Directory(join(Directory.current.path, "test")),
  );

  CommandRunner("clean_cli", "A sample command-line application.")
    ..addCommand(GenerateCommand(data))
    ..run(arguments).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64);
    });
}
