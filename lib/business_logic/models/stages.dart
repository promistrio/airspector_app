import 'package:json_annotation/json_annotation.dart';

part 'stages.g.dart';

@JsonSerializable()
class Stage {
  int alpha = 84; // horizontal FOV for skydio
  int theta = 56; // vertical FOV
  int skydio = 1; // change output to skydio format
  int overlap_h = 70; // horizontal overlapping
  int overlap_v = 70; // vertical overlapping
  int pitch = 0; // camera rotation
  int R; // tower's radius
  int r; // offset from tower
  int obj_cx = 0; // tower center coordinates (or 0)
  int obj_cy = 0;
  int obj_cz = 0;
  int type = 1;
  int start_z;
  int stop_z;
  int H = 0;
  Stage(this.R, this.r, this.start_z, this.stop_z) {
    H = stop_z;
  }

  factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);
  Map<String, dynamic> toJson() => _$StageToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Stages {
  int output = 0;
  bool isSkydio = true;
  bool isMultiMission = true;
  List<Stage> requests = [];

  Stages(this.requests);

  factory Stages.fromJson(Map<String, dynamic> json) => _$StagesFromJson(json);

  Map<String, dynamic> toJson() => _$StagesToJson(this);
}

class MissionStatus {
  int points = -1;
}

//for generate flutter pub run build_runner build