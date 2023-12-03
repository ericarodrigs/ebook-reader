import 'dart:convert';

import 'package:ebook_reader/domain/entities/book_entity.dart';
import 'package:ebook_reader/shared/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class BookRemoteDataSource {
  Future<List<BookEntity>> getBooks();
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final http.Client client;

  BookRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<BookEntity>> getBooks() async {
    final response = await client.get(
      Uri.parse('https://escribo.com/books.json'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final List<BookEntity> books =
          jsonData.map((book) => BookEntity.fromJson(book)).toList();

      return books;
    } else {
      throw ServerException();
    }
  }
}
