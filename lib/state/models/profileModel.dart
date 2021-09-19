
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

  //
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

  static String getValue(Map<String, dynamic> json, int groupId, int fieldId) {
    return json[groupId.toString()] != null
        && json[groupId.toString()]['fields'] != null
        && json[groupId.toString()]['fields'][fieldId.toString()] != null
        ? json[groupId.toString()]['fields'][fieldId.toString()]['value']['raw']
        : null;
  }

  ProfileModel.fromJson(Map<String, dynamic> json)
      : name = getValue(json, 1, 1),
        age = calculateAge(getValue(json, 1, 2) != null ? DateTime.tryParse(getValue(json, 1, 2)) : null),
        sex = getValue(json, 1, 3),
        maritalStatus = getValue(json, 1, 9),
        city = getValue(json, 1, 17),
        about = getValue(json, 1, 519),
        religiousAffiliation = getValue(json, 1, 553),
        religion = getValue(json, 1, 569),
        district = getValue(json, 1, 762),
        favouriteBibleVerses = getValue(json, 2, 741),
        hobby = getValue(json, 4, 215),
        smoking = getValue(json, 4, 253),
        alcohol = getValue(json, 4, 533),
        jesusIsforMe = getValue(json, 4, 761),
        education = getValue(json, 4, 764),
        workOrStudy = getValue(json, 4, 771),
        hasChildren = getValue(json, 4, 777),
        wantsChildren = getValue(json, 4, 785),
        willingToMove = getValue(json, 4, 788),
        height = getValue(json, 5, 257) != null ? int.tryParse(getValue(json, 5, 257)) : null,
        weight = getValue(json, 5, 258) != null ? int.tryParse(getValue(json, 5, 258)) : null,
        hairColor = getValue(json, 5, 259),
        eyesColor = getValue(json, 5, 266),
        figure = getValue(json, 5, 274),
        bestPoint = getValue(json, 5, 293);
}