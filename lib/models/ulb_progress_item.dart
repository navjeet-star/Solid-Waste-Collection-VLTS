/// Data model representing a ULB progress/ranking record
class UlbProgressItem {
  final int rank;
  final String ulbName;
  final String fleetActive;
  final double routeCoverage;
  final int tripsDone;
  final String notReporting;
  final int score;

  const UlbProgressItem({
    required this.rank,
    required this.ulbName,
    required this.fleetActive,
    required this.routeCoverage,
    required this.tripsDone,
    required this.notReporting,
    required this.score,
  });

  /// Sample mock data accurately transcribed from the ULB performance dashboard
  static List<UlbProgressItem> get sampleList => const [
        UlbProgressItem(
          rank: 1,
          ulbName: 'Nagar Nigam, Kanvnagri Kotdwar',
          fleetActive: '39/40 (97.0%)',
          routeCoverage: 97.18,
          tripsDone: 292,
          notReporting: '2% (1)',
          score: 97,
        ),
        UlbProgressItem(
          rank: 2,
          ulbName: 'Nagar Nigam, Haldwani',
          fleetActive: '78/79 (98.0%)',
          routeCoverage: 72.41,
          tripsDone: 0,
          notReporting: '1% (1)',
          score: 85,
        ),
        UlbProgressItem(
          rank: 3,
          ulbName: 'Nagar Nigam, Haridwar',
          fleetActive: '46/46 (100.0%)',
          routeCoverage: 70.13,
          tripsDone: 177,
          notReporting: '0% (0)',
          score: 85,
        ),
        UlbProgressItem(
          rank: 4,
          ulbName: 'Nagar Nigam, Rudrapur',
          fleetActive: '63/71 (88.0%)',
          routeCoverage: 82.83,
          tripsDone: 0,
          notReporting: '11% (8)',
          score: 85,
        ),
        UlbProgressItem(
          rank: 5,
          ulbName: 'Nagar Nigam, Srinagar',
          fleetActive: '10/11 (90.0%)',
          routeCoverage: 73.48,
          tripsDone: 94,
          notReporting: '9% (1)',
          score: 82,
        ),
        UlbProgressItem(
          rank: 6,
          ulbName: 'Nagar Panchayat, Kapkot',
          fleetActive: '1/1 (100.0%)',
          routeCoverage: 62.10,
          tripsDone: 0,
          notReporting: '0% (0)',
          score: 81,
        ),
        UlbProgressItem(
          rank: 7,
          ulbName: 'Nagar Nigam, Kashipur',
          fleetActive: '32/36 (88.0%)',
          routeCoverage: 71.23,
          tripsDone: 403,
          notReporting: '11% (4)',
          score: 80,
        ),
        UlbProgressItem(
          rank: 8,
          ulbName: 'Nagar Nigam, Almora',
          fleetActive: '6/7 (85.0%)',
          routeCoverage: 67.84,
          tripsDone: 0,
          notReporting: '14% (1)',
          score: 76,
        ),
      ];
}

