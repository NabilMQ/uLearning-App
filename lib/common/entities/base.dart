
class BaseResponseEntity {
  int? code;
  String? msg;
  String? data;

  BaseResponseEntity({
    this.code,
    this.msg,
    this.data,
  });

  factory BaseResponseEntity.fromJson(Map<String, dynamic> json) =>
      BaseResponseEntity(
        code: json["code"],
        msg: json["msg"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
    "counts": code ,
    "msg": msg ,
    "items": data,
  };
}

class BindFcmTokenRequestEntity {
  String? fcmtoken;

  BindFcmTokenRequestEntity({
    this.fcmtoken,
  });

  Map<String, dynamic> toJson() => {
    "fcmtoken": fcmtoken,
  };
}

class BaseResponseEntityXendit {
  String? message;
  String? checkout_link;

  BaseResponseEntityXendit({
    this.message,
    this.checkout_link,
  });

  factory BaseResponseEntityXendit.fromJson(Map<String, dynamic> json) =>
      BaseResponseEntityXendit(
        message: json["message"],
        checkout_link: json["checkout_link"],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "checkout_link": checkout_link,
  };
}