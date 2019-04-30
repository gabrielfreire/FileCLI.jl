module Search
using Crayons

function search_by_extension(path::String, ext::Array{String,1})::Array{Dict{String, String},1}
    
    found::Bool = false
    files_found::Array{Dict{String, String},1} = []
    
    p::String = abspath(path)
    
    reg = Nothing
    if length(ext) == 1
        reg = Regex("$(ext[1])\$")
    end
    
    print(Crayon(background = :black), Crayon(foreground=:light_green), "Looking at $(p)...")
    print("\n")

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
    
    print(Crayon(background = :black), Crayon(foreground = :light_green), "Successfully Finished.\n")
    
    if !found
    
        print(Crayon(background = :red, foreground=:white), "No File was found found with extenstions -> ")
        print(Crayon(background = :yellow), Crayon(foreground = :red), " .$(ext)\n")
        print("\n")
    
    else
    
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
