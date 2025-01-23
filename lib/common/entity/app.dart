import 'package:swust_link/common/model/entity_model.dart';
import 'package:swust_link/pages/app/state.dart';

class App  extends JsonSerializable{
  final route;
  final text;
  App({this.route, this.text});

  factory App.fromJson(Map<String, dynamic> json) {
    return App(route: json['route'], text: json['text']);
  }

  // Course 对象转 JSON
  Map<String, dynamic> toJson() {
    return {"route": route, "text": text};
  }

  static List<App> getAllApp() {
    List<App> allApps = [];
    for (var category in AppState.appNewList) {
      final children = category['children'] as List?;
      if (children != null) {
        for (var appJson in children) {
          allApps.add(App.fromJson(appJson));
        }
      }
    }
    return allApps;
  }

  @override
  String toString() {
    return 'App{route: $route, text: $text}';
  }

  @override
  bool operator ==(dynamic other) {
    if (other is App) {
      return route == other.route; // 根据 route 比较
    }
    return false;
  }

  @override
  int get hashCode => route.hashCode; // 根据 route 生成 hash code
}
