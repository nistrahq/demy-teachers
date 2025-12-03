import 'package:demy_teachers/core/localization/l10n/app_localizations.dart';
import 'package:demy_teachers/features/schedule/domain/entities/class_session.dart';
import 'package:demy_teachers/features/schedule/presentation/blocs/reschedule_bloc.dart';
import 'package:demy_teachers/features/schedule/presentation/blocs/reschedule_event.dart';
import 'package:demy_teachers/features/schedule/presentation/blocs/reschedule_state.dart';
import 'package:demy_teachers/features/schedule/presentation/widgets/selection_tile.dart';
import 'package:demy_teachers/features/schedule/presentation/widgets/read_only_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class TeachingReschedulePage extends StatefulWidget {
  final ClassSession session;

  const TeachingReschedulePage({super.key, required this.session});
  
  @override
  State<TeachingReschedulePage> createState() => _TeachingReschedulePageState();
}

class _TeachingReschedulePageState extends State<TeachingReschedulePage> {
  
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late String selectedDay;
  
  late final TimeOfDay originalStartTime;
  late final TimeOfDay originalEndTime;
  
  final List<String> daysOfWeekApi = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    
    originalStartTime = _parseTimeString(widget.session.startTime);
    startTime = originalStartTime;

    originalEndTime = _parseTimeString(widget.session.endTime);
    endTime = originalEndTime;
    
    selectedDay = widget.session.dayOfWeek;
  }

  TimeOfDay _parseTimeString(String timeString) {
    try {
      final parts = timeString.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (e) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
  }

  bool get _hasChanges {
    return startTime != originalStartTime ||
           endTime != originalEndTime ||
           selectedDay != widget.session.dayOfWeek;
  }

  Future<void> _pickTime({required bool isStartTime}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime : endTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              dialHandColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  Future<void> _pickDay(BuildContext context) async {
    final t = AppLocalizations.of(context);
    final daysTranslated = [
      t.monday,
      t.tuesday,
      t.wednesday,
      t.thursday,
      t.friday,
      t.saturday,
      t.sunday,
    ];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(t.selectDay),
          children: List.generate(daysOfWeekApi.length, (index) {
            final dayApi = daysOfWeekApi[index];
            final dayDisplay = daysTranslated[index];
            
            return SimpleDialogOption(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              onPressed: () {
                setState(() {
                  selectedDay = dayApi;
                });
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(dayDisplay, style: const TextStyle(fontSize: 16)),
                  if (selectedDay == dayApi)
                    Icon(Icons.check, color: Theme.of(context).colorScheme.primary, size: 20),
                ],
              ),
            );
          }),
        );
      },
    );
  }
  
  Future<bool> _showConfirmationDialog(BuildContext context) async {
    final t = AppLocalizations.of(context);
    
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(t.confirmReschedule),
          content: Text(t.confirmRescheduleMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(t.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(t.yesSaveChanges),
            ),
          ],
        );
      },
    ) ?? false;
  }

  String _translateDay(String dayApi, AppLocalizations t) {
    switch (dayApi) {
      case 'Monday': return t.monday;
      case 'Tuesday': return t.tuesday;
      case 'Wednesday': return t.wednesday;
      case 'Thursday': return t.thursday;
      case 'Friday': return t.friday;
      case 'Saturday': return t.saturday;
      case 'Sunday': return t.sunday;
      default: return dayApi;
    }
  }

  String _formatTimeForApi(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }

  @override
  Widget build(BuildContext context) {
    final bool canSave = _hasChanges;
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context);

    return BlocProvider(
      create: (_) => GetIt.I<RescheduleBloc>(),
      child: BlocConsumer<RescheduleBloc, RescheduleState>(
        listener: (context, state) {
          if (state is RescheduleSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.rescheduledSuccessfully)));
            context.pop(true);
          }
          if (state is RescheduleFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: Colors.red));
          }
        },
        builder: (context, state) {
          final bool isSaving = state is RescheduleLoading;

          return Scaffold(
            appBar: AppBar(
              title: Text(t.teachingRescheduleTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: colorScheme.primaryContainer,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            SelectionTile(
                              icon: Icons.calendar_today,
                              title: t.dayOfWeek,
                              value: _translateDay(selectedDay, t),
                              onTap: () => _pickDay(context),
                            ),
                            const Divider(height: 1, indent: 50),
                            SelectionTile(
                              icon: Icons.access_time,
                              title: t.startTime,
                              value: startTime.format(context),
                              onTap: () => _pickTime(isStartTime: true),
                            ),
                            const Divider(height: 1, indent: 50),
                            SelectionTile(
                              icon: Icons.access_time_filled,
                              title: t.endTime,
                              value: endTime.format(context),
                              onTap: () => _pickTime(isStartTime: false),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      ReadOnlyField(
                        icon: Icons.book,
                        text: "${t.course}: ${widget.session.course.name} - ${widget.session.course.code}",
                      ),
                      const SizedBox(height: 12),
                      ReadOnlyField(
                        icon: Icons.location_on,
                        text: "${t.campus}: ${widget.session.classroom.campus} - ${t.classroom}: ${widget.session.classroom.code}",
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.pop(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(t.cancel),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FilledButton(
                          onPressed: (canSave && !isSaving)
                            ? () async {
                                final confirmed = await _showConfirmationDialog(context);

                                if (confirmed) {
                                  context.read<RescheduleBloc>().add(SubmitReschedule(
                                    sessionId: widget.session.id,
                                    classroomId: widget.session.classroom.id,
                                    startTime: _formatTimeForApi(startTime), 
                                    endTime: _formatTimeForApi(endTime),
                                    dayOfWeek: selectedDay.toUpperCase(),
                                  ));
                                }
                              }
                              : null,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: canSave 
                                ? colorScheme.primaryContainer
                                : Colors.grey[300],
                            foregroundColor: canSave
                                ? colorScheme.onPrimaryContainer
                                : Colors.black54,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: isSaving
                            ? const CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ) 
                            : Text(t.save),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}