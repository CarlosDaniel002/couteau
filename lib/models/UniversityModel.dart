class University {
  final String name;
  final List<String> domains;
  final String webPage;

  University({required this.name, required this.domains, required this.webPage});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'],
      domains: List<String>.from(json['domains']),
      webPage: json['web_pages'][0],
    );
  }
}