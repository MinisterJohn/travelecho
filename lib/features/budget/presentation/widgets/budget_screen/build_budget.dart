import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import '../../../budget_exports.dart';

class BuildBudget extends StatelessWidget {
  final BudgetModel budget;

  const BuildBudget({Key? key, required this.budget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Center(
            child: Icon(
              LineIcons.wallet,
              size: 24,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                budget.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "${budget.currency} ${budget.plannedAmount}",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(LineIcons.cog),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
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
                          OptionButton(
                            context: context,
                            text: 'View ${budget.name}',
                            icon: LineIcons.eye,
                            onTap: () {},
                          ),
                          const Divider(color: AppColors.defaultColor100),
                          OptionButton(
                            context: context,
                            text: 'Edit ${budget.name}',
                            icon: LineIcons.editAlt,
                            onTap: () {
                              AppNavigator.push(
                                context,
                                BlocProvider.value(
                                  value: sl<BudgetBloc>(),
                                  child: NewBudgetPage(budget: budget),
                                ),
                              );
                            },
                          ),
                          const Divider(color: AppColors.defaultColor100),
                          OptionButton(
                            context: context,
                            text: 'Add Expenses to ${budget.name}',
                            icon: LineIcons.editAlt,
                            onTap: () {},
                          ),
                          const Divider(color: AppColors.defaultColor100),
                          OptionButton(
                            context: context,
                            text: 'Delete ${budget.name}',
                            icon: LineIcons.alternateTrash,
                            onTap: () {
                              
                            },
                            isDelete: true,
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
      ],
    );
  }
}
