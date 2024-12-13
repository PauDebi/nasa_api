class Link {
  final String href;
  final String rel;
  final String? render;

  Link({
    required this.href,
    required this.rel,
    this.render,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      href: json['href'],
      rel: json['rel'],
      render: json['render'],
    );
  }
}
