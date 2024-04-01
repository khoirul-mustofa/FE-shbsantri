abstract class ToJson {
  Map<String, dynamic> toJson();
}

typedef QueryParam = ToJson;

typedef RequestBody = ToJson;
