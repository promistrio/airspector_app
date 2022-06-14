import 'package:airspector/business_logic/models/stages.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:airspector/business_logic/controllers/mission_api_controller.dart';
import 'package:airspector/business_logic/models/points.dart';

class MissionEditController {
  late List<Stage> stages = [];
  late Stages stagesModel;
  MissionApiController api = MissionApiController();

  MissionEditController() {
    stages = [];
    stagesModel = Stages(stages);
    stages = stagesModel.requests;
  }

  // add stage to end of list
  int pushStage(Stage stage) {
    stages.add(stage);
    return stages.length - 1;
  }

  void reorderStage(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = stages.removeAt(oldIndex);
    stages.insert(newIndex, item);
  }

  // delete stage by ID
  void deleteStage(int i) {
    stages.removeAt(i);
  }

  Future<String> loginMission() => api.loginSkydio();
  Future<String> skillset() => api.skillsetSkydio();
  Future<String> upload() => api.uploadMissionSkydio();

  //upload json which has been getted from file convertion
  Future<String> uploadFromFile(String json) =>
      api.uploadMissionSkydioFromJson(json);

  Future<WayPoints> get waypoinsFromApi =>
      api.requestGeneratedMission(stagesModel);

  int getLastStageId() => stages.length - 1;

  void updateFormValue(int idStage) {
    form.control("type").value = stages[idStage].type;
    form.control("start_z").value = stages[idStage].start_z;
    form.control("stop_z").value = stages[idStage].stop_z;
    form.control("overlap_h").value = stages[idStage].overlap_h;
    form.control("overlap_v").value = stages[idStage].overlap_v;
    form.control("r").value = stages[idStage].r;
    form.control("pitch").value = stages[idStage].pitch;
  }

  void writeFormToStage(int idStage) {
    stages[idStage].type = form.control("type").value;
    stages[idStage].start_z = form.control("start_z").value;
    stages[idStage].stop_z = form.control("stop_z").value;
    stages[idStage].H = form.control("stop_z").value;
    stages[idStage].overlap_h = form.control("overlap_h").value;
    stages[idStage].overlap_v = form.control("overlap_v").value;
    stages[idStage].r = form.control("r").value;
    stages[idStage].pitch = form.control("pitch").value;
  }

  void generateMission() {
    api.requestGeneratedMission(stagesModel);
  }

  // form settings
  final form = FormGroup({
    'type': FormControl<int>(value: 1, validators: [Validators.required]),
    'start_z': FormControl<int>(
        value: 0, validators: [Validators.min(0), Validators.required]),
    'stop_z': FormControl<int>(
        value: 0, validators: [Validators.min(0), Validators.required]),
    'r': FormControl<int>(
        value: 0, validators: [Validators.min(0), Validators.required]),
    'pitch': FormControl<int>(value: 0, validators: [
      Validators.min(0.0),
      Validators.max(90.0),
      Validators.required
    ]),
    'overlap_h': FormControl<int>(value: 50, validators: [
      Validators.min(0),
      Validators.max(100),
      Validators.required
    ]),
    'overlap_v': FormControl<int>(value: 50, validators: [
      Validators.min(0),
      Validators.max(100),
      Validators.required
    ]),
  });
}
