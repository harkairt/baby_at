import 'package:app/modules/time_entries/asleep_since.dart';
import 'package:app/modules/time_entries/awake_since.dart';
import 'package:app/modules/time_entries/baby_event.dart';
import 'package:app/modules/time_entries/baby_events.dart';
import 'package:app/modules/time_entries/last_breastfeeding_since.dart';
import 'package:app/modules/time_entries/last_diaper_change_since.dart';
import 'package:app/modules/time_entries/ui/baby_event_row.dart';
import 'package:app/presentation/theme/preferred_theme_mode_provider.dart';
import 'package:app/presentation/widgets/avb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:v_flutter_core/v_flutter_core.dart';

class BabyEventPage extends HookConsumerWidget {
  const BabyEventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    void addEvent(BabyEventType type) async {
      ref.watch(babyEventsProvider.notifier).add(type);

      // post frame callback
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 1000,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
        );
      });
    }

    return Scaffold(
      body: AnimationLimiter(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Builder(
                    builder: (BuildContext context) {
                      final events = ref.watch(babyEventsProvider);
                      return AVB(
                        value: events,
                        available: (context, events, isLoading) {
                          return ListView.builder(
                            controller: scrollController,
                            itemCount: events.length,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final event = events[index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 20.0,
                                  child: FadeInAnimation(
                                    child: BabyEventRow(
                                      event: event,
                                      onDelete: () {
                                        ref.watch(babyEventsProvider.notifier).remove(event.id);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: AVB(
                  value: ref.watch(preferredThemeModeProvider),
                  available: (context, value, isLoading) {
                    return IconButton(
                      iconSize: 48,
                      onPressed: () => ref.watch(preferredThemeModeProvider.notifier).cycleThemeMode(),
                      icon: value.icon,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              iconButtonTheme: IconButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5);
                      }

                      return null;
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (states) {
                      return Theme.of(context).colorScheme.primary;
                    },
                  ),
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GapRow(
                  gap: 24,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AVB(
                      value: ref.watch(asleepSinceProvider),
                      available: (context, value, isLoading) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: BabyEventType.fallAsleep.icon,
                              isSelected: value != null,
                              onPressed: () {
                                addEvent(BabyEventType.fallAsleep);
                              },
                            ),
                            Text(_formatDuration(value)),
                          ],
                        );
                      },
                    ),
                    AVB(
                      value: ref.watch(awakeSinceProvider),
                      available: (context, value, isLoading) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: BabyEventType.wakeUp.icon,
                              isSelected: value != null,
                              onPressed: () {
                                addEvent(BabyEventType.wakeUp);
                              },
                            ),
                            Text(_formatDuration(value)),
                          ],
                        );
                      },
                    ),
                    AVB(
                      value: ref.watch(lastDiaperChangeSinceProvider),
                      available: (context, value, isLoading) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: BabyEventType.changeDiaper.icon,
                              onPressed: () {
                                addEvent(BabyEventType.changeDiaper);
                              },
                            ),
                            Text(_formatDuration(value)),
                          ],
                        );
                      },
                    ),
                    AVB(
                      value: ref.watch(lastBreastfeedingSinceProvider),
                      available: (context, value, isLoading) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: BabyEventType.breastfeeding.icon,
                              onPressed: () {
                                addEvent(BabyEventType.breastfeeding);
                              },
                            ),
                            Text(_formatDuration(value)),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

String _formatDuration(Duration? duration) {
  if (duration == null) {
    return '';
  }

  return '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}';
}
