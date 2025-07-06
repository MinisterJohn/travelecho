import 'package:flutter/widgets.dart';
import 'package:line_icons/line_icons.dart';

import '../../../budget_exports.dart';

List<ExpenseCategoryModel> expenseCategories = [
  ExpenseCategoryModel(
    name: 'Flights & Transport',
    description: "Airfare, trains, buses, car rentals, or ride-hailing during the trip.",
    icon: Icon(LineIcons.plane),
    color: Color(0xFF1E88E5), // Blue
  ),
  ExpenseCategoryModel(
    name: 'Accommodation',
    description: "Hotels, hostels, or other lodging expenses.",
    icon: Icon(LineIcons.hotel),
    color: Color(0xFF43A047), // Green
  ),
  ExpenseCategoryModel(
    name: 'Food & Dining',
    description: "Restaurants, cafés, street food, and snacks.",
    icon: Icon(LineIcons.utensils),
    color: Color(0xFFE53935), // Red
  ),
  ExpenseCategoryModel(
    name: 'Local Transport',
    description: "Taxis, bikes, scooters, metro, and intra-city transit.",
    icon: Icon(LineIcons.taxi),
    color: Color(0xFFFDD835), // Yellow
  ),
  ExpenseCategoryModel(
    name: 'Activities & Tours',
    description: "Sightseeing, excursions, guided tours, tickets to attractions.",
    icon: Icon(LineIcons.binoculars),
    color: Color(0xFF8E24AA), // Purple
  ),
  ExpenseCategoryModel(
    name: 'Travel Insurance',
    description: "Insurance for health, luggage, or trip cancellations.",
    icon: Icon(LineIcons.userShield),
    color: Color(0xFF00ACC1), // Cyan
  ),
  ExpenseCategoryModel(
    name: 'Shopping & Souvenirs',
    description: "Gifts, local crafts, and personal shopping.",
    icon: Icon(LineIcons.shoppingBag),
    color: Color(0xFFFF7043), // Deep Orange
  ),
  ExpenseCategoryModel(
    name: 'Connectivity',
    description: "SIM cards, mobile data plans, internet cafés.",
    icon: Icon(LineIcons.wifi),
    color: Color(0xFF5C6BC0), // Indigo
  ),
  ExpenseCategoryModel(
    name: 'Visa & Entry Fees',
    description: "Visa applications, entry fees at borders or attractions.",
    icon: Icon(LineIcons.passport),
    color: Color(0xFF6D4C41), // Brown
  ),
  ExpenseCategoryModel(
    name: 'Tips & Donations',
    description: "Gratuities for services and charitable giving.",
    icon: Icon(LineIcons.handHoldingUsDollar),
    color: Color(0xFF26A69A), // Teal
  ),
  ExpenseCategoryModel(
    name: 'Currency Exchange',
    description: "Forex fees, exchange rates, and related charges.",
    icon: Icon(LineIcons.moneyBill),
    color: Color(0xFFFFCA28), // Amber
  ),
  ExpenseCategoryModel(
    name: 'Health & Emergency',
    description: "Medical expenses, pharmacy visits, or emergency aid abroad.",
    icon: Icon(LineIcons.firstAid),
    color: Color(0xFFD32F2F), // Dark Red
  ),
  ExpenseCategoryModel(
    name: 'Laundry & Toiletries',
    description: "Cleaning clothes, buying hygiene essentials on the road.",
    icon: Icon(LineIcons.shirtsInBulk),
    color: Color(0xFF7CB342), // Light Green
  ),
  ExpenseCategoryModel(
    name: 'Travel Gear',
    description: "Backpacks, gadgets, adapters, or anything travel-related.",
    icon: Icon(LineIcons.briefcase),
    color: Color(0xFF00897B), // Dark Teal
  ),
  ExpenseCategoryModel(
    name: 'Miscellaneous',
    description: "Unexpected or uncategorized travel-related expenses.",
    icon: Icon(LineIcons.horizontalEllipsis),
    color: Color(0xFF9E9E9E), // Grey
  ),
];
