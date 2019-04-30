module FileCLI
using Crayons

include("search.jl")
using .Search

function print_help()
    print(Crayon(foreground = :white),"\nSearch files using the full file name or only the extension using the flag [-s]\n\n")
    print(Crayon(foreground = :white),"\nCommands: \n\t", Crayon(foreground = :light_green), "search [-s]\n\thelp [-h]\n\n")
    print(Crayon(foreground = :white),"\nUsage: ", Crayon(foreground = :light_green), "julia --color=yes script.jl -s path ext1 ext2 ext3\n\n")
    print(Crayon(foreground = :white),"- To search for .jl files in the CURRENT directory\n\nRun: \t", Crayon(foreground = :light_green), "julia --color=yes script.jl -s . jl\n\n")
    print(Crayon(foreground = :white),"- To search for .jl files in the PARENT directory\n\nRun: \t", Crayon(foreground = :light_green), "julia --color=yes script.jl -s ../ jl\n\n")
    print(Crayon(foreground = :white),"- To search for a files called package.json in the PARENT directory\n\nRun: \t", Crayon(foreground = :light_green), "julia --color=yes script.jl -s ../ package.json\n\n")
end

Base.@ccallable function julia_main(ARGS::Vector{String}):: Cint
    if length(ARGS) > 1
        if ARGS[1] == "-h"
            print_help()
            return 0
        elseif ARGS[1] == "-s"
            Search.search_by_extension(ARGS[2], ARGS[3:end], true)
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
# order reference number: 21823201904301438010
# reference for customer care: 276363