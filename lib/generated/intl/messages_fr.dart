// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  static String m0(craFilters) => "${Intl.select(craFilters, {
            'all': 'Tous',
            'notFilled': 'Non Rempli',
            'activity': 'Activité',
            'leave': 'Congé',
          })}";

  static String m1(craType) => "${Intl.select(craType, {
            'project': 'Projet',
            'formation': 'Formation',
            'paidLeave': 'Congé payé',
            'unpaidLeave': 'Congé sans solde',
            'rTT': 'RTT',
            'sickLeave': 'Maladie',
            'exceptional': 'Exceptionelle',
            'holiday': 'Jour Férié',
            'blank': 'Non rempli',
          })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addActivity":
            MessageLookupByLibrary.simpleMessage("Ajouter une activité"),
        "available": MessageLookupByLibrary.simpleMessage("Disponible"),
        "checkYourEmail":
            MessageLookupByLibrary.simpleMessage("Vérifiez votre email"),
        "craFilters": m0,
        "craTypes": m1,
        "fillCra": MessageLookupByLibrary.simpleMessage("Remplisser CRA"),
        "mailPlaceHolder": MessageLookupByLibrary.simpleMessage(
            "xxx@proxym-it.com or xxx@proxym.fr"),
        "password": MessageLookupByLibrary.simpleMessage("Mot de passe"),
        "pleaseProvideAPassword": MessageLookupByLibrary.simpleMessage(
            "veuillez fournir un mot de passe"),
        "save": MessageLookupByLibrary.simpleMessage("Sauvegarder"),
        "selectAnActivity":
            MessageLookupByLibrary.simpleMessage("Sélectionner une activité"),
        "selectDate": MessageLookupByLibrary.simpleMessage("Sélectionner Date"),
        "unkownError": MessageLookupByLibrary.simpleMessage("Erreur inconnue")
      };
}
