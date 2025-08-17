import '../../milestones_exports.dart';

String getRequirementText(BadgeEntity badge) {
  switch (badge.operator) {
    case 'GTE':
      return 'Your total ${badge.category} should be greater than or equal to ${badge.value} to earn this badge';
    case 'LTE':
      return 'Your total ${badge.category} should be less than or equal to ${badge.value} to earn this badge';
    case 'EQ':
      return 'Your total ${badge.category} should be equal to ${badge.value} to earn this badge';
    case 'LT':
      return 'Your total ${badge.category} should be less than ${badge.value} to earn this badge';
    case 'GT':
      return 'Your total ${badge.category} should be greater than ${badge.value} to earn this badge';
    default:
      return 'Your total ${badge.category} should be ${badge.operator} ${badge.value} to earn this badge';
  }
}
