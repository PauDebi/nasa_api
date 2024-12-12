import 'dart:convert';

class DailyApiResonse {
    DateTime date;
    String explanation;
    String? hdurl;
    MediaType mediaType;
    ServiceVersion serviceVersion;
    String title;
    String? url;
    String? copyright;
    String? thumbnailUrl;

    DailyApiResonse({
        required this.date,
        required this.explanation,
        this.hdurl,
        required this.mediaType,
        required this.serviceVersion,
        required this.title,
        this.url,
        this.copyright,
        this.thumbnailUrl,
    });

    factory DailyApiResonse.fromJson(String str) => DailyApiResonse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DailyApiResonse.fromMap(Map<String, dynamic> json) => DailyApiResonse(
        date: DateTime.parse(json["date"]),
        explanation: json["explanation"],
        hdurl: json["hdurl"],
        mediaType: mediaTypeValues.map[json["media_type"]]!,
        serviceVersion: serviceVersionValues.map[json["service_version"]]!,
        title: json["title"],
        url: json["url"],
        copyright: json["copyright"],
        thumbnailUrl: json["thumbnail_url"],
    );

    Map<String, dynamic> toMap() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "explanation": explanation,
        "hdurl": hdurl,
        "media_type": mediaTypeValues.reverse[mediaType],
        "service_version": serviceVersionValues.reverse[serviceVersion],
        "title": title,
        "url": url,
        "copyright": copyright,
        "thumbnail_url": thumbnailUrl,
    };
}

enum MediaType {
    IMAGE,
    OTHER,
    VIDEO
}

final mediaTypeValues = EnumValues({
    "image": MediaType.IMAGE,
    "other": MediaType.OTHER,
    "video": MediaType.VIDEO
});

enum ServiceVersion {
    V1
}

final serviceVersionValues = EnumValues({
    "v1": ServiceVersion.V1
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
