import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class Email {
  sendMail({String userEmail, String resetcode}) async {
    String userName = 'httpnordjs@gmail.com'; // add company email here
    String password = '@pass@word'; // add my password here

    final smtpServer = gmail(userName, password);

    final message = Message()
      ..from = Address(userName)
      ..recipients.add(userEmail)
      ..subject = 'http_nordjs password recovery'
      ..html =
          "<h2> reset code: $resetcode </h2><h3> Thanks for connecting with us </h3>\n <p></p>";

    try {
      final sendReport = await send(message, smtpServer);
      print(sendReport.toString());
      print('email was sent');
    } on MailerException catch (e) {
      print(e.toString());
      print('email was not sent');
    }
  }
}
