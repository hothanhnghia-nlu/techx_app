
class PaymentMethod {
  final String name;
  final String iconUrl;
  final String description;

  PaymentMethod({
    required this.name,
    required this.iconUrl,
    required this.description
  });
}

List<PaymentMethod> paymentMethods = [
  PaymentMethod(
      name: 'Tiền mặt khi nhận hàng',
      iconUrl: 'assets/cod_payment.png',
      description: 'Thanh toán khi nhận hàng'),
  PaymentMethod(
      name: 'VNPAY',
      iconUrl: 'assets/vnpay_payment.png',
      description: 'Thanh toán qua VNPAY'),
  PaymentMethod(
      name: 'Thẻ Tín dụng/Ghi nợ',
      iconUrl: 'assets/visa_payment.png',
      description: 'Thanh toán bằng thẻ tín dụng'),
  PaymentMethod(
      name: 'Thẻ ATM (Internet Banking)',
      iconUrl: 'assets/atm_payment.png',
      description: 'Chuyển khoản ngân hàng'),
];
