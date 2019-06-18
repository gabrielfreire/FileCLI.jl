Base.eval(:(have_color=true))
module FileCLI


include("helpers.jl")
include("search.jl")
include("compare.jl")

Base.@ccallable function julia_main(ARGS::Vector{String}):: Cint
    if length(ARGS) > 1
        if ARGS[1] == "-h"
            print_help()
            return 0
        elseif ARGS[1] == "-s"
            Search.search_by_extension(ARGS[2], ARGS[3:end], true)
        elseif ARGS[1] == "-c"
            if length(ARGS) < 3
                printstyled("\nWrong amount of arguments\n", color=:red)
                print_help()
            else
                FileCompare.file_compare(ARGS[2], ARGS[3], true)
            end
        else
            print_help()
        end
        return 0
    else
        print_help()
        return 0
    end
end

julia_main(ARGS)
end # module