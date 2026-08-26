class GameConfig {
  const GameConfig({
    this.raidDurationSeconds = 120,
    this.timeScoreWeight = 0.4,
    this.treasureScoreWeight = 0.4,
    this.failureScoreWeight = 0.2,
    this.maxTimeScore = 400,
    this.maxTreasureScore = 400,
    this.maxFailureScore = 200,
    this.treasureUnitScore = 80,
    this.failurePenalty = 100,
    this.graffitiCharges = 1,
    this.checkpointProgress = 0.46,
  });

  final int raidDurationSeconds;
  final double timeScoreWeight;
  final double treasureScoreWeight;
  final double failureScoreWeight;
  final int maxTimeScore;
  final int maxTreasureScore;
  final int maxFailureScore;
  final int treasureUnitScore;
  final int failurePenalty;
  final int graffitiCharges;
  final double checkpointProgress;

  int get maxScore =>
      maxTimeScore + maxTreasureScore + maxFailureScore;

  static const GameConfig defaults = GameConfig();
}
