import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../../passport_exports.dart';

class TravelDocumentTabHeader extends StatelessWidget {
  final TravelDocumentModel passport;
  const TravelDocumentTabHeader({super.key, required this.passport});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Icon(LineIcons.passport, size: 50, color: AppColors.primaryColor),
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(2),
                child: Icon(
                  getTypeIcon(passport.passportType),
                  size: 18,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text(
                passport.fullName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "TravelDocument No: ${passport.passportNumber}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Type: ${passport.passportType}",
                style: const TextStyle(fontSize: 16),
              ),
              TravelDocumentExpiryLabel(
                expiryDate: passport.expiryDate,
                isExpired: passport.expiryDate.isBefore(DateTime.now()),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: IconButton(
                  icon: const Icon(Icons.more_vert, size: 22),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return Center(
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 220),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 40,
                              ),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Manage passport #${passport.passportNumber}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.defaultColor400,
                                      ),
                                    ),
                                  ),

                                  OptionButton(
                                    context: context,
                                    text: 'Edit',
                                    icon: LineIcons.editAlt,
                                    onTap: () {
                                      // AppNavigator.pop(dialogContext);

                                      AppNavigator.push(
                                        context,
                                        BlocProvider.value(
                                          value: sl<TravelDocumentBloc>(),
                                          child: AddEditTravelDocumentPage(
                                            passport: passport,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const Divider(
                                    color: AppColors.defaultColor100,
                                  ),
                                  OptionButton(
                                    context: context,
                                    text: 'Delete',
                                    icon: LineIcons.alternateTrash,
                                    isDelete: true,
                                    onTap: () {
                                      AppNavigator.pop(dialogContext);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              FutureBuilder<Map?>(
                future: getCountryFlag(passport.nationality),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Text(
                      snapshot.data!["flag"],
                      style: const TextStyle(fontSize: 16),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
