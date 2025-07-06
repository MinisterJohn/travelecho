import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../../../passport_exports.dart';

class TravelDocumentDetailsTab extends StatelessWidget {
  final TravelDocumentModel passport;
  const TravelDocumentDetailsTab({super.key, required this.passport});

  Widget _detailTile(IconData icon, String title, String value) {
    return Column(
      children: [
        ListTile(
          minTileHeight: 10,
          leading: Icon(icon, color: AppColors.primaryColor300),
          title: Text(title, style: const TextStyle(fontSize: 14)),
          subtitle: Text(value, style: const TextStyle(fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(color: AppColors.defaultColor100, height: 1),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _detailTile(
          LineIcons.passport,
          'TravelDocument Number',
          passport.passportNumber,
        ),
        _detailTile(LineIcons.user, 'Full Name', passport.fullName),
        _detailTile(LineIcons.flag, 'Nationality', passport.nationality),
        _detailTile(
          LineIcons.calendar,
          'Issue Date',
          formatDate(passport.issueDate),
        ),
        _detailTile(
          LineIcons.calendarCheck,
          'Expiry Date',
          formatDate(passport.expiryDate),
        ),
        if (passport.placeOfIssue != null)
          _detailTile(
            LineIcons.mapMarker,
            'Place of Issue',
            passport.placeOfIssue!,
          ),
        _detailTile(
          LineIcons.clock,
          'Created At',
          formatDate(passport.createdAt),
        ),
      ],
    );
  }
}
