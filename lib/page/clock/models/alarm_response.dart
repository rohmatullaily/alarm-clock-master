class AlarmResponse {
  bool? isActive;
  String? errorMessage;

  AlarmResponse({this.isActive, this.errorMessage});

  AlarmResponse.fromJson(Map<String, dynamic> json) {
    isActive = json['isActive'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isActive'] = isActive;
    data['errorMessage'] = errorMessage;
    return data;
  }
}