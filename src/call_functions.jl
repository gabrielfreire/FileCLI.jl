include("FileCLI.jl")
try
    include("precompile//precompile_Base.jl")
    _precompile_()
    include("precompile//precompile_Crayons.jl")
    _precompile_()
    include("precompile//precompile_FileCLI.jl")
    _precompile_()
    include("precompile//precompile_Random.jl")
    _precompile_()
    include("precompile//precompile_Test.jl")
    _precompile_()
    include("precompile//precompile_unknown.jl")
    _precompile_()
catch e
    println("snoop.jl wasn't executed")
end

FileCLI.julia_main(String[])
FileCLI.julia_main(String["-h"])
FileCLI.julia_main(String["-s", ".", "jl"])
FileCLI.julia_main(String["-s", ".", "jl", "dll"])
FileCLI.julia_main(String["-c", "compare.jl", "search.jl"])