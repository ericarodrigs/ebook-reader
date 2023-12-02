import 'dart:convert';

import 'package:ebook_reader/data/datasources/book_datasource.dart';
import 'package:ebook_reader/data/models/book_model.dart';
import 'package:ebook_reader/shared/exceptions.dart';
import 'package:http/http.dart' as http;

class BookRemoteDataSourceImpl implements BookDataSource {
  final http.Client client;

  BookRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<BookModel>> getBooks() async {
    final response = await client.get(
      Uri.parse('https://escribo.com/books.json'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      final List<BookModel> books =
          jsonData.map((book) => BookModel.fromJson(book)).toList();

      return books;
    } else {
      throw ServerException();
    }
  }
}
