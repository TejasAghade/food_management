// To parse this JSON data, do
//
//     final userFoodReportModel = userFoodReportModelFromJson(jsonString);

import 'dart:convert';

UserFoodReportModel userFoodReportModelFromJson(String str) => UserFoodReportModel.fromJson(json.decode(str));

String userFoodReportModelToJson(UserFoodReportModel data) => json.encode(data.toJson());

class UserFoodReportModel {
    User? user;
    List<Report>? reports;

    UserFoodReportModel({
        this.user,
        this.reports,
    });

    factory UserFoodReportModel.fromJson(Map<String, dynamic> json) => UserFoodReportModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        reports: json["reports"] == null ? [] : List<Report>.from(json["reports"]!.map((x) => Report.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "reports": reports == null ? [] : List<dynamic>.from(reports!.map((x) => x.toJson())),
    };
}

class Report {
    String? date;
    OptInsClass? optIns;

    Report({
        this.date,
        this.optIns,
    });

    factory Report.fromJson(Map<String, dynamic> json) => Report(
        date: json["date"],
        optIns: json["opt_ins"] is Map<String, dynamic>
            ? OptInsClass.fromJson(json["opt_ins"])
            : null,
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "opt_ins": optIns?.toJson(),
    };
}

class OptInsClass {
    String? breakfast;
    String? lunch;
    String? dinner;

    OptInsClass({
        this.breakfast,
        this.lunch,
        this.dinner,
    });

    factory OptInsClass.fromJson(Map<String, dynamic> json) => OptInsClass(
        breakfast: json["breakfast"],
        lunch: json["lunch"],
        dinner: json["dinner"],
    );

    Map<String, dynamic> toJson() => {
        "breakfast": breakfast,
        "lunch": lunch,
        "dinner": dinner,
    };
}

class User {
    int? id;
    String? fName;
    String? lName;
    String? phone;
    String? email;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? status;
    int? orderCount;
    String? empId;
    int? departmentId;
    int? isVeg;
    int? isSatOpted;

    User({
        this.id,
        this.fName,
        this.lName,
        this.phone,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.orderCount,
        this.empId,
        this.departmentId,
        this.isVeg,
        this.isSatOpted,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fName: json["f_name"],
        lName: json["l_name"],
        phone: json["phone"],
        email: json["email"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        status: json["status"],
        orderCount: json["order_count"],
        empId: json["emp_id"],
        departmentId: json["department_id"],
        isVeg: json["is_veg"],
        isSatOpted: json["is_sat_opted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "f_name": fName,
        "l_name": lName,
        "phone": phone,
        "email": email,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "order_count": orderCount,
        "emp_id": empId,
        "department_id": departmentId,
        "is_veg": isVeg,
        "is_sat_opted": isSatOpted,
    };
}
