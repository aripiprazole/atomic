#include <lean/lean.h>

extern "C" lean_obj_res lean_atomic_init() {
  return lean_io_result_mk_ok(lean_box(0));
}
