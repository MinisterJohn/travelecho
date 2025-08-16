import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class CarRentalsCallScreen extends StatefulWidget {
  const CarRentalsCallScreen({super.key});

  @override
  State<CarRentalsCallScreen> createState() => _CarRentalsCallScreenState();
}

class _CarRentalsCallScreenState extends State<CarRentalsCallScreen> {
  bool isMuted = false;
  bool isSpeakerOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: appBarIconButton(context, null),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: WidgetsSpacer.pagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9F5CFF), Color(0xFF6E56FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundImage: AssetImage(
                        "assets/images/driver_avatar.png",
                      ),
                    ),
                    WidgetsSpacer.verticalSpacer60,
                    const Text(
                      "Charlie Davison",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    WidgetsSpacer.verticalSpacer16,
                    const Text(
                      "00:46",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    WidgetsSpacer.verticalSpacer60,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Mute button
                        CircleAvatar(
                          radius: 26,
                          backgroundColor:
                              isMuted
                                  ? AppColors.white
                                  : AppColors.primaryColor.withOpacity(0.25),
                          child: IconButton(
                            icon: Icon(
                              Icons.mic_off,
                              color:
                                  isMuted
                                      ? Colors.black54
                                      : AppColors.primaryColor,
                              size: 28,
                            ),
                            onPressed: () {
                              setState(() {
                                isMuted = !isMuted;
                              });
                            },
                          ),
                        ),
                        WidgetsSpacer.horizontalSpacer40,
                        // Speaker button
                        CircleAvatar(
                          radius: 26,
                          backgroundColor:
                              isSpeakerOn
                                  ? AppColors.white
                                  : AppColors.white.withOpacity(0.5),
                          child: IconButton(
                            icon: Icon(
                              Icons.volume_up,
                              color:
                                  isSpeakerOn
                                      ? Colors.black54
                                      : AppColors.primaryColor, 
                              size: 28,
                            ),
                            onPressed: () {
                              setState(() {
                                isSpeakerOn = !isSpeakerOn;
                              });
                            },
                          ),
                        ),
                        WidgetsSpacer.horizontalSpacer40,
                        // End call button
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.redAccent,
                          child: IconButton(
                            icon: const Icon(
                              Icons.call_end,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
