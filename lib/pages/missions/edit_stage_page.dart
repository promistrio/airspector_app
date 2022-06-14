import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../business_logic/providers/mission_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditStagePage extends StatelessWidget {
  final int stageId;
  const EditStagePage({Key? key, required this.stageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MissionProvider missionManager = Provider.of<MissionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Stage ${stageId + 1}'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 14, color: Colors.white),
              primary: Colors.white,
            ),
            onPressed: () {
              missionManager.deleteStage(stageId);
              Navigator.pop(context, "Stage has been deleted");
            },
            child: const Text('Удалить'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 14, color: Colors.white),
              primary: Colors.white,
            ),
            onPressed: () {
              missionManager.writeFormToStage(stageId);
              Navigator.pop(context, "Stage has been changed");
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
      body: ListView(
        children: [
          ReactiveForm(
            formGroup: missionManager.missionController.form,
            child: ReactiveDropdownField<int>(
              formControlName: 'type',
              decoration: const InputDecoration(
                labelText: 'Тип',
              ),
              items: const [
                DropdownMenuItem(value: 1, child: Text('Спираль')),
                DropdownMenuItem(
                    value: 2, child: Text('Змейка/Зиг-Заг')),
              ],
            ),
          ),
          ReactiveForm(
            formGroup: missionManager.missionController.form,
            child: ReactiveTextField<int>(
              formControlName: 'start_z',
              keyboardType: TextInputType.number,
              showErrors: (control) => control.invalid,
              decoration: const InputDecoration(
                labelText: 'Начальная высота, метры',
              ),
              validationMessages: (control) => {
                ValidationMessage.min:
                    'Значение должно быть не меньше нуля',
              },
            ),
          ),
          ReactiveForm(
            formGroup: missionManager.missionController.form,
            child: ReactiveTextField<int>(
              formControlName: 'stop_z',
              keyboardType: TextInputType.number,
              showErrors: (control) => control.invalid,
              decoration: const InputDecoration(
                labelText: 'Конечная высота, метры',
              ),
              validationMessages: (control) => {
                ValidationMessage.min:
                    'Значение должно быть не меньше нуля',
              },
            ),
          ),
          ReactiveForm(
            formGroup: missionManager.missionController.form,
            child: ReactiveTextField<int>(
              formControlName: 'r',
              keyboardType: TextInputType.number,
              showErrors: (control) => control.invalid,
              decoration: const InputDecoration(
                labelText: 'Дистанция до объекта, метры',
              ),
              validationMessages: (control) => {
                ValidationMessage.min:
                    'Значение должно быть не меньше нуля',
              },
            ),
          ),
          ReactiveForm(
            formGroup: missionManager.missionController.form,
            child: ReactiveTextField<int>(
              formControlName: 'pitch',
              keyboardType: TextInputType.number,
              showErrors: (control) => control.invalid,
              decoration: const InputDecoration(
                labelText: 'Наклон камеры, градусы',
              ),
              validationMessages: (control) => {
                ValidationMessage.min:
                    'Значение должно быть в диапазоне 0-90',
                ValidationMessage.max:
                    'Значение должно быть в диапазоне 0-90',
              },
            ),
          ),
          ReactiveForm(
            formGroup: missionManager.missionController.form,
            child: ReactiveTextField<int>(
              formControlName: 'overlap_h',
              keyboardType: TextInputType.number,
              showErrors: (control) => control.invalid,
              decoration: const InputDecoration(
                labelText:
                    'Горизонтальное перекрытие, %',
              ),
              validationMessages: (control) => {
                ValidationMessage.min:
                    'Значение должно быть в диапазоне 0-100',
                ValidationMessage.max:
                    'Значение должно быть в диапазоне 0-100',
              },
            ),
          ),
          ReactiveForm(
            formGroup: missionManager.missionController.form,
            child: ReactiveTextField<int>(
              formControlName: 'overlap_v',
              keyboardType: TextInputType.number,
              showErrors: (control) => control.invalid,
              decoration: const InputDecoration(
                labelText: 'Вертикальное перекрытие',
              ),
              validationMessages: (control) => {
                ValidationMessage.min:
                    'Значение должно быть в диапазоне 0-100',
                ValidationMessage.max:
                    'Значение должно быть в диапазоне 0-100',
              },
            ),
          ),
        ],
      ),
    );
  }
}
