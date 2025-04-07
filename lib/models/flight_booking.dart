// void updateTravelerCounts({
//   required int adults,
//   required int children,
//   required int infants,
// }) {
//   _adults = adults;
//   _children = children;
//   _infants = infants;
//   _calculateTotalPrice();
// }

// void _calculateTotalPrice() {
//   double totalPrice = 0.0;
  
//   // Calculate adult prices
//   for (var i = 0; i < _adults; i++) {
//     totalPrice += _adultPrice;
//   }
  
//   // Calculate child prices (75% of adult price)
//   for (var i = 0; i < _children; i++) {
//     totalPrice += _adultPrice * 0.75;
//   }
  
//   // Calculate infant prices (10% of adult price)
//   for (var i = 0; i < _infants; i++) {
//     totalPrice += _adultPrice * 0.10;
//   }
  
//   _totalPrice = totalPrice;
// } 