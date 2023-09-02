structure Atomic (a : Type) : Type where
  private value : IO.Ref a

namespace Atomic

@[extern "lean_atomic_init"]
opaque initAtomic : IO Unit

builtin_initialize initAtomic

inductive AtomicOrder where
  /--
   Atomic operations tagged memory_order_relaxed are not synchronization operations;
   they do not impose an order among concurrent memory accesses. They only guarantee
   atomicity and modification order consistency.
  -/
  | Relaxed

  /--
   A load operation with this memory order performs a consume operation on the
   affected memory location: no reads or writes in the current thread dependent
   on the value currently loaded can be reordered before this load.

   Writes to data-dependent variables in other threads that release the same atomic
   variable are visible in the current thread. On most platforms, this affects
   compiler optimizations only.
  -/
  | Load

  /--
   A load operation with this memory order performs the acquire operation on the
   affected memory location: no reads or writes in the current thread can be
   reordered before this load.

   All writes in other threads that release the same atomic variable are visible
   in the current thread.
   -/
  | Acquire

  /--
   A store operation with this memory order performs the release
   operation: no reads or writes in the current thread can be reordered after
   this store.

   All writes in the current thread are visible in other threads that acquire
   the same atomic variable (see Release-Acquire ordering below) and writes
   that carry a dependency into the atomic variable become visible in other
   threads that consume the same atomic.
  -/
  | Release

  /--
   A read-modify-write operation with this memory order is both an acquire
   operation and a release operation.

   No memory reads or writes in the current thread can be reordered before the
   load, nor after the store.

   All writes in other threads that release the same atomic variable are visible
   before the modification and the modification is visible in other threads that
   acquire the same atomic variable. 
  -/
  | AcqRel
  /--
   A load operation with this memory order performs an acquire operation,
   a store performs a release operation, and read-modify-write performs both an
   acquire operation and a release operation, plus a single total order exists in
   which all threads observe all modifications in the same order.
  -/
  | SeqCst

/--
 Atomic defaults to the default value of the type.
-/
def Atomic.default [Inhabited a] : IO (Atomic a) := do
  let value ← IO.mkRef (Inhabited.default)
  return { value }

/-- 
 Atomic.new creates a new atomic with the given value.
-/
def Atomic.new (value : a) : IO (Atomic a) := do
  let value ← IO.mkRef value
  return { value }

def Atomic.load (atomic : Atomic a) (ordering : AtomicOrder) : IO a := do
  sorry

def Atomic.store (atomic : Atomic a) (value : a) (ordering : AtomicOrder) : IO a := do
  sorry

def Atomic.compareAndSwap (atomic : Atomic Bool) (current : Bool) (new : Bool) : IO Bool := do
  sorry

end Atomic