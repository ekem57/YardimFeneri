class ErrorText {
  static String goster(String hataKodu) {
    switch (hataKodu) {
      case 'invalid-email':
        return "Geçersiz e-posta adresi! Lütfen e-posta adresinizi kontrol ediniz!";

      case 'wrong-password':
        return "Hatalı şifre! Lütfen şifrenizi kontrol ediniz";

      case 'user-not-found':
        return "Böyle bir kullanıcı bulunamadı!";

      case '[firebase_auth/email-already-in-use] The email address is already in use by another account.':
        return "Bu email adresi daha önce alınmış.";

      default:
        return "Bir hata olustu";
    }

  }
}
