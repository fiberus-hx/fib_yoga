/*
 * fib_yoga - Yoga Layout extern for Fiberus
 *
 * Facebook's Yoga layout engine (flexbox). Direct C API bindings
 * using fiberus.Float32 for all dimension/layout values.
 *
 * Usage:
 *   var root = Yoga.nodeNew();
 *   Yoga.styleSetWidth(root, 500);
 *   Yoga.styleSetHeight(root, 300);
 *   Yoga.styleSetFlexDirection(root, YGFlexDirection.Row);
 *   Yoga.calculateLayout(root, cast Math.NaN, cast Math.NaN, YGDirection.LTR);
 *   var w = Yoga.layoutGetWidth(root);
 *   Yoga.nodeFreeRecursive(root);
 */
package yoga;

import yoga.YGEnums;
import yoga.YGNodeRef;

@:buildXml('
    <files id="__externs__">
        <compilerflag value="-std=c++20"/>
        <compilerflag value="-w"/>
    </files>
')
@:include("yoga/Yoga.h")
@:sourceFile("../../lib/yoga/YGConfig.cpp")
@:sourceFile("../../lib/yoga/YGEnums.cpp")
@:sourceFile("../../lib/yoga/YGNode.cpp")
@:sourceFile("../../lib/yoga/YGNodeLayout.cpp")
@:sourceFile("../../lib/yoga/YGNodeStyle.cpp")
@:sourceFile("../../lib/yoga/YGPixelGrid.cpp")
@:sourceFile("../../lib/yoga/YGValue.cpp")
@:sourceFile("../../lib/yoga/algorithm/AbsoluteLayout.cpp")
@:sourceFile("../../lib/yoga/algorithm/Baseline.cpp")
@:sourceFile("../../lib/yoga/algorithm/Cache.cpp")
@:sourceFile("../../lib/yoga/algorithm/CalculateLayout.cpp")
@:sourceFile("../../lib/yoga/algorithm/FlexLine.cpp")
@:sourceFile("../../lib/yoga/algorithm/PixelGrid.cpp")
@:sourceFile("../../lib/yoga/config/Config.cpp")
@:sourceFile("../../lib/yoga/debug/AssertFatal.cpp")
@:sourceFile("../../lib/yoga/debug/Log.cpp")
@:sourceFile("../../lib/yoga/event/event.cpp")
@:sourceFile("../../lib/yoga/node/LayoutResults.cpp")
@:sourceFile("../../lib/yoga/node/Node.cpp")
extern class Yoga {
	// ========================================================================
	// Node Lifecycle
	// ========================================================================

	@:native("YGNodeNew")
	static function nodeNew():YGNodeRef;

	@:native("YGNodeFree")
	static function nodeFree(node:YGNodeRef):Void;

	@:native("YGNodeFreeRecursive")
	static function nodeFreeRecursive(node:YGNodeRef):Void;

	@:native("YGNodeReset")
	static function nodeReset(node:YGNodeRef):Void;

	// ========================================================================
	// Child Management
	// ========================================================================

	@:native("YGNodeInsertChild")
	static function nodeInsertChild(node:YGNodeRef, child:YGNodeRef, index:fiberus.SizeT):Void;

	@:native("YGNodeRemoveChild")
	static function nodeRemoveChild(node:YGNodeRef, child:YGNodeRef):Void;

	@:native("YGNodeRemoveAllChildren")
	static function nodeRemoveAllChildren(node:YGNodeRef):Void;

	@:native("YGNodeGetChild")
	static function nodeGetChild(node:YGNodeRef, index:fiberus.SizeT):YGNodeRef;

	@:native("YGNodeGetChildCount")
	static function nodeGetChildCount(node:YGNodeRef):fiberus.SizeT;

	@:native("YGNodeGetOwner")
	static function nodeGetOwner(node:YGNodeRef):YGNodeRef;

	// ========================================================================
	// Layout Calculation
	// ========================================================================

	@:native("YGNodeCalculateLayout")
	static function calculateLayout(node:YGNodeRef, availableWidth:fiberus.Float32, availableHeight:fiberus.Float32, ownerDirection:YGDirection):Void;

	// ========================================================================
	// Node State
	// ========================================================================

	@:native("YGNodeGetHasNewLayout")
	static function nodeGetHasNewLayout(node:YGNodeRef):Bool;

	@:native("YGNodeSetHasNewLayout")
	static function nodeSetHasNewLayout(node:YGNodeRef, hasNewLayout:Bool):Void;

	@:native("YGNodeIsDirty")
	static function nodeIsDirty(node:YGNodeRef):Bool;

	@:native("YGNodeMarkDirty")
	static function nodeMarkDirty(node:YGNodeRef):Void;

	@:native("YGNodeSetNodeType")
	static function nodeSetNodeType(node:YGNodeRef, nodeType:YGNodeType):Void;

	@:native("YGNodeGetNodeType")
	static function nodeGetNodeType(node:YGNodeRef):YGNodeType;

	// ========================================================================
	// Layout Results (all return float = fiberus.Float32)
	// ========================================================================

	@:native("YGNodeLayoutGetLeft")
	static function layoutGetLeft(node:YGNodeRef):fiberus.Float32;

	@:native("YGNodeLayoutGetTop")
	static function layoutGetTop(node:YGNodeRef):fiberus.Float32;

	@:native("YGNodeLayoutGetRight")
	static function layoutGetRight(node:YGNodeRef):fiberus.Float32;

	@:native("YGNodeLayoutGetBottom")
	static function layoutGetBottom(node:YGNodeRef):fiberus.Float32;

	@:native("YGNodeLayoutGetWidth")
	static function layoutGetWidth(node:YGNodeRef):fiberus.Float32;

	@:native("YGNodeLayoutGetHeight")
	static function layoutGetHeight(node:YGNodeRef):fiberus.Float32;

	@:native("YGNodeLayoutGetDirection")
	static function layoutGetDirection(node:YGNodeRef):YGDirection;

	@:native("YGNodeLayoutGetHadOverflow")
	static function layoutGetHadOverflow(node:YGNodeRef):Bool;

	@:native("YGNodeLayoutGetMargin")
	static function layoutGetMargin(node:YGNodeRef, edge:YGEdge):fiberus.Float32;

	@:native("YGNodeLayoutGetBorder")
	static function layoutGetBorder(node:YGNodeRef, edge:YGEdge):fiberus.Float32;

	@:native("YGNodeLayoutGetPadding")
	static function layoutGetPadding(node:YGNodeRef, edge:YGEdge):fiberus.Float32;

	// ========================================================================
	// Style: Display, Overflow, Position, Direction, Flex Direction, Wrap
	// ========================================================================

	@:native("YGNodeStyleSetDisplay")
	static function styleSetDisplay(node:YGNodeRef, display:YGDisplay):Void;

	@:native("YGNodeStyleSetOverflow")
	static function styleSetOverflow(node:YGNodeRef, overflow:YGOverflow):Void;

	@:native("YGNodeStyleSetPositionType")
	static function styleSetPositionType(node:YGNodeRef, positionType:YGPositionType):Void;

	@:native("YGNodeStyleSetDirection")
	static function styleSetDirection(node:YGNodeRef, direction:YGDirection):Void;

	@:native("YGNodeStyleSetFlexDirection")
	static function styleSetFlexDirection(node:YGNodeRef, flexDirection:YGFlexDirection):Void;

	@:native("YGNodeStyleSetFlexWrap")
	static function styleSetFlexWrap(node:YGNodeRef, flexWrap:YGWrap):Void;

	// ========================================================================
	// Style: Alignment & Justify
	// ========================================================================

	@:native("YGNodeStyleSetAlignContent")
	static function styleSetAlignContent(node:YGNodeRef, alignContent:YGAlign):Void;

	@:native("YGNodeStyleSetAlignItems")
	static function styleSetAlignItems(node:YGNodeRef, alignItems:YGAlign):Void;

	@:native("YGNodeStyleSetAlignSelf")
	static function styleSetAlignSelf(node:YGNodeRef, alignSelf:YGAlign):Void;

	@:native("YGNodeStyleSetJustifyContent")
	static function styleSetJustifyContent(node:YGNodeRef, justifyContent:YGJustify):Void;

	// ========================================================================
	// Style: Flex Basis, Grow, Shrink
	// ========================================================================

	@:native("YGNodeStyleSetFlex")
	static function styleSetFlex(node:YGNodeRef, flex:fiberus.Float32):Void;

	@:native("YGNodeStyleSetFlexGrow")
	static function styleSetFlexGrow(node:YGNodeRef, flexGrow:fiberus.Float32):Void;

	@:native("YGNodeStyleSetFlexShrink")
	static function styleSetFlexShrink(node:YGNodeRef, flexShrink:fiberus.Float32):Void;

	@:native("YGNodeStyleSetFlexBasis")
	static function styleSetFlexBasis(node:YGNodeRef, flexBasis:fiberus.Float32):Void;

	@:native("YGNodeStyleSetFlexBasisPercent")
	static function styleSetFlexBasisPercent(node:YGNodeRef, flexBasis:fiberus.Float32):Void;

	@:native("YGNodeStyleSetFlexBasisAuto")
	static function styleSetFlexBasisAuto(node:YGNodeRef):Void;

	// ========================================================================
	// Style: Width, Height
	// ========================================================================

	@:native("YGNodeStyleSetWidth")
	static function styleSetWidth(node:YGNodeRef, width:fiberus.Float32):Void;

	@:native("YGNodeStyleSetWidthPercent")
	static function styleSetWidthPercent(node:YGNodeRef, width:fiberus.Float32):Void;

	@:native("YGNodeStyleSetWidthAuto")
	static function styleSetWidthAuto(node:YGNodeRef):Void;

	@:native("YGNodeStyleSetHeight")
	static function styleSetHeight(node:YGNodeRef, height:fiberus.Float32):Void;

	@:native("YGNodeStyleSetHeightPercent")
	static function styleSetHeightPercent(node:YGNodeRef, height:fiberus.Float32):Void;

	@:native("YGNodeStyleSetHeightAuto")
	static function styleSetHeightAuto(node:YGNodeRef):Void;

	// ========================================================================
	// Style: Min/Max Width, Min/Max Height
	// ========================================================================

	@:native("YGNodeStyleSetMinWidth")
	static function styleSetMinWidth(node:YGNodeRef, minWidth:fiberus.Float32):Void;

	@:native("YGNodeStyleSetMinWidthPercent")
	static function styleSetMinWidthPercent(node:YGNodeRef, minWidth:fiberus.Float32):Void;

	@:native("YGNodeStyleSetMinHeight")
	static function styleSetMinHeight(node:YGNodeRef, minHeight:fiberus.Float32):Void;

	@:native("YGNodeStyleSetMinHeightPercent")
	static function styleSetMinHeightPercent(node:YGNodeRef, minHeight:fiberus.Float32):Void;

	@:native("YGNodeStyleSetMaxWidth")
	static function styleSetMaxWidth(node:YGNodeRef, maxWidth:fiberus.Float32):Void;

	@:native("YGNodeStyleSetMaxWidthPercent")
	static function styleSetMaxWidthPercent(node:YGNodeRef, maxWidth:fiberus.Float32):Void;

	@:native("YGNodeStyleSetMaxHeight")
	static function styleSetMaxHeight(node:YGNodeRef, maxHeight:fiberus.Float32):Void;

	@:native("YGNodeStyleSetMaxHeightPercent")
	static function styleSetMaxHeightPercent(node:YGNodeRef, maxHeight:fiberus.Float32):Void;

	// ========================================================================
	// Style: Position (edge-based)
	// ========================================================================

	@:native("YGNodeStyleSetPosition")
	static function styleSetPosition(node:YGNodeRef, edge:YGEdge, position:fiberus.Float32):Void;

	@:native("YGNodeStyleSetPositionPercent")
	static function styleSetPositionPercent(node:YGNodeRef, edge:YGEdge, position:fiberus.Float32):Void;

	@:native("YGNodeStyleSetPositionAuto")
	static function styleSetPositionAuto(node:YGNodeRef, edge:YGEdge):Void;

	// ========================================================================
	// Style: Margin (edge-based)
	// ========================================================================

	@:native("YGNodeStyleSetMargin")
	static function styleSetMargin(node:YGNodeRef, edge:YGEdge, margin:fiberus.Float32):Void;

	@:native("YGNodeStyleSetMarginPercent")
	static function styleSetMarginPercent(node:YGNodeRef, edge:YGEdge, margin:fiberus.Float32):Void;

	@:native("YGNodeStyleSetMarginAuto")
	static function styleSetMarginAuto(node:YGNodeRef, edge:YGEdge):Void;

	// ========================================================================
	// Style: Padding (edge-based)
	// ========================================================================

	@:native("YGNodeStyleSetPadding")
	static function styleSetPadding(node:YGNodeRef, edge:YGEdge, padding:fiberus.Float32):Void;

	@:native("YGNodeStyleSetPaddingPercent")
	static function styleSetPaddingPercent(node:YGNodeRef, edge:YGEdge, padding:fiberus.Float32):Void;

	// ========================================================================
	// Style: Border (edge-based)
	// ========================================================================

	@:native("YGNodeStyleSetBorder")
	static function styleSetBorder(node:YGNodeRef, edge:YGEdge, border:fiberus.Float32):Void;

	// ========================================================================
	// Style: Gap
	// ========================================================================

	@:native("YGNodeStyleSetGap")
	static function styleSetGap(node:YGNodeRef, gutter:YGGutter, gapLength:fiberus.Float32):Void;

	@:native("YGNodeStyleSetGapPercent")
	static function styleSetGapPercent(node:YGNodeRef, gutter:YGGutter, gapLength:fiberus.Float32):Void;

	// ========================================================================
	// Style: Aspect Ratio
	// ========================================================================

	@:native("YGNodeStyleSetAspectRatio")
	static function styleSetAspectRatio(node:YGNodeRef, aspectRatio:fiberus.Float32):Void;

	// ========================================================================
	// Style: Box Sizing
	// ========================================================================

	@:native("YGNodeStyleSetBoxSizing")
	static function styleSetBoxSizing(node:YGNodeRef, boxSizing:YGBoxSizing):Void;
}
