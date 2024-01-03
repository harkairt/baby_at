import 'package:app/presentation/widgets/gradient_debug_container.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';

const showDebugLoadingOverlay = true;

typedef ErrorBuilder = Widget Function(BuildContext context, Object? error, StackTrace stack, bool isLoading);
typedef LoadingBuilder = Widget Function(BuildContext context);
typedef AvailableBuilder<T> = Widget Function(BuildContext context, T value, bool isLoading);
typedef RawAsyncValueBuilder<T> = Widget Function(BuildContext context, AsyncValue<T> value);

class AVB<T> extends HookWidget {
  const AVB({
    required this.value,
    super.key,
    this.anticipatedHeight = double.infinity,
    this.anticipatedWidth = double.infinity,
    this.duration = const Duration(milliseconds: 600),
    this.alignment = Alignment.center,
    this.error,
    this.initialLoading,
    this.available,
    this.builder,
    this.animate = true,
    this.curve = Curves.easeOutCubic,
  });

  final AsyncValue<T> value;
  final double anticipatedHeight;
  final double anticipatedWidth;
  final Duration duration;
  final AlignmentGeometry alignment;
  final ErrorBuilder? error;
  final LoadingBuilder? initialLoading;
  final AvailableBuilder<T>? available;
  final bool animate;
  final Curve curve;

  /// Individual builders [error], [initialLoading], [available] have higher precedence.
  /// If [builder] is defined then no defaults will be shown.
  final RawAsyncValueBuilder<T>? builder;

  ErrorBuilder get _errorBuilder {
    if (error != null) {
      return error!;
    }

    if (builder != null) {
      return (context, error, stack, isLoading) => builder!.call(context, value);
    }

    return _defaultErrorBuilder;
  }

  LoadingBuilder get _initialLoadingBuilder {
    if (initialLoading != null) {
      return initialLoading!;
    }

    if (builder != null) {
      return (context) => builder!.call(context, value);
    }

    return _defaultInitialLoadingBuilder;
  }

  AvailableBuilder<T> get _availableBuilder {
    if (available != null) {
      return available!;
    }

    if (builder != null) {
      return (context, value, isLoading) => builder!.call(context, this.value);
    }

    return _defaultDataBuilder;
  }

  @override
  Widget build(BuildContext context) {
    final constraints = useMemoized(
      () => BoxConstraints.tightForFinite(height: anticipatedHeight, width: anticipatedWidth),
      [anticipatedHeight, anticipatedWidth],
    );

    final errorKey = useMemoized(() => const ValueKey('error'));
    final loadingKey = useMemoized(() => const ValueKey('loading'));
    final dataKey = useMemoized(() => const ValueKey('data'));

    Widget stateBuilder({required Duration duration}) {
      assert(duration != Duration.zero);

      return value.when(
        skipLoadingOnRefresh: true,
        skipLoadingOnReload: true,
        loading: () {
          return KeyedSubtree(
            key: loadingKey,
            child: ConstrainedBox(
              constraints: constraints,
              child: Entry(
                opacity: animate ? 0 : 1,
                curve: curve,
                duration: duration,
                child: HookBuilder(builder: (context) => _initialLoadingBuilder.call(context)),
              ),
            ),
          );
        },
        error: (error, stack) => KeyedSubtree(
          key: errorKey,
          child: ConstrainedBox(
            constraints: constraints,
            child: Entry(
              opacity: animate ? 0 : 1,
              duration: duration,
              child: HookBuilder(
                builder: (context) => HookBuilder(
                  builder: (context) => Stack(
                    children: [
                      _errorBuilder(
                        context,
                        error,
                        stack,
                        this.value.isLoading,
                      ),
                      if (showDebugLoadingOverlay && kDebugMode) _DebugLoadingOverlay(isLoading: this.value.isLoading)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        data: (value) => KeyedSubtree(
          key: dataKey,
          child: ConstrainedBox(
            // Although the available builder should not be constrained, this ConstrainedBox
            // is required so the widget hierarchy is the same on all paths
            constraints: const BoxConstraints.tightForFinite(),
            child: Entry(
              opacity: animate ? 0 : 1,
              curve: curve,
              duration: duration,
              child: HookBuilder(
                builder: (context) => Stack(
                  children: [
                    _availableBuilder.call(
                      context,
                      value,
                      this.value.isLoading,
                    ),
                    if (showDebugLoadingOverlay && kDebugMode) _DebugLoadingOverlay(isLoading: this.value.isLoading)
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (animate) {
      return AnimatedSize(
        duration: duration * 0.3,
        curve: curve,
        alignment: alignment,
        child: stateBuilder(duration: duration),
      );
    } else {
      return stateBuilder(duration: const Duration(milliseconds: 10));
    }
  }
}

Widget _defaultErrorBuilder(BuildContext context, Object? error, StackTrace stack, bool isLoading) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.warning_rounded, size: 32, color: Colors.grey.shade600),
        const SizedBox(height: 8),
        Builder(
          builder: (context) {
            return GradientDebugContainer(
              debugChild: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(error.toString(), textAlign: TextAlign.center),
                  Text(stack.toString()),
                ],
              ),
              child: const Text('Something went wrong', textAlign: TextAlign.center),
            );
          },
        ),
      ],
    ),
  );
}

Widget _defaultInitialLoadingBuilder(BuildContext context) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget _defaultDataBuilder<T>(BuildContext context, T value, bool isLoading) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Text(value.toString(), textAlign: TextAlign.center),
    ),
  );
}

class _DebugLoadingOverlay extends StatelessWidget {
  const _DebugLoadingOverlay({
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedOpacity(
          opacity: isLoading ? 0.4 : 0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
