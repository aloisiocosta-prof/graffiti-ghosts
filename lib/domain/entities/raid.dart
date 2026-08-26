import '../../core/config/game_config.dart';

enum RaidPhase {
  ready,
  infiltrating,
  chasing,
  captured,
  completed,
}

enum RouteKind {
  main,
  secret,
  escape,
}

class RaidState {
  const RaidState({
    required this.phase,
    required this.progress,
    required this.ghostProgress,
    required this.timeRemaining,
    required this.treasure,
    required this.failures,
    required this.heat,
    required this.graffitiCharges,
    required this.graffitiActive,
    required this.secretRouteRevealed,
    required this.temporaryShortcutActive,
    required this.trapAltered,
    required this.checkpointProgress,
    required this.lastEvent,
    required this.selectedRoute,
    required this.usedSecondChance,
  });

  factory RaidState.initial({GameConfig config = GameConfig.defaults}) {
    return RaidState(
      phase: RaidPhase.ready,
      progress: 0,
      ghostProgress: 0.12,
      timeRemaining: config.raidDurationSeconds,
      treasure: 0,
      failures: 0,
      heat: 0,
      graffitiCharges: config.graffitiCharges,
      graffitiActive: false,
      secretRouteRevealed: false,
      temporaryShortcutActive: false,
      trapAltered: false,
      checkpointProgress: 0,
      lastEvent: 'Choose a fortress to begin the raid.',
      selectedRoute: RouteKind.main,
      usedSecondChance: false,
    );
  }

  final RaidPhase phase;
  final double progress;
  final double ghostProgress;
  final int timeRemaining;
  final int treasure;
  final int failures;
  final int heat;
  final int graffitiCharges;
  final bool graffitiActive;
  final bool secretRouteRevealed;
  final bool temporaryShortcutActive;
  final bool trapAltered;
  final double checkpointProgress;
  final String lastEvent;
  final RouteKind selectedRoute;
  final bool usedSecondChance;

  bool get isPlayable =>
      phase == RaidPhase.infiltrating || phase == RaidPhase.chasing;

  bool get hasTreasure => treasure > 0;

  RaidState copyWith({
    RaidPhase? phase,
    double? progress,
    double? ghostProgress,
    int? timeRemaining,
    int? treasure,
    int? failures,
    int? heat,
    int? graffitiCharges,
    bool? graffitiActive,
    bool? secretRouteRevealed,
    bool? temporaryShortcutActive,
    bool? trapAltered,
    double? checkpointProgress,
    String? lastEvent,
    RouteKind? selectedRoute,
    bool? usedSecondChance,
  }) {
    return RaidState(
      phase: phase ?? this.phase,
      progress: progress ?? this.progress,
      ghostProgress: ghostProgress ?? this.ghostProgress,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      treasure: treasure ?? this.treasure,
      failures: failures ?? this.failures,
      heat: heat ?? this.heat,
      graffitiCharges: graffitiCharges ?? this.graffitiCharges,
      graffitiActive: graffitiActive ?? this.graffitiActive,
      secretRouteRevealed: secretRouteRevealed ?? this.secretRouteRevealed,
      temporaryShortcutActive:
          temporaryShortcutActive ?? this.temporaryShortcutActive,
      trapAltered: trapAltered ?? this.trapAltered,
      checkpointProgress: checkpointProgress ?? this.checkpointProgress,
      lastEvent: lastEvent ?? this.lastEvent,
      selectedRoute: selectedRoute ?? this.selectedRoute,
      usedSecondChance: usedSecondChance ?? this.usedSecondChance,
    );
  }
}

class ScoreBreakdown {
  const ScoreBreakdown({
    required this.time,
    required this.treasure,
    required this.failures,
  });

  final int time;
  final int treasure;
  final int failures;

  int get total => time + treasure + failures;
}

class RaidResult {
  const RaidResult({
    required this.score,
    required this.treasure,
    required this.reputation,
    required this.breakdown,
    required this.usedSecondChance,
  });

  final int score;
  final int treasure;
  final int reputation;
  final ScoreBreakdown breakdown;
  final bool usedSecondChance;
}
