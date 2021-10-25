
class ProfileModel {
  // information
  String name;
  int age;
  String sex;
  String maritalStatus;
  String city;
  String about;
  String religion;
  String religiousAffiliation;
  String district;

  // description
  String favouriteBibleVerses;
  String describeYourself;

  // lifestyle
  String hobby;
  String smoking;
  String alcohol;
  String jesusIsforMe;
  String education;
  String workOrStudy;
  String hasChildren;
  String wantsChildren;
  String willingToMove;

  // appearance
  int height;
  int weight;
  String hairColor;
  String eyesColor;
  String figure;
  String bestPoint;

  static int calculateAge(DateTime birthDate) {
    if (birthDate == null) {
      return null;
    }
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  ProfileModel.fromJson(Map<String, dynamic> json) {
    Map<int, dynamic> fields = new Map();
    json['groups'].forEach((group) {
      if (group['fields'] is List) {
        group['fields'].forEach((field) {
          if (field['value']['raw'].isNotEmpty) {
            fields[field['id']] = field['value']['raw'];
          }
        });
      } else if (group['fields'] is Map) {
        group['fields'].forEach((i, field) {
          if (field['value']['raw'].isNotEmpty) {
            fields[field['id']] = field['value']['raw'];
          }
        });
      }
    });

    name = fields[1];
    age = calculateAge(fields[2] != null ? DateTime.tryParse(fields[2]) : null);
    sex = fields[3];
    maritalStatus = fields[9];
    city = fields[17];
    about = fields[519];
    religiousAffiliation = fields[553];
    religion = fields[569];
    district = fields[762];
    favouriteBibleVerses = fields[741];
    describeYourself = fields[212];
    hobby = fields[215];
    smoking = fields[253];
    alcohol = fields[533];
    jesusIsforMe = fields[761];
    education = fields[764];
    workOrStudy = fields[771];
    hasChildren = fields[777];
    wantsChildren = fields[785];
    willingToMove = fields[788];
    height = fields[257] != null ? int.tryParse(fields[257]) : null;
    weight = fields[258] != null ? int.tryParse(fields[258]) : null;
    hairColor = fields[259];
    eyesColor = fields[266];
    figure = fields[274];
    bestPoint = fields[293];
  }

}