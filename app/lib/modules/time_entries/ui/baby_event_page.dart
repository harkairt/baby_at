import 'package:app/modules/time_entries/baby_event.dart';
import 'package:app/modules/time_entries/baby_events.dart';
import 'package:app/modules/time_entries/ui/baby_event_row.dart';
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
        child: Column(
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
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // outline decoration
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.yellow,
                width: 2,
                
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: GapRow(
                gap: 24,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.baby_changing_station),
                    onPressed: () {
                      addEvent(BabyEventType.changeDiaper);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.bedtime_outlined),
                    onPressed: () {
                      addEvent(BabyEventType.fallAsleep);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.wb_sunny_outlined),
                    onPressed: () {
                      addEvent(BabyEventType.wakeUp);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
