class StringMatcher {
  static RegExp matcherDueDate = RegExp(
      r'([on]{2}( |)+([MTWFS]{1})+(\w{2})+(, |,)+(0?[1-9]|1[0-2])[\/](0?[1-9]|[12]\d|3[01])[\/](19|20)\d{2})');
  static RegExp matcherRemindDate = RegExp(
      r'([?]|[remind]{3,6}|[alrm]{3,6})( ?)(([on]*)( ?)([MTWFS]+)(\w{2})(,?)( ?)(0?[1-9]|1[0-2])[\/](0?[1-9]|[12]\d|3[01])[\/](19|20)\d{2})');
  static RegExp matcherRemindTime = RegExp(
      r'((at ?)((([0-1]?\d)|(2[0-3]))(:|\.|)?[0-5][0-9]|((0?[1-9])|(1[0-2]))(:|\.|)([0-5][0-9]))(( ||,)([aA]|[pP])[mM]|([aA]|[pP])[mM])?)');
  static RegExp matcherPrio = RegExp('!{1,3}');
}
