import 'dart:convert';

String encryptPassword(String modules, String password,
    {String publicExponent = "10001"}) {
  // 将 modulus 和 exponent 转换为大整数
  BigInt publicModulus = BigInt.parse(modules, radix: 16);
  BigInt publicExponentInt = BigInt.parse(publicExponent, radix: 16);

  // 反转密码字符串
  String reversedPassword = password.split('').reversed.join();

  // 使用完全等效的方式将密码编码为十六进制
  List<int> encodedBytes =
      utf8.encode(reversedPassword.split('').reversed.join());

  // 转为十六进制字符串
  String hexPassword =
      encodedBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

  BigInt plaintext = BigInt.parse(hexPassword, radix: 16);

  BigInt encryptedPassword = plaintext.modPow(publicExponentInt, publicModulus);

  return encryptedPassword.toRadixString(16);
}

