/// 1.引入json_annotation
import 'package:json_annotation/json_annotation.dart';

/// 2.指定此类的代码生成文件(格式：part '类名.g.dart';)
part 'person_bean.g.dart';

/// 3.添加序列化标注
@JsonSerializable()
class PersonModel {
  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  PersonModel({this.firstName, this.lastName});

  /// 4.添加反序列化方法(格式：factory 类名.fromJson(Map<String, dynamic> json) => _$类名FromJson(json);)
  factory PersonModel.fromJson(Map<String, dynamic> json) => _$PersonModelFromJson(json);

  /// 5.添加序列化方法(格式：Map<String, dynamic> toJson() => _$类名ToJson(this);)
  Map<String, dynamic> toJson() => _$PersonModelToJson(this);
}
