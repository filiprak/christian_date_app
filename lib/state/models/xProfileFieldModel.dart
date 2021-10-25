
class XProfileFieldModel {

  int id;
  int groupId;
  String type;
  String name;
  String value;
  String description;
  bool isRequired;
  String visibilityLevel;
  List<String> options;

  XProfileFieldModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        groupId = json['group_id'],
        type = json['type'],
        name = json['name'],
        value = json['data']['value']['raw'],
        description = json['description']['rendered'],
        isRequired = json['is_required'],
        visibilityLevel = json['visibility_level'],
        options = List<String>.from(json['options'].map((option) => option['name'])) {
    if (!isRequired && options.isNotEmpty && !options.contains("") && (type == 'selectbox' || type == 'radio')) {
      options.add("");
    }
  }
}