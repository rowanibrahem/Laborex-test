enum PaymentType { cash, payLater }

extension PaymentTypeExtension on PaymentType {
  static PaymentType? fromString(String value) {
    switch (value) {
      case 'CASH':
        return PaymentType.cash;
      case 'PAY_LATER':
        return PaymentType.payLater;
      default:
        return null;
    }
  }

  String get name {
    switch (this) {
      case PaymentType.cash:
        return 'CASH';
      case PaymentType.payLater:
        return 'PAY_LATER';
      default:
        return 'UNKNOWN';
    }
  }

  String get arabicName {
    switch (this) {
      case PaymentType.cash:
        return 'فاتورة نقدا';
      case PaymentType.payLater:
        return 'فاتورة بالختم';
    }
  }
}

enum ReturnType { fullReturn, partialReturn, noReturn }

extension ReturnTypeExtension on ReturnType {
  static ReturnType? fromString(String value) {
    switch (value) {
      case 'FULL_REFUND':
        return ReturnType.fullReturn;
      case 'PARTIAL_REFUND':
        return ReturnType.partialReturn;
      case 'NO_REFUND':
        return ReturnType.noReturn;
      default:
        return null;
    }
  }

  String? get arabicName {
    switch (this) {
      case ReturnType.fullReturn:
        return 'مرتجع كلي';
      case ReturnType.partialReturn:
        return 'مرتجع جزئي';
      case ReturnType.noReturn:
        return 'بدون مرتجع';
      default:
        return null;
    }
  }

  String get name {
    switch (this) {
      case ReturnType.fullReturn:
        return 'FULL_REFUND';
      case ReturnType.partialReturn:
        return 'PARTIAL_REFUND';
      case ReturnType.noReturn:
        return 'NO_REFUND';
    }
  }
}
