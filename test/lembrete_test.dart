import 'package:flutter_to_do_list/lembrete.dart';
import 'package:test/test.dart';

void main (){

  test('Lembrete deve estar vazio por padrão (== null)', () {
    final testeLembrete = Reminder();
    expect(testeLembrete.name, isNull);
    expect(testeLembrete.date, isNull);
  });


}