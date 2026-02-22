package;

class TestMain {
	static function main() {
		var framework = new TestFramework();

		trace("--- TestYoga ---");
		var yogaTests = new TestYoga();
		yogaTests.setFramework(framework);
		yogaTests.runTests();

		trace("");
		framework.printSummary();
	}
}
