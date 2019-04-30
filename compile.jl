
using PackageCompiler
push!(LOAD_PATH, joinpath(abspath(@__DIR__), "../"))
compile_package("FileCLI")

# sys image `julia -J 'C:\Users\gabriel.freire\.julia\dev\PackageCompiler\sysimg\sys.dll'`