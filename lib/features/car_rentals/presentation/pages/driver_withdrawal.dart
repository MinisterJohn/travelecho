import 'package:flutter/material.dart';
import '../../../features_exports.dart';

class DriverWithdrawalScreen extends StatefulWidget {
  const DriverWithdrawalScreen({super.key});

  @override
  State<DriverWithdrawalScreen> createState() => _DriverWithdrawalScreenState();
}

class _DriverWithdrawalScreenState extends State<DriverWithdrawalScreen> {
  double availableBalance = 230;
  List<double> quickAmounts = [50, 100, 1000];
  double? selectedAmount;
  TextEditingController customAmountController = TextEditingController();

  String selectedBank = "456749"; // Example card number

  void _onQuickAmountTap(double amount) {
    setState(() {
      selectedAmount = amount;
      customAmountController.text = amount.toStringAsFixed(0);
    });
  }

  void _showBankSelectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select withdrawal account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              WidgetsSpacer.verticalSpacer16,
              ListTile(
                leading: const Icon(Icons.credit_card,
                    color: AppColors.primaryColor, size: 32),
                title: Text(
                  "****${getMaskedCard(selectedBank)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    color: AppColors.primaryColor, size: 18),
                onTap: () {
                  // Select account logic
                },
              ),
              WidgetsSpacer.verticalSpacer20,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => const WithdrawalConfirmationPopup(),
                    );
                    if (confirmed == true) {
                      Navigator.pop(context); // Dismiss bottom sheet
                      // Proceed with withdrawal logic
                    }
                  },
                  child: const Text(
                    "Proceed",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String getMaskedCard(String cardNumber) {
    if (cardNumber.length < 4) return "****";
    return "****${cardNumber.substring(cardNumber.length - 4)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: WidgetsSpacer.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetsSpacer.verticalSpacer16,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Available balance",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 15,
                      ),
                    ),
                    WidgetsSpacer.verticalSpacer8,
                    Text(
                      "\$${availableBalance.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
              WidgetsSpacer.verticalSpacer20,
              const Text(
                "How much would you like to withdraw",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              WidgetsSpacer.verticalSpacer16,
              Row(
                children: quickAmounts.map((amount) {
                  final isSelected = selectedAmount == amount;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => _onQuickAmountTap(amount),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.primaryColor100,
                          borderRadius: BorderRadius.circular(8),
                          border: isSelected
                              ? Border.all(
                                  color: AppColors.primaryColor,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Text(
                          "\$${amount.toStringAsFixed(0)}",
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              WidgetsSpacer.verticalSpacer16,
              const Text(
                "or enter custom amount",
                style: TextStyle(fontSize: 15),
              ),
              WidgetsSpacer.verticalSpacer8,
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "\$",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  WidgetsSpacer.horizontalSpacer8,
                  Expanded(
                    child: TextField(
                      controller: customAmountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Amount",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          selectedAmount = double.tryParse(
                            val.replaceAll("\$", ""),
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
              WidgetsSpacer.verticalSpacer20,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: const Size(double.infinity, 0),
                ),
                onPressed: selectedAmount != null && selectedAmount! > 0
                    ? _showBankSelectionSheet
                    : null,
                child: const Text(
                  "Continue to Bank Selection",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              WidgetsSpacer.verticalSpacer16,
              Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.primaryColor,
                    size: 18,
                  ),
                  WidgetsSpacer.horizontalSpacer8,
                  const Expanded(
                    child: Text(
                      "Withdrawals are typically processed within 24 hours during business days",
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WithdrawalConfirmationPopup extends StatelessWidget {
  const WithdrawalConfirmationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: const Text(
        "Are you sure you want to proceed?",
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            "Yes",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            "No",
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
} 