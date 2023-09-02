import Lake
open Lake DSL

package «atomic» {
  -- add package configuration options here
}

lean_lib «Atomic» {
  -- add library configuration options here
}

@[default_target]
lean_exe «atomic» {
  root := `Main
}
