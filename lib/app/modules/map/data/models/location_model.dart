import 'package:current_location/app/core/commons.dart';

part 'location_model.g.dart';

@JsonSerializable(createToJson: false)
class IPLocationModel {
  IPLocationModel({
    this.lat,
    this.long,
  });

  factory IPLocationModel.fromJson(Map<String, dynamic> json) =>
      _$IPLocationModelFromJson(json);

  final double? lat;
  @JsonKey(name: 'lon')
  final double? long;
}
