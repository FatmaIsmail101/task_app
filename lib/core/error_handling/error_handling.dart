class TestErrorHandle implements Exception{
  final String message;
  TestErrorHandle(this.message);
  @override
  String toString() =>message;
}