package;

import yoga.Yoga;
import yoga.YGEnums;
import yoga.YGNodeRef;

class TestYoga extends Test {
	public function runTests() {
		testNodeCreateFree();
		testBasicLayout();
		testFlexRow();
		testFlexColumn();
		testPadding();
		testMargin();
		testNestedLayout();
		testEnumValues();
		testChildManagement();
	}

	function testNodeCreateFree() {
		framework.startTest("testNodeCreateFree");
		var node = Yoga.nodeNew();
		// YGNodeRef is @:notNull — just verify it doesn't crash
		Yoga.nodeFree(node);
		noAssert();
	}

	function testBasicLayout() {
		framework.startTest("testBasicLayout");
		var root = Yoga.nodeNew();
		Yoga.styleSetWidth(root, 100);
		Yoga.styleSetHeight(root, 200);
		Yoga.calculateLayout(root, cast Math.NaN, cast Math.NaN, YGDirection.LTR);

		// Width and height should match what we set
		feq(100.0, Yoga.layoutGetWidth(root));
		feq(200.0, Yoga.layoutGetHeight(root));
		// Position should be 0,0
		feq(0.0, Yoga.layoutGetLeft(root));
		feq(0.0, Yoga.layoutGetTop(root));

		Yoga.nodeFreeRecursive(root);
	}

	function testFlexRow() {
		framework.startTest("testFlexRow");
		var root = Yoga.nodeNew();
		Yoga.styleSetWidth(root, 300);
		Yoga.styleSetHeight(root, 100);
		Yoga.styleSetFlexDirection(root, YGFlexDirection.Row);

		var child1 = Yoga.nodeNew();
		Yoga.styleSetFlexGrow(child1, 1);
		Yoga.nodeInsertChild(root, child1, 0);

		var child2 = Yoga.nodeNew();
		Yoga.styleSetFlexGrow(child2, 2);
		Yoga.nodeInsertChild(root, child2, 1);

		Yoga.calculateLayout(root, cast Math.NaN, cast Math.NaN, YGDirection.LTR);

		// child1 gets 1/3 of 300 = 100, child2 gets 2/3 = 200
		feq(100.0, Yoga.layoutGetWidth(child1));
		feq(200.0, Yoga.layoutGetWidth(child2));
		// Both fill height
		feq(100.0, Yoga.layoutGetHeight(child1));
		feq(100.0, Yoga.layoutGetHeight(child2));
		// child1 at x=0, child2 at x=100
		feq(0.0, Yoga.layoutGetLeft(child1));
		feq(100.0, Yoga.layoutGetLeft(child2));

		Yoga.nodeFreeRecursive(root);
	}

	function testFlexColumn() {
		framework.startTest("testFlexColumn");
		var root = Yoga.nodeNew();
		Yoga.styleSetWidth(root, 100);
		Yoga.styleSetHeight(root, 300);
		Yoga.styleSetFlexDirection(root, YGFlexDirection.Column);

		var child1 = Yoga.nodeNew();
		Yoga.styleSetFlexGrow(child1, 1);
		Yoga.nodeInsertChild(root, child1, 0);

		var child2 = Yoga.nodeNew();
		Yoga.styleSetFlexGrow(child2, 1);
		Yoga.nodeInsertChild(root, child2, 1);

		Yoga.calculateLayout(root, cast Math.NaN, cast Math.NaN, YGDirection.LTR);

		// Each child gets 150 height (300/2)
		feq(150.0, Yoga.layoutGetHeight(child1));
		feq(150.0, Yoga.layoutGetHeight(child2));
		// child1 at y=0, child2 at y=150
		feq(0.0, Yoga.layoutGetTop(child1));
		feq(150.0, Yoga.layoutGetTop(child2));

		Yoga.nodeFreeRecursive(root);
	}

	function testPadding() {
		framework.startTest("testPadding");
		var root = Yoga.nodeNew();
		Yoga.styleSetWidth(root, 200);
		Yoga.styleSetHeight(root, 200);
		Yoga.styleSetPadding(root, YGEdge.All, 10);

		var child = Yoga.nodeNew();
		Yoga.styleSetFlexGrow(child, 1);
		Yoga.nodeInsertChild(root, child, 0);

		Yoga.calculateLayout(root, cast Math.NaN, cast Math.NaN, YGDirection.LTR);

		// Child should be inset by 10px on all sides
		feq(10.0, Yoga.layoutGetLeft(child));
		feq(10.0, Yoga.layoutGetTop(child));
		feq(180.0, Yoga.layoutGetWidth(child));
		feq(180.0, Yoga.layoutGetHeight(child));

		Yoga.nodeFreeRecursive(root);
	}

	function testMargin() {
		framework.startTest("testMargin");
		var root = Yoga.nodeNew();
		Yoga.styleSetWidth(root, 200);
		Yoga.styleSetHeight(root, 200);

		var child = Yoga.nodeNew();
		Yoga.styleSetWidth(child, 100);
		Yoga.styleSetHeight(child, 100);
		Yoga.styleSetMargin(child, YGEdge.Left, 20);
		Yoga.styleSetMargin(child, YGEdge.Top, 30);
		Yoga.nodeInsertChild(root, child, 0);

		Yoga.calculateLayout(root, cast Math.NaN, cast Math.NaN, YGDirection.LTR);

		feq(20.0, Yoga.layoutGetLeft(child));
		feq(30.0, Yoga.layoutGetTop(child));
		feq(100.0, Yoga.layoutGetWidth(child));
		feq(100.0, Yoga.layoutGetHeight(child));

		Yoga.nodeFreeRecursive(root);
	}

	function testNestedLayout() {
		framework.startTest("testNestedLayout");
		var root = Yoga.nodeNew();
		Yoga.styleSetWidth(root, 400);
		Yoga.styleSetHeight(root, 400);
		Yoga.styleSetFlexDirection(root, YGFlexDirection.Column);

		// Top bar: fixed height
		var topBar = Yoga.nodeNew();
		Yoga.styleSetHeight(topBar, 50);
		Yoga.nodeInsertChild(root, topBar, 0);

		// Content area: flex grow fills remaining space
		var content = Yoga.nodeNew();
		Yoga.styleSetFlexGrow(content, 1);
		Yoga.styleSetFlexDirection(content, YGFlexDirection.Row);
		Yoga.nodeInsertChild(root, content, 1);

		// Sidebar: fixed width
		var sidebar = Yoga.nodeNew();
		Yoga.styleSetWidth(sidebar, 80);
		Yoga.nodeInsertChild(content, sidebar, 0);

		// Main: flex grow fills remaining width
		var main = Yoga.nodeNew();
		Yoga.styleSetFlexGrow(main, 1);
		Yoga.nodeInsertChild(content, main, 1);

		Yoga.calculateLayout(root, cast Math.NaN, cast Math.NaN, YGDirection.LTR);

		// Top bar: 400x50 at (0,0)
		feq(0.0, Yoga.layoutGetLeft(topBar));
		feq(0.0, Yoga.layoutGetTop(topBar));
		feq(400.0, Yoga.layoutGetWidth(topBar));
		feq(50.0, Yoga.layoutGetHeight(topBar));

		// Content: 400x350 at (0,50)
		feq(0.0, Yoga.layoutGetLeft(content));
		feq(50.0, Yoga.layoutGetTop(content));
		feq(400.0, Yoga.layoutGetWidth(content));
		feq(350.0, Yoga.layoutGetHeight(content));

		// Sidebar: 80x350 at (0,0) within content
		feq(0.0, Yoga.layoutGetLeft(sidebar));
		feq(0.0, Yoga.layoutGetTop(sidebar));
		feq(80.0, Yoga.layoutGetWidth(sidebar));
		feq(350.0, Yoga.layoutGetHeight(sidebar));

		// Main: 320x350 at (80,0) within content
		feq(80.0, Yoga.layoutGetLeft(main));
		feq(0.0, Yoga.layoutGetTop(main));
		feq(320.0, Yoga.layoutGetWidth(main));
		feq(350.0, Yoga.layoutGetHeight(main));

		Yoga.nodeFreeRecursive(root);
	}

	function testEnumValues() {
		framework.startTest("testEnumValues");
		// Verify enum values are usable (no crash, correct int mapping)
		var root = Yoga.nodeNew();
		Yoga.styleSetDisplay(root, YGDisplay.Flex);
		Yoga.styleSetOverflow(root, YGOverflow.Hidden);
		Yoga.styleSetPositionType(root, YGPositionType.Relative);
		Yoga.styleSetFlexWrap(root, YGWrap.Wrap);
		Yoga.styleSetAlignItems(root, YGAlign.Center);
		Yoga.styleSetJustifyContent(root, YGJustify.SpaceBetween);
		Yoga.styleSetBoxSizing(root, YGBoxSizing.BorderBox);
		Yoga.nodeFree(root);
		noAssert();
	}

	function testChildManagement() {
		framework.startTest("testChildManagement");
		var root = Yoga.nodeNew();
		var child1 = Yoga.nodeNew();
		var child2 = Yoga.nodeNew();

		Yoga.nodeInsertChild(root, child1, 0);
		Yoga.nodeInsertChild(root, child2, 1);
		eq(2, Yoga.nodeGetChildCount(root));

		Yoga.nodeRemoveChild(root, child1);
		eq(1, Yoga.nodeGetChildCount(root));

		Yoga.nodeRemoveAllChildren(root);
		eq(0, Yoga.nodeGetChildCount(root));

		Yoga.nodeFree(child1);
		Yoga.nodeFree(child2);
		Yoga.nodeFree(root);
	}
}
