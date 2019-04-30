pkg_path = Base.find_package("PackageCompiler")
juliac_path = abspath(pkg_path, "../../")
juliac_path = joinpath(juliac_path, "juliac.jl")
_cmd = `julia $(juliac_path) -vas src\\FileCLI.jl`