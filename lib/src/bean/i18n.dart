class I18n {

  FooterWidget footerWidget;

  I18n({this.footerWidget});

  I18n.fromJson(Map<String, dynamic> json) {
    footerWidget = json['footerWidget'];
  }
}

class FooterWidget {
  String loadingText;

  String noDataText;

  String idleText;

  String failedText;
}

