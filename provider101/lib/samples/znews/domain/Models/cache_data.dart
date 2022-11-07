import 'package:equatable/equatable.dart';

const Duration maxCacheAge = Duration(hours: 1);

class CacheData extends Equatable {
  final dynamic articles;
  final DateTime age;

  const CacheData({required this.articles, required this.age});

  bool get isValid => DateTime.now().isBefore(age.add(maxCacheAge));

  factory CacheData.fromJson(Map<dynamic, dynamic> json) {
    return CacheData(
      articles: json['articles'],
      age: DateTime.parse(json['age']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'articles': articles,
      'age': age.toString(),
    };
  }

  @override
  List<Object?> get props => [articles, age];
}
