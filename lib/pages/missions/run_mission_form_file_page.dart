import 'dart:convert';

import 'package:airspector/business_logic/models/points.dart';
import 'package:airspector/business_logic/models/stages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:airspector/business_logic/providers/mission_provider.dart';

class RunMissionFromFilePage extends StatelessWidget {
  final String jsonMission;
  int _count = 0;
  final form = FormGroup({
    'waypointsCount': FormControl<int>(value: 0),
    'missionDuration': FormControl<int>(value: 0),
    'output': FormControl<String>(value: ""),
  });

  RunMissionFromFilePage({Key? key, required this.jsonMission, ccount})
      : super(key: key){
    _count = ccount;
    form.control("waypointsCount").value = _count;
  }
  @override
  Widget build(BuildContext context) {
    MissionProvider missionProvider = Provider.of<MissionProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Запуск миссии из файла'),
        ),
        body: Column(
          children: [
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
                  ValidationMessage.min: 'Значение должно быть не меньше нуля',
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
                  ValidationMessage.min: 'Значение должно быть не меньше нуля',
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
                  ValidationMessage.min: 'Значение должно быть не меньше нуля',
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
                  missionProvider.missionController
                      .uploadFromFile(jsonMission)
                      .then((value) {
                    form.control("output").value = value;
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                          const SnackBar(content: Text("Загружено")));
                  });
                },
                child: const Text('Upload'))
          ],
        ));
  }
}
