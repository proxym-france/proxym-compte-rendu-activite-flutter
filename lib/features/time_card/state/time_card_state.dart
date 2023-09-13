import 'package:mycra_timesheet_app/core/utils/state.dart';
import 'package:mycra_timesheet_app/domain/entity/collab.dart';
import 'package:mycra_timesheet_app/domain/entity/cra_card_model.dart';
import 'package:mycra_timesheet_app/domain/entity/timecard.dart';
import 'package:mycra_timesheet_app/features/time_card/state/time_card_filter.dart';

class TimeCardStateModel {
  final Collab? selectedCollab;
  final int selectedCollabIndex;
  final DateTime selectedDate;
  final State<List<CraCardModel>> cra;
  final State<List<Collab>> collabs;
  final TimecardFilter selectedChip;
  final State<TimeCard> timeCard;

  TimeCardStateModel({
    required this.selectedCollabIndex,
    this.selectedCollab,
    required this.selectedDate,
    required this.cra,
    required this.collabs,
    required this.selectedChip,
    required this.timeCard,
  });

  TimeCardStateModel.initial({
    this.selectedCollab,
    this.selectedCollabIndex = 0,
    DateTime? selectedDate,
    State<List<CraCardModel>>? cra,
    State<List<Collab>>? collabs,
    State<TimeCard>? timeCard,
    this.selectedChip = TimecardFilter.all,
  })  : selectedDate = selectedDate ?? DateTime.now(),
        cra = cra ?? Loading(),
        collabs = collabs ?? Loading(),
        timeCard = timeCard ?? Loading();

  TimeCardStateModel copyWith({
    Collab? selectedCollab,
    DateTime? selectedDate,
    int? selectedCollabIndex,
    State<List<CraCardModel>>? cra,
    State<List<Collab>>? collabs,
    TimecardFilter? selectedChip,
    State<TimeCard>? timeCard,
  }) =>
      TimeCardStateModel(
        selectedCollab: selectedCollab ?? this.selectedCollab,
        selectedDate: selectedDate ?? this.selectedDate,
        selectedCollabIndex: selectedCollabIndex ?? this.selectedCollabIndex,
        cra: cra ?? this.cra,
        collabs: collabs ?? this.collabs,
        selectedChip: selectedChip ?? this.selectedChip,
        timeCard: timeCard ?? this.timeCard,
      );
}
