// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stage _$StageFromJson(Map<String, dynamic> json) => Stage(
      json['R'] as int,
      json['r'] as int,
      json['start_z'] as int,
      json['stop_z'] as int,
    )
      ..alpha = json['alpha'] as int
      ..theta = json['theta'] as int
      ..skydio = json['skydio'] as int
      ..overlap_h = json['overlap_h'] as int
      ..overlap_v = json['overlap_v'] as int
      ..pitch = json['pitch'] as int
      ..obj_cx = json['obj_cx'] as int
      ..obj_cy = json['obj_cy'] as int
      ..obj_cz = json['obj_cz'] as int
      ..type = json['type'] as int
      ..H = json['H'] as int;

Map<String, dynamic> _$StageToJson(Stage instance) => <String, dynamic>{
      'alpha': instance.alpha,
      'theta': instance.theta,
      'skydio': instance.skydio,
      'overlap_h': instance.overlap_h,
      'overlap_v': instance.overlap_v,
      'pitch': instance.pitch,
      'R': instance.R,
      'r': instance.r,
      'obj_cx': instance.obj_cx,
      'obj_cy': instance.obj_cy,
      'obj_cz': instance.obj_cz,
      'type': instance.type,
      'start_z': instance.start_z,
      'stop_z': instance.stop_z,
      'H': instance.H,
    };

Stages _$StagesFromJson(Map<String, dynamic> json) => Stages(
      (json['requests'] as List<dynamic>)
          .map((e) => Stage.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..output = json['output'] as int
      ..isSkydio = json['isSkydio'] as bool
      ..isMultiMission = json['isMultiMission'] as bool;

Map<String, dynamic> _$StagesToJson(Stages instance) => <String, dynamic>{
      'output': instance.output,
      'isSkydio': instance.isSkydio,
      'isMultiMission': instance.isMultiMission,
      'requests': instance.requests.map((e) => e.toJson()).toList(),
    };
