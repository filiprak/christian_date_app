
import 'package:christian_date_app/state/models/xProfileFieldModel.dart';

class XProfileGroupModel {

  int id;
  String name;
  String description;
  int groupOrder;
  List<XProfileFieldModel> fields;

  XProfileGroupModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description']['rendered'],
        groupOrder = json['group_order'],
        fields = List<XProfileFieldModel>.from(json['fields'].map((xProfileField) => XProfileFieldModel.fromJson(xProfileField)));
}