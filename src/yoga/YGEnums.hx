/*
 * fib_yoga - Yoga Layout enum types for Fiberus
 *
 * Enum abstracts mapping to Yoga C integer enums.
 * Each variant's @:native value is the flat C enum constant name.
 */
package yoga;

@:unreflective
extern enum abstract YGAlign(Int) {
	@:native("YGAlignAuto") var Auto;
	@:native("YGAlignFlexStart") var FlexStart;
	@:native("YGAlignCenter") var Center;
	@:native("YGAlignFlexEnd") var FlexEnd;
	@:native("YGAlignStretch") var Stretch;
	@:native("YGAlignBaseline") var Baseline;
	@:native("YGAlignSpaceBetween") var SpaceBetween;
	@:native("YGAlignSpaceAround") var SpaceAround;
	@:native("YGAlignSpaceEvenly") var SpaceEvenly;
}

@:unreflective
extern enum abstract YGBoxSizing(Int) {
	@:native("YGBoxSizingBorderBox") var BorderBox;
	@:native("YGBoxSizingContentBox") var ContentBox;
}

@:unreflective
extern enum abstract YGDirection(Int) {
	@:native("YGDirectionInherit") var Inherit;
	@:native("YGDirectionLTR") var LTR;
	@:native("YGDirectionRTL") var RTL;
}

@:unreflective
extern enum abstract YGDisplay(Int) {
	@:native("YGDisplayFlex") var Flex;
	@:native("YGDisplayNone") var None;
	@:native("YGDisplayContents") var Contents;
}

@:unreflective
extern enum abstract YGEdge(Int) {
	@:native("YGEdgeLeft") var Left;
	@:native("YGEdgeTop") var Top;
	@:native("YGEdgeRight") var Right;
	@:native("YGEdgeBottom") var Bottom;
	@:native("YGEdgeStart") var Start;
	@:native("YGEdgeEnd") var End;
	@:native("YGEdgeHorizontal") var Horizontal;
	@:native("YGEdgeVertical") var Vertical;
	@:native("YGEdgeAll") var All;
}

@:unreflective
extern enum abstract YGFlexDirection(Int) {
	@:native("YGFlexDirectionColumn") var Column;
	@:native("YGFlexDirectionColumnReverse") var ColumnReverse;
	@:native("YGFlexDirectionRow") var Row;
	@:native("YGFlexDirectionRowReverse") var RowReverse;
}

@:unreflective
extern enum abstract YGGutter(Int) {
	@:native("YGGutterColumn") var Column;
	@:native("YGGutterRow") var Row;
	@:native("YGGutterAll") var All;
}

@:unreflective
extern enum abstract YGJustify(Int) {
	@:native("YGJustifyFlexStart") var FlexStart;
	@:native("YGJustifyCenter") var Center;
	@:native("YGJustifyFlexEnd") var FlexEnd;
	@:native("YGJustifySpaceBetween") var SpaceBetween;
	@:native("YGJustifySpaceAround") var SpaceAround;
	@:native("YGJustifySpaceEvenly") var SpaceEvenly;
}

@:unreflective
extern enum abstract YGNodeType(Int) {
	@:native("YGNodeTypeDefault") var Default;
	@:native("YGNodeTypeText") var Text;
}

@:unreflective
extern enum abstract YGOverflow(Int) {
	@:native("YGOverflowVisible") var Visible;
	@:native("YGOverflowHidden") var Hidden;
	@:native("YGOverflowScroll") var Scroll;
}

@:unreflective
extern enum abstract YGPositionType(Int) {
	@:native("YGPositionTypeStatic") var Static;
	@:native("YGPositionTypeRelative") var Relative;
	@:native("YGPositionTypeAbsolute") var Absolute;
}

@:unreflective
extern enum abstract YGUnit(Int) {
	@:native("YGUnitUndefined") var Undefined;
	@:native("YGUnitPoint") var Point;
	@:native("YGUnitPercent") var Percent;
	@:native("YGUnitAuto") var Auto;
	@:native("YGUnitMaxContent") var MaxContent;
	@:native("YGUnitFitContent") var FitContent;
	@:native("YGUnitStretch") var UnitStretch;
}

@:unreflective
extern enum abstract YGWrap(Int) {
	@:native("YGWrapNoWrap") var NoWrap;
	@:native("YGWrapWrap") var Wrap;
	@:native("YGWrapWrapReverse") var WrapReverse;
}
