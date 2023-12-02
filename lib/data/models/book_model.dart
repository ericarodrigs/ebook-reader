import 'package:ebook_reader/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  BookModel({
    int? id,
    String? title,
    String? author,
    String? coverUrl,
    String? downloadUrl,
  }) : super(
          id: id,
          title: title,
          author: author,
          coverUrl: coverUrl,
          downloadUrl: downloadUrl,
        );

  BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    coverUrl = json['cover_url'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['cover_url'] = coverUrl;
    data['download_url'] = downloadUrl;
    return data;
  }

  @override
  String toString() {
    return 'BookModel {id: $id, title: $title, author: $author, coverUrl: $coverUrl, downloadUrl: $downloadUrl}';
  }
}
