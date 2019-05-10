module Search
using Crayons


struct FileDump
    file::String
    root::String
end

"""
    search_by_extension() :: Array{FileDump,1}

Returns an Array of files that were found.

# Examples
```julia
julia> FileCLI.Search.search_by_extension(".", String["jl"], false)
4-element Array{FileCLI.Search.FileDump,1}:
 FileCLI.Search.FileDump("test.jl", "C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\")
 FileCLI.Search.FileDump("FileCLI.jl", "C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\src")
 FileCLI.Search.FileDump("search.jl", "C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\src")
 FileCLI.Search.FileDump("runtests.jl", "C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\test")
```
"""
function search_by_extension(path::String, ext::Array{String,1}, print_output::Bool=true)::Array{FileDump,1}
    
    found::Bool = false
    files_found::Array{FileDump,1} = []
    
    p::String = abspath(path)
    
    mult_ext = length(ext) > 1
    
    reg = Nothing
    if !mult_ext
        reg = Regex("$(ext[1])\$")
    end
    
    if print_output
        print(Crayon(background = :black), Crayon(foreground=:light_green), "Looking at $(p)...")
        print("\n")
    end

    try
        for (root, dir, files) in walkdir(p)
            if occursin("node_modules", root)
                continue
            end
    
            for f in files
                if !isfile(joinpath(root, f))
                    continue
                end
    
                for e in ext
                    # only make new regex if user passed multiple names
                    if mult_ext
                        reg = Regex("$(e)\$")
                    end
                    if occursin(reg, f) 
                        found = true
                        push!(files_found, FileDump(f, root))
                        
                    end
                end
            end
        end
    catch e
        println("[WARN] $(e)")
    end
    
    if print_output
        print(Crayon(background = :black), Crayon(foreground = :light_green), "Successfully Finished.\n")
    end

    if !found
        print(Crayon(foreground =:red), "No File was found found with extenstions -> ")
        print(Crayon(foreground =:red), " .$(ext)\n")
        print("\n")
    elseif print_output
        for f in files_found
            print(Crayon(foreground = :red), " -> ")
            print("")
            print(Crayon(foreground = :light_yellow), " $(f.file) ")
            print("\tat\t")
            print("")
            print(Crayon(foreground = :white), " $(f.root)\n")
        end
        print(Crayon(foreground = :light_green), "$(length(files_found)) files were found\n")
    end
    return files_found
end

export search_by_extension
end
