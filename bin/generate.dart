import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart';

class BuilderData {
  final Directory lib;
  final Directory test;

  BuilderData(this.lib, this.test) {
    if (!lib.existsSync()) {
      throw Exception("dir ${lib.path} not found");
    }
    if (!test.existsSync()) {
      throw Exception("dir ${test.path} not found");
    }
  }

  Directory create([
    String? part2,
    String? part3,
    String? part4,
    String? part5,
    String? part6,
    String? part7,
    String? part8,
  ]) {
    var dir = Directory(
      join(lib.path, part2, part3, part4, part5, part6, part7, part8),
    );
    dir.createSync();
    print("mkdir: ${dir.path} create: ${dir.existsSync()}");
    return dir;
  }

  Directory createTest([
    String? part2,
    String? part3,
    String? part4,
    String? part5,
    String? part6,
    String? part7,
    String? part8,
  ]) {
    var dir = Directory(
      join(test.path, part2, part3, part4, part5, part6, part7, part8),
    );
    dir.createSync();
    print("mkdir: ${dir.path} create: ${dir.existsSync()}");
    return dir;
  }
}

abstract class Builder extends Command {
  final BuilderData data;

  Builder(this.data);
}

class GenerateCommand extends Builder {
  GenerateCommand(super.data) {
    addSubcommand(FoldersCommand(super.data));
  }

  @override
  String get name => "generate";

  @override
  String get description => "Generate from template";
}

class FoldersCommand extends Builder {
  FoldersCommand(super.data);

  @override
  String get description => "Generate folders in lib";

  @override
  String get name => "folders";

  @override
  void run() {
    data.create("domain");
    data.create("domain", "entity");
    data.create("domain", "usecase");
    data.createTest("domain");
    data.createTest("domain", "usecase");

    data.create("presentation");
    data.create("presentation", "controller");
    data.create("presentation", "page");
    data.create("presentation", "widget");
    data.createTest("presentation");
    data.createTest("presentation", "controller");

    data.create("config");
    data.create("config", "localization");

    data.create("util");
    data.createTest("util");

    data.create("data");
    data.create("data", "repository");
    data.create("data", "model");
    data.create("data", "source");
    data.create("data", "source", "local");
    data.create("data", "source", "remote");
    data.createTest("data");
    data.createTest("data", "repository");
    data.createTest("data", "source");
    data.createTest("data", "source", "local");
    data.createTest("data", "source", "remote");
  }
}
