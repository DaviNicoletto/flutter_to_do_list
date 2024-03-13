import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_to_do_list/app_widget.dart';

void main() =>
    initializeDateFormatting('pt_BR', null).then((_) => runApp(const MyApp()));
