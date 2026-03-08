# fib_yoga

Flexbox layout engine library for the Fiberus runtime. Provides Haxe bindings to [Facebook's Yoga](https://github.com/facebook/yoga) layout engine, a cross-platform implementation of the CSS flexbox algorithm. Exposes ~70 functions and 12 enum types for building and computing node-based layouts.

## Architecture

```
Haxe code -> yoga.Yoga (@:native extern)
          -> Yoga C++ library (20 source files compiled via @:sourceFile)
          -> YGNodeRef opaque pointers (malloc-managed)
```

Yoga is compiled as C++20 via `@:buildXml` with `-std=c++20 -w`. The library uses 20 `.cpp` source files referenced individually through `@:sourceFile` metadata. All dimension and layout values use `fiberus.Float32` to match Yoga's `float` C API.

## Directory Structure

```
fib_yoga/
  lib/yoga/
    Yoga.h                         Public C API header
    YGConfig.cpp                   Configuration
    YGEnums.cpp                    Enum string conversions
    YGNode.cpp                     Node lifecycle
    YGNodeLayout.cpp               Layout result accessors
    YGNodeStyle.cpp                Style property setters
    YGPixelGrid.cpp                Pixel grid rounding
    YGValue.cpp                    Value types
    algorithm/                     Layout algorithm implementation
      AbsoluteLayout.cpp           Absolute positioning
      Baseline.cpp                 Baseline alignment
      Cache.cpp                    Layout caching
      CalculateLayout.cpp          Main flexbox algorithm
      FlexLine.cpp                 Flex line computation
      PixelGrid.cpp                Pixel grid snapping
    config/Config.cpp              Configuration internals
    debug/AssertFatal.cpp          Fatal assertions
    debug/Log.cpp                  Debug logging
    event/event.cpp                Layout event system
    node/LayoutResults.cpp         Layout result storage
    node/Node.cpp                  Node internals
  src/yoga/
    Yoga.hx                        Main extern class (~70 static methods)
    YGEnums.hx                     12 extern enum abstract types
    YGNodeRef.hx                   Opaque pointer type (YGNodeRef -> struct YGNode*)
  test/
    TestMain.hx                    Test entry point
    TestYoga.hx                    Test suite (9 test cases)
    Test.hx                        Base test class
    TestFramework.hx               Lightweight assertion framework
    compile.hxml                   Haxe compiler flags
    Makefile                       Build targets
```

## Usage

```haxe
import yoga.Yoga;
import yoga.YGEnums;

// Create a root node with fixed dimensions
var root = Yoga.nodeNew();
Yoga.styleSetWidth(root, 400);
Yoga.styleSetHeight(root, 400);
Yoga.styleSetFlexDirection(root, YGFlexDirection.Column);

// Top bar: fixed height
var topBar = Yoga.nodeNew();
Yoga.styleSetHeight(topBar, 50);
Yoga.nodeInsertChild(root, topBar, 0);

// Content area: fills remaining space, row direction
var content = Yoga.nodeNew();
Yoga.styleSetFlexGrow(content, 1);
Yoga.styleSetFlexDirection(content, YGFlexDirection.Row);
Yoga.nodeInsertChild(root, content, 1);

// Sidebar: fixed width
var sidebar = Yoga.nodeNew();
Yoga.styleSetWidth(sidebar, 80);
Yoga.nodeInsertChild(content, sidebar, 0);

// Main: fills remaining width
var main = Yoga.nodeNew();
Yoga.styleSetFlexGrow(main, 1);
Yoga.nodeInsertChild(content, main, 1);

// Calculate layout
Yoga.calculateLayout(root, cast Math.NaN, cast Math.NaN, YGDirection.LTR);

// Read results
trace(Yoga.layoutGetWidth(topBar));   // 400
trace(Yoga.layoutGetHeight(topBar));  // 50
trace(Yoga.layoutGetWidth(sidebar));  // 80
trace(Yoga.layoutGetHeight(sidebar)); // 350
trace(Yoga.layoutGetLeft(main));      // 80
trace(Yoga.layoutGetWidth(main));     // 320

// Free all nodes
Yoga.nodeFreeRecursive(root);
```

## API

### Node Lifecycle

| Method | Description |
|--------|-------------|
| `nodeNew():YGNodeRef` | Create a new layout node. |
| `nodeFree(node):Void` | Free a single node. |
| `nodeFreeRecursive(node):Void` | Free a node and all its children. |
| `nodeReset(node):Void` | Reset a node to default state. |

### Child Management

| Method | Description |
|--------|-------------|
| `nodeInsertChild(node, child, index):Void` | Insert child at index. |
| `nodeRemoveChild(node, child):Void` | Remove a child. |
| `nodeRemoveAllChildren(node):Void` | Remove all children. |
| `nodeGetChild(node, index):YGNodeRef` | Get child at index. |
| `nodeGetChildCount(node):SizeT` | Get number of children. |
| `nodeGetOwner(node):YGNodeRef` | Get parent node. |

### Layout Calculation

| Method | Description |
|--------|-------------|
| `calculateLayout(node, availableWidth, availableHeight, direction):Void` | Compute layout. Pass `Math.NaN` for unconstrained dimensions. |

### Layout Results

| Method | Description |
|--------|-------------|
| `layoutGetLeft/Top/Right/Bottom(node):Float32` | Position relative to parent. |
| `layoutGetWidth/Height(node):Float32` | Computed dimensions. |
| `layoutGetDirection(node):YGDirection` | Resolved direction. |
| `layoutGetHadOverflow(node):Bool` | Whether content overflowed. |
| `layoutGetMargin/Border/Padding(node, edge):Float32` | Computed box model values. |

### Style Setters

**Direction & Layout:**
`styleSetDisplay`, `styleSetOverflow`, `styleSetPositionType`, `styleSetDirection`, `styleSetFlexDirection`, `styleSetFlexWrap`

**Alignment:**
`styleSetAlignContent`, `styleSetAlignItems`, `styleSetAlignSelf`, `styleSetJustifyContent`

**Flex:**
`styleSetFlex`, `styleSetFlexGrow`, `styleSetFlexShrink`, `styleSetFlexBasis`, `styleSetFlexBasisPercent`, `styleSetFlexBasisAuto`

**Dimensions:**
`styleSetWidth/Height` (also `Percent` and `Auto` variants), `styleSetMinWidth/MinHeight`, `styleSetMaxWidth/MaxHeight` (also `Percent` variants)

**Box Model (edge-based):**
`styleSetPosition/PositionPercent/PositionAuto`, `styleSetMargin/MarginPercent/MarginAuto`, `styleSetPadding/PaddingPercent`, `styleSetBorder`

**Other:**
`styleSetGap/GapPercent`, `styleSetAspectRatio`, `styleSetBoxSizing`

### Enum Types (12)

| Enum | Values |
|------|--------|
| `YGAlign` | Auto, FlexStart, Center, FlexEnd, Stretch, Baseline, SpaceBetween, SpaceAround, SpaceEvenly |
| `YGBoxSizing` | BorderBox, ContentBox |
| `YGDirection` | Inherit, LTR, RTL |
| `YGDisplay` | Flex, None, Contents |
| `YGEdge` | Left, Top, Right, Bottom, Start, End, Horizontal, Vertical, All |
| `YGFlexDirection` | Column, ColumnReverse, Row, RowReverse |
| `YGGutter` | Column, Row, All |
| `YGJustify` | FlexStart, Center, FlexEnd, SpaceBetween, SpaceAround, SpaceEvenly |
| `YGNodeType` | Default, Text |
| `YGOverflow` | Visible, Hidden, Scroll |
| `YGPositionType` | Static, Relative, Absolute |
| `YGUnit` | Undefined, Point, Percent, Auto, MaxContent, FitContent, Stretch |
| `YGWrap` | NoWrap, Wrap, WrapReverse |

## Building and Testing

```bash
# From libraries/fib_yoga/test/

make debug          # Debug build with FIBERUS_DEBUG
make release        # Release build
make run            # Run tests
make clean          # Remove build artifacts
make cache_clear    # Clear cached .a files
```

The test suite covers: node create/free, basic layout (width/height/position), flex row distribution, flex column distribution, padding insets, margin offsets, nested layouts (top bar + sidebar + main content), enum value usage, and child management (insert/remove/count).

## Requirements

- C++20 compiler (set automatically via `@:buildXml` with `-std=c++20`)

## Memory Model

- `YGNodeRef` pointers are Yoga-managed (malloc'd internally). The GC does not track these pointers.
- Call `nodeFree()` for individual nodes or `nodeFreeRecursive()` to free an entire tree.
- All layout values use `fiberus.Float32` to match Yoga's `float` C ABI exactly.
