class TestMasterSelected {
  num? testKey;
  num? testRate;
  String? testShortCode;
  String? testName;
  bool testSelected;

  TestMasterSelected({
    this.testKey,
    this.testRate,
    this.testShortCode,
    this.testName,
    this.testSelected = false,
  });

  @override
  String toString() {
    return 'TestMasterSelected('
        'testKey: $testKey, '
        'testRate: $testRate, '
        'testShortCode: $testShortCode, '
        'testName: $testName, '
        'testSelected: $testSelected'
        ')';
  }
}
