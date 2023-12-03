class BookEntity {
  int? id;
  String? title;
  String? author;
  String? coverUrl;
  String? downloadUrl;

  BookEntity({
    this.id,
    this.title,
    this.author,
    this.coverUrl,
    this.downloadUrl,
  });

  BookEntity.fromJson(Map<String, dynamic> json) {
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
    return 'BookEntity {id: $id, title: $title, author: $author, coverUrl: $coverUrl, downloadUrl: $downloadUrl}';
  }
}
