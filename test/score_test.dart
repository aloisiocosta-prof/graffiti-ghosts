import 'package:flutter_test/flutter_test.dart';

class RaidScore {
  const RaidScore({required this.time, required this.treasure, required this.failures});

  final int time;
  final int treasure;
  final int failures;

  int get value {
    final timeScore = ((time / 60) * 400).round();
    final treasureScore = (treasure * 90).clamp(0, 400);
    final failureScore = (200 - (failures * 100)).clamp(0, 200);
    return (timeScore + treasureScore + failureScore).clamp(0, 1000);
  }
}

void main() {
  group('RaidScore', () {
    test('combines time, treasure and failures with 40/40/20 caps', () {
      expect(const RaidScore(time: 60, treasure: 5, failures: 0).value, 1000);
    });

    test('penalizes failures without producing a negative score', () {
      expect(const RaidScore(time: 0, treasure: 0, failures: 4).value, 0);
    });

    test('keeps score bounded when an economic bonus is applied elsewhere', () {
      expect(const RaidScore(time: 60, treasure: 20, failures: 0).value, 1000);
    });
  });
}
