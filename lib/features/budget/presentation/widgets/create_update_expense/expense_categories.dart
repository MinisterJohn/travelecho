import "package:flutter/widgets.dart";
import "package:line_icons/line_icons.dart";

import "../../../budget_exports.dart";

List<ExpenseCategoryModel> expenseCategories = [
  ExpenseCategoryModel(
    name: 'Flights & Transport',
    description:
        "Airfare, trains, buses, car rentals, or ride-hailing during the trip.",
    icon: Icon(LineIcons.plane),
  ),
  ExpenseCategoryModel(
    name: 'Accommodation',
    description: "Hotels, hostels, or other lodging expenses.",
    icon: Icon(LineIcons.hotel),
  ),
  ExpenseCategoryModel(
    name: 'Food & Dining',
    description: "Restaurants, cafés, street food, and snacks.",
    icon: Icon(LineIcons.utensils),
  ),
  ExpenseCategoryModel(
    name: 'Local Transport',
    description: "Taxis, bikes, scooters, metro, and intra-city transit.",
    icon: Icon(LineIcons.taxi),
  ),
  ExpenseCategoryModel(
    name: 'Activities & Tours',
    description:
        "Sightseeing, excursions, guided tours, tickets to attractions.",
    icon: Icon(LineIcons.binoculars),
  ),
  ExpenseCategoryModel(
    name: 'Travel Insurance',
    description: "Insurance for health, luggage, or trip cancellations.",
    icon: Icon(LineIcons.userShield),
  ),
  ExpenseCategoryModel(
    name: 'Shopping & Souvenirs',
    description: "Gifts, local crafts, and personal shopping.",
    icon: Icon(LineIcons.shoppingBag),
  ),
  ExpenseCategoryModel(
    name: 'Connectivity',
    description: "SIM cards, mobile data plans, internet cafés.",
    icon: Icon(LineIcons.wifi),
  ),
  ExpenseCategoryModel(
    name: 'Visa & Entry Fees',
    description: "Visa applications, entry fees at borders or attractions.",
    icon: Icon(LineIcons.passport),
  ),
  ExpenseCategoryModel(
    name: 'Tips & Donations',
    description: "Gratuities for services and charitable giving.",
    icon: Icon(LineIcons.handHoldingUsDollar),
  ),
  ExpenseCategoryModel(
    name: 'Currency Exchange',
    description: "Forex fees, exchange rates, and related charges.",
    icon: Icon(LineIcons.moneyBill),
  ),
  ExpenseCategoryModel(
    name: 'Health & Emergency',
    description: "Medical expenses, pharmacy visits, or emergency aid abroad.",
    icon: Icon(LineIcons.firstAid),
  ),
  ExpenseCategoryModel(
    name: 'Laundry & Toiletries',
    description: "Cleaning clothes, buying hygiene essentials on the road.",
    icon: Icon(LineIcons.shirtsInBulk),
  ),
  ExpenseCategoryModel(
    name: 'Travel Gear',
    description: "Backpacks, gadgets, adapters, or anything travel-related.",
    icon: Icon(LineIcons.briefcase),
  ),
  ExpenseCategoryModel(
    name: 'Miscellaneous',
    description: "Unexpected or uncategorized travel-related expenses.",
    icon: Icon(LineIcons.horizontalEllipsis),
  ),
];
