class Notification {
  late String title;
  late DateTime publishedDate;
  late String content;
  late String url;

  Notification({title, publishedDate, content, url}) {
    this.title = title ?? "";
    this.publishedDate = publishedDate ?? DateTime.now();
    this.content = content ?? "";
    this.url = url ?? "";
  }

  factory Notification.fromJson(Map<dynamic, dynamic> json) {
    return Notification(
      title: json['title'],
      publishedDate: DateTime.parse(json['published_date']),
      content: json['content'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'published_date': publishedDate,
        'content': content,
        'url': url,
      };
}
