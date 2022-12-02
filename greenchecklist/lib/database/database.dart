import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:greenchecklist/database/entity/logsheet_transaction.dart';
import 'package:greenchecklist/database/entity/parameter.dart';
import 'package:greenchecklist/database/entity/question.dart';
import 'package:greenchecklist/database/entity/score.dart';
import 'package:greenchecklist/database/entity/sub_parameter.dart';
import 'package:greenchecklist/database/entity/template_detail.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../helpers/constatnts.dart';
import 'entity/barcode.dart';
import 'entity/checklist_transaction.dart';
import 'entity/template.dart';
import 'entity/user.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file =
        File(p.join(dbFolder.path, FOLDER_GC, FOLDER_DATABASE, DATABASE_NAME));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [
  Barcode,
  ChecklistTransaction,
  LogsheetTransaction,
  Parameter,
  Question,
  Score,
  SubParameter,
  Template,
  TemplateDetail,
  User
])
class GCAppDb extends _$GCAppDb {
  GCAppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
