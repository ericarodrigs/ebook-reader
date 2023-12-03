import 'dart:io';

import 'package:ebook_reader/domain/entities/book_entity.dart';
import 'package:ebook_reader/shared/exceptions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class BookLocalDataSource {
  Future<bool> initDb();
  Future<List<BookEntity>> getFavoriteBooks();
  Future<bool> insertFavoriteBook(BookEntity book);
  Future<bool> deleteFavoriteBook(int bookId);
}

class BookLocalDataSourceImpl implements BookLocalDataSource {
  late Database _db;
  final _dbName = 'nsqflite.db';
  final _bookTable = 'book_tb';

  @override
  Future<bool> initDb() async {
    try {
      final dbFolder = await getDatabasesPath();
      if (!await Directory(dbFolder).exists()) {
        await Directory(dbFolder).create(recursive: true);
      }
      final dbPath = join(dbFolder, _dbName);
      _db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) async {
          await _initBookTable(db);
        },
      );
      return true;
    } catch (_) {
      throw ConnectionException();
    }
  }

  Future<void> _initBookTable(Database db) async {
    await db.execute('''
          CREATE TABLE $_bookTable(
          id INTEGER PRIMARY KEY,
          title TEXT,
          author TEXT,
          cover_url TEXT,
          download_url TEXT
          )
        ''');
  }

  @override
  Future<bool> insertFavoriteBook(BookEntity book) async {
    try {
      await _db.transaction(
        (txn) async {
          await txn.rawInsert('''
          INSERT INTO $_bookTable 
          (
          title,
          author,
          cover_url,
          download_url,
          )
          VALUES
            (
              "${book.title}",
              "${book.author}",
              "${book.coverUrl}",
              "${book.downloadUrl}"
            )''');
        },
      );
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  @override
  Future<List<BookEntity>> getFavoriteBooks() async {
    final json = await _db.rawQuery('SELECT * FROM $_bookTable');
    return json.map<BookEntity>((e) => BookEntity.fromJson(e)).toList();
  }

  @override
  Future<bool> deleteFavoriteBook(int bookId) async {
    try {
      await _db.rawDelete('''
        DELETE FROM $_bookTable
        WHERE id = $bookId
      ''');
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }
}
