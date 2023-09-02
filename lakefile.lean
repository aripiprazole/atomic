import Lake
open Lake DSL

package «atomic» {}

lean_lib «Atomic» {}

@[default_target]
lean_exe «atomic» {
  root := `Main
}

target ffi.o pkg : FilePath := do
  let oFile := pkg.buildDir / "atomic" / "ffi.o"
  let srcJob ← inputFile <| pkg.dir / "atomic" / "ffi.cpp"
  let flags := #["-I", (← getLeanIncludeDir).toString, "-fPIC", "-I", "-lstdc++"]
  buildO "ffi.cpp" oFile srcJob flags "g++"

extern_lib libleanatomic pkg := do
  let name := nameToStaticLib "leanffi"
  let ffiO ← fetch <| pkg.target ``ffi.o
  buildStaticLib (pkg.buildDir / "lib" / name) #[ffiO]
