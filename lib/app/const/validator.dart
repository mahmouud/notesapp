const String messageempt = "can not be empty";
const String messagemax = "cant not be max than";
const String messagemain = "can not be main than";

ValidInput(String values, int max, int main) {
  if (values.isEmpty) {
    return messageempt;
  }
  if (values.length > max) {
    return "$messagemax $max";
  }
  if (values.length < main) {
    return "$messagemain $main";
  }
}
