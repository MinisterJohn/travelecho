import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../../passport_exports.dart';

class TravelDocumentCard extends StatelessWidget {
  final TravelDocumentModel passport;
  final bool isExpired;

  const TravelDocumentCard({
    super.key,
    required this.passport,
    this.isExpired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      // margin: const EdgeInsets.symmetric(vertical: 6/, horizontal: 4),
      child: Container(
        width: 320,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Icon(
                  LineIcons.passport,
                  size: 50,
                  color: AppColors.primaryColor,
                ),
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
                children: [
                  Text(
                    passport.fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'TravelDocument No: ${passport.passportNumber ?? ''}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Type: ${passport.passportType ?? ''}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  TravelDocumentExpiryLabel(
                    expiryDate: passport.expiryDate,
                    isExpired: isExpired,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  constraints: const BoxConstraints(
                                    maxWidth: 220,
                                  ),
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
                                        text: 'View',
                                        icon: LineIcons.eye,
                                        onTap: () {
                                          // AppNavigator.pop(dialogContext);

                                          AppNavigator.push(
                                            context,
                                            BlocProvider.value(
                                              value: sl<TravelDocumentBloc>(),
                                              child: ViewTravelDocumentPage(
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
                                        onTap: () async {
                                          await showDialog(
                                            context: context,
                                            builder:
                                                (ctx) => AlertDialog(
                                                  title: const Text(
                                                    'Delete TravelDocument',
                                                  ),
                                                  content: Text(
                                                    'Are you sure you want to delete passport #${passport.passportNumber}?',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed:
                                                          () =>
                                                              AppNavigator.pop(
                                                                ctx,
                                                              ),
                                                      child: const Text(
                                                        'Cancel',
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                          ctx,
                                                        ); // Close the dialog first
                                                        context
                                                            .read<
                                                              TravelDocumentBloc
                                                            >()
                                                            .add(
                                                              DeleteTravelDocumentEvent(
                                                                passport.id,
                                                              ),
                                                            );
                                                        // Do NOT show success message here; handle it in a BlocListener after actual deletion
                                                      },
                                                      child: const Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          );
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
                        return Row(
                          spacing: 2,
                          children: [
                            Text(
                              snapshot.data!["code"],
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              snapshot.data!["flag"],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
