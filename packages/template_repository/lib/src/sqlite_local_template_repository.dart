import 'dart:async';

import 'package:sqflite/sqflite.dart';

import '../template_repository.dart';
import 'entity/entities.dart';

final String templateTable = 'template';
final String columnId = 'id';
final String columnImage = 'image';

class SqliteLocalTemplateRepository implements TemplateRepository {
  static final SqliteLocalTemplateRepository _sqliteLocalTemplateRepository =
      SqliteLocalTemplateRepository._internal();

  SqliteLocalTemplateRepository._internal();

  factory SqliteLocalTemplateRepository() {
    return _sqliteLocalTemplateRepository;
  }

  Database db;

  @override
  Future initialize() async {
    this.db = db ??
        await openDatabase('fuzzgram.db', version: 1,
            onCreate: (Database db, int version) async {
          await db.execute('''
          create table $templateTable ( 
            $columnId text primary key, 
            $columnImage text not null)
          ''');
        });
  }

  @override
  Stream<List<Template>> findTemplates(int limit,
      [String category, DateTime startAfter, int offset = 0]) {
    return db
        .query(templateTable,
            distinct: true, orderBy: columnId, limit: limit, offset: offset)
        .asStream()
        .map((templates) {
      return templates
          .map((template) =>
              Template.fromEntity(TemplateEntity.fromJson(template)))
          .toList();
    });
  }

  @override
  Future insert(Template template) async {
    await db.insert(templateTable, <String, dynamic>{
      columnId: template.id,
      columnImage: template.imageUrl
    });
  }

  @override
  Future delete(String id) async {
    await db.delete(templateTable, where: '$columnId = ?', whereArgs: [id]);
  }

  @override
  Future<bool> exists(String id) async {
    var queryResult =
        await db.query(templateTable, where: '$columnId = ?', whereArgs: [id]);
    return queryResult.isNotEmpty;
  }
}
