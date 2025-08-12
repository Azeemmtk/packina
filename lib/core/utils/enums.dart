enum Status { pending, approved, blocked, rejected }

extension StatusExtension on Status {
  String get value {
    switch (this) {
      case Status.pending:
        return 'pending';
      case Status.approved:
        return 'approved';
      case Status.blocked:
        return 'blocked';
      case Status.rejected:
        return 'rejected';
    }
  }

  static Status fromString(String status) {
    switch (status) {
      case 'approved':
        return Status.approved;
      case 'blocked':
        return Status.blocked;
      case 'rejected':
        return Status.rejected;
      case 'pending':
      default:
        return Status.pending;
    }
  }
}
