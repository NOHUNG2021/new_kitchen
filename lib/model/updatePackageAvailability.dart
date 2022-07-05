


class UpdatePackageAvailability {
  UpdatePackageAvailability({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory UpdatePackageAvailability.fromJson(Map<String, dynamic> json) =>
      UpdatePackageAvailability(
        status: json["status"],
        message: json["message"] );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}