import 'package:airspector/business_logic/models/points.dart';
import 'package:airspector/business_logic/models/stages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:airspector/business_logic/providers/mission_provider.dart';

class RunMissionPage extends StatelessWidget {
  final Stages stages;
  final form = FormGroup({
    'waypointsCount': FormControl<int>(value: 0),
    'missionDuration': FormControl<int>(value: 0),
    'output': FormControl<String>(value: ""),
  });

  RunMissionPage({Key? key, required this.stages}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    MissionProvider missionProvider = Provider.of<MissionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Запуск миссии с сервера'),
      ),
      body: FutureBuilder<WayPoints>(
        future: missionProvider
            .waypoints, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<WayPoints> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            form.control("waypointsCount").value = snapshot.data?.count;
            form.control("missionDuration").value = snapshot.data?.duration;
            children = <Widget>[
              ReactiveForm(
                formGroup: form,
                child: ReactiveTextField<String>(
                  maxLines: 10,
                  enableInteractiveSelection: false,
                  formControlName: 'output',
                  keyboardType: TextInputType.number,
                  showErrors: (control) => control.invalid,
                  decoration: const InputDecoration(
                    labelText: 'Ответ аппарата',
                  ),
                  validationMessages: (control) => {
                    ValidationMessage.min:
                        'Значение должно быть не меньше нуля',
                  },
                ),
              ),
              ReactiveForm(
                formGroup: form,
                child: ReactiveTextField<int>(
                  enableInteractiveSelection: false,
                  formControlName: 'waypointsCount',
                  keyboardType: TextInputType.number,
                  showErrors: (control) => control.invalid,
                  decoration: const InputDecoration(
                    labelText: 'Количество полетных точек',
                  ),
                  validationMessages: (control) => {
                    ValidationMessage.min:
                        'Значение должно быть не меньше нуля',
                  },
                ),
              ),
              ReactiveForm(
                formGroup: form,
                child: ReactiveTextField<int>(
                  enableInteractiveSelection: false,
                  formControlName: 'missionDuration',
                  keyboardType: TextInputType.number,
                  showErrors: (control) => control.invalid,
                  decoration: const InputDecoration(
                    labelText: 'расчетная длительность полета',
                  ),
                  validationMessages: (control) => {
                    ValidationMessage.min:
                        'Значение должно быть не меньше нуля',
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    missionProvider.missionController
                        .loginMission()
                        .then((value) {
                      form.control("output").value = value;
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                            const SnackBar(content: Text("Загружено")));
                    });
                  },
                  child: const Text('Login To Device')),
              ElevatedButton(
                  onPressed: () {
                    missionProvider.missionController.skillset().then((value) {
                      form.control("output").value = value;
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                            const SnackBar(content: Text("Загружено")));
                    });
                  },
                  child: const Text('SkillSet')),
              ElevatedButton(
                  onPressed: () {
                    missionProvider.missionController.upload().then((value) {
                      form.control("output").value = value;
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                            const SnackBar(content: Text("Загружено")));
                    });
                  },
                  child: const Text('Upload'))
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Error: '),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
