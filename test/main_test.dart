import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_to_do_list/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  initializeDateFormatting('pt_BR', null);
  testWidgets('Formulários estão na página', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    expect(find.byType(TextFormField), findsNWidgets(2));
  });
  testWidgets('Botão "Criar" existe na página', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Entrada do texto no campo "Nome"', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    final campoNome = find.byKey(const Key('NameTextFieldKey'));
    final campoData = find.byKey(const Key('DateTextFieldKey'));
    final botaoCriar = find.byKey(const Key('ButtonCreateKey'));

    await tester.enterText(campoNome, 'Lembrete de teste');

    expect(find.text('Lembrete de teste'), findsOne);

    await tester.tap(campoData);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text('29'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(botaoCriar);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(Card), findsAny);
    expect(find.text('Lembrete de teste'), findsOne);

    await tester.tap(find.widgetWithIcon(IconButton, Icons.close));
    expect(find.byType(ListTile), findsAny);
  });

  testWidgets('Entrada do valor no campo "Data"', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    final campoData = find.byKey(const Key('DateTextFieldKey'));
    await tester.tap(campoData);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text('29'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(
        (tester.widget(find.byKey(const Key('DateTextFieldKey')))
                as TextFormField)
            .controller
            ?.text,
        '29/03/2024');
  });

  testWidgets('Cards devem estar sendo carregados na tela.', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    final campoNome = find.byKey(const Key('NameTextFieldKey'));
    final campoData = find.byKey(const Key('DateTextFieldKey'));
    final botaoCriar = find.byKey(const Key('ButtonCreateKey'));

    await tester.enterText(campoNome, 'Lembrete de teste');

    await tester.tap(campoData);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text('29'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(botaoCriar);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(Card), findsAny);
  });

  testWidgets('Botão para excluir lembrete deve remover o card.',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    final campoNome = find.byKey(const Key('NameTextFieldKey'));
    final campoData = find.byKey(const Key('DateTextFieldKey'));
    final botaoCriar = find.byKey(const Key('ButtonCreateKey'));

    await tester.enterText(campoNome, 'Lembrete de teste');

    await tester.tap(campoData);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text('29'));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(botaoCriar);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.widgetWithIcon(IconButton, Icons.close));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(ListTile), findsNothing);
  });
}
