/*
 * fib_yoga - Opaque pointer to a Yoga layout node.
 *
 * Maps directly to YGNodeRef (struct YGNode*) in generated C code.
 * Yoga manages the memory for nodes; the GC does not track these pointers.
 * Call Yoga.nodeFree() or Yoga.nodeFreeRecursive() to release.
 */
package yoga;

@:native("YGNodeRef") @:coreType @:notNull extern abstract YGNodeRef {}
