
class Item {
  final int id;
  final String employee_name;
  final double employee_salary;
  final int employee_age;
  // final String profile_image;

  Item({
    required this.id,
    required this.employee_name,
    required this.employee_salary,
    required this.employee_age,
    // required this.profile_image,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      employee_name: json['employee_name'],
      employee_salary: json['employee_salary'] is double
          ? json['employee_salary']
          : double.parse(json['employee_salary'].toString()),
      employee_age: json['employee_age'] is int
          ? json['employee_age']
          : int.parse(json['employee_age'].toString()),
      // profile_image: json['profile_image'] ?? '',
    );
  }
}
