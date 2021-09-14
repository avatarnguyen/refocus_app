class StringMatcher {
  // on Sep 13
  static RegExp matcherDueDate =
      RegExp(r'(on)( ?)([A-Z]{1})([a-z]{2})( ?)\d{1,2}');
  static RegExp matcherRemindDate = RegExp(
      r'([?]|[remind]{3,6}|[alrm]{3,6})( ?)(([Ttodaymrw]{4,8})|([A-Z]{1})([a-z]{2})( ?)\d{1,2})');
  static RegExp matcherRemindTime = RegExp(
      r'((at ?)((([0-1]?\d)|(2[0-3]))(:|\.|)?[0-5][0-9]|((0?[1-9])|(1[0-2]))(:|\.|)([0-5][0-9]))(( ||,)([aA]|[pP])[mM]|([aA]|[pP])[mM])?)');
  static RegExp matcherPrio = RegExp('!{1,3}');
  //Today, tomorrow
  static RegExp matcherDay = RegExp('([Ttoday]{4,5}|[Ttomrw]{7,8})');
  // Sep 13
  static RegExp matcherMonthDay = RegExp(r'([A-Z]{1})([a-z]{2})( ?)\d{1,2}');
  // Monday, Tuesday, ..., Sunday
  static RegExp matcherWeekDay =
      RegExp('(([MTWSF]|[mtwsf]{1})[a-z]{2,5}(day))');
}
