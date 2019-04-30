module Search
using Crayons

"""
    search_by_extension() :: Array{Dict{String, String},1}

Returns an Array of files that were found.

# Examples
```julia
julia> FileCLI.Search.search_by_extension(".", String["jl"], false)
4-element Array{Dict{String,String},1}:
 Dict("folder"=>"C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\","file"=>"test.jl")
 Dict("folder"=>"C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\src","file"=>"FileCLI.jl")
 Dict("folder"=>"C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\src","file"=>"search.jl")
 Dict("folder"=>"C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\test","file"=>"runtests.jl")
```
"""
function search_by_extension(path::String, ext::Array{String,1}, print_output::Bool=true)::Array{Dict{String, String},1}
    
    found::Bool = false
    files_found::Array{Dict{String, String},1} = []
    
    p::String = abspath(path)
    
    reg = Nothing
    if length(ext) == 1
        reg = Regex("$(ext[1])\$")
    end
    
    if print_output
        print(Crayon(background = :black), Crayon(foreground=:light_green), "Looking at $(p)...")
        print("\n")
    end

    for (root, dir, files) in walkdir(p)
        
        if occursin("node_modules", root)
            continue
        end
        
        for f in files
            for e in ext
                
                # only make new regex if user passed multiple names
                if reg == Nothing && length(ext) > 1
                    reg = Regex("$(e)\$")
                end
                
                if occursin(reg, f)
                    
                    found = true
                    push!(files_found, Dict{String, String}("file" => f, "folder" => root))
                    
                    # reset regex
                    if length(ext) > 1 reg = Nothing end
                else
                    # reset regex
                    if length(ext) > 1 reg = Nothing end
                end
            end
        end
    end
    
    if print_output
        print(Crayon(background = :black), Crayon(foreground = :light_green), "Successfully Finished.\n")
    end

    if !found
    
        print(Crayon(background = :red, foreground=:white), "No File was found found with extenstions -> ")
        print(Crayon(background = :yellow), Crayon(foreground = :red), " .$(ext)\n")
        print("\n")
    
    elseif print_output
    
        for f in files_found
            print(Crayon(foreground = :red), " -> ")
            print("")
            print(Crayon(foreground = :light_yellow), " $(f["file"]) ")
            print("\tat\t")
            print("")
            print(Crayon(foreground = :white), " $(f["folder"])\n")
        end

        print(Crayon(foreground = :light_green), "$(length(files_found)) files were found\n")
    
    end
    return files_found
end

export search_by_extension
end
