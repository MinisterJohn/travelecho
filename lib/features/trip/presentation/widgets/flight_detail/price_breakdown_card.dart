import 'package:flutter/material.dart';
import '../../../trip_exports.dart';

class PriceBreakdownCard extends StatelessWidget {
  final String baseFare;
  final String totalTaxes;
  // final List<Map> fees;
  final String total;

  const PriceBreakdownCard({
    Key? key,
    required this.baseFare,
    required this.totalTaxes,
    // required this.fees,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildSectionCard(
      'Price Breakdown',
      Icons.attach_money,
      [
        _buildPriceRow('Base Fare', baseFare, Icons.monetization_on),
        _buildPriceRow('Taxes', totalTaxes, Icons.account_balance),
        // if (fees.isNotEmpty)
        //   for (var fee in fees)
        //     _buildPriceRow(
        //       fee['type'] ?? 'Unknown Fee',
        //       fee['amount'] ?? '0',
        //       Icons.receipt,
        //     ),
        const Divider(height: 24),
        _buildPriceRow('Total', total, Icons.payments, isTotal: true),
      ],
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primaryColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, IconData icon,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon,
              size: 18, color: isTotal ? AppColors.primaryColor : Colors.grey),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.primaryColor : Colors.grey,
            ),
          ),
          const Spacer(),
          Text(
            "\$${double.tryParse(value)?.toStringAsFixed(2) ?? '0.00'}",
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.primaryColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
