class Constants {
  //testing server
  // static const baseUrl = 'https://dms.ebdaa-business.com/api/v1';
  //production server
  static const baseUrl = 'http://203.161.54.164:5152/api/v1';
  static const getOrdersUrl = '$baseUrl/order/driver-orders';
  static const loginUrl = '$baseUrl/auth/login';
  static const deliveryStartUrl = '$baseUrl/order/delivery-start/';
  static const finishOrderUrl = '$baseUrl/order/finish-order/';
}
