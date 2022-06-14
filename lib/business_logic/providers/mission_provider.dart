import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Models
import 'package:airspector/business_logic/models/stages.dart';
import 'package:airspector/business_logic/models/points.dart';
import 'package:airspector/business_logic/controllers/mission_edit_controller.dart';

class MissionProvider with ChangeNotifier, DiagnosticableTreeMixin {
  MissionEditController missionController;

  Future<WayPoints> get waypoints => missionController.waypoinsFromApi;

  // add stage to end and return id
  int addStage() {
    missionController.pushStage(Stage(1, 0, 0, 0));
    notifyListeners();
    return missionController.getLastStageId();
  }

  void updateFormValue(int i) {
    missionController.updateFormValue(i);
    notifyListeners();
  }

  void reorderStage(int oldIndex, int newIndex) {
    missionController.reorderStage(oldIndex, newIndex);
    notifyListeners();
  }

  void writeFormToStage(int i) {
    missionController.writeFormToStage(i);
    notifyListeners();
  }

  void deleteStage(int i) {
    missionController.deleteStage(i);
    notifyListeners();
  }

  MissionProvider({required this.missionController}) {
    Stage spiral2 = Stage(1, 0, 0, 0);
    spiral2.type = 1; // spiral2
    spiral2.overlap_h = 99;
    spiral2.overlap_v = 75;
    spiral2.r = 6;
    spiral2.pitch = 0;
    spiral2.start_z = 20;
    spiral2.stop_z = 5;
    spiral2.H = 5;
    spiral2.pitch = 45;
    missionController.pushStage(spiral2);

    Stage spiral = Stage(1, 0, 0, 0);
    spiral.type = 1; // spiral
    spiral.start_z = 17;
    spiral.stop_z = 5;
    spiral.H = 5;
    spiral.overlap_h = 98;
    spiral.overlap_v = 75;
    spiral.r = 6;
    spiral.pitch = 0;
    missionController.pushStage(spiral);

    Stage snake2 = Stage(1, 0, 0, 0);
    snake2.type = 2; //snake2
    snake2.overlap_h = 80;
    snake2.overlap_v = 50;
    snake2.r = 3;
    snake2.pitch = 0;
    snake2.start_z = 2;
    snake2.stop_z = 20;
    snake2.H = 20;
    snake2.pitch = 45;
    missionController.pushStage(snake2);

    //first snake
    Stage snake = Stage(1, 0, 0, 0);
    snake.type = 2; //snake
    snake.start_z = 0;
    snake.stop_z = 18;
    snake.H = 18;
    snake.overlap_h = 80;
    snake.overlap_v = 50;
    snake.r = 3;
    snake.pitch = 0;
    missionController.pushStage(snake);

    /**/
  }
}
