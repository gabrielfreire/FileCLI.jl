# FileCLI.jl [W.I.P.]

A *work in progress* CLI written in Julia lang for easy file search and manipulation in the terminal

# Install

```shell
sh> julia -e 'using Pkg; Pkg.add("https://github.com/gabrielfreire/FileCLI.jl")'
```

# **Usage**
### Get help
![usage01](assets/usage.png)

## **Search** 
### Search for .jl files in current directory
![usage02](assets/search_usage.png)
- or programatically
```julia
using FileCLI

# Find all .jl files in the CURRENT folder
js_files_found = FileCLI.Search.search_by_extension(".", String["jl"], false)

# Find all .jl files in the PARENT folder
js_files_found = FileCLI.Search.search_by_extension("../", String["jl"], false)

# Find all .jl and .js files in the PARENT folder
js_files_found = FileCLI.Search.search_by_extension("../", String["jl", "js"], false)

# Find all .jl files in the test_folder folder
js_files_found = FileCLI.Search.search_by_extension("test_folder", String["jl"], false)

# Find a specific file in the test_folder folder
js_files_found = FileCLI.Search.search_by_extension("test_folder", String["test.jl"], false)

# Find all .json files in the PARENT folder
js_files_found = FileCLI.Search.search_by_extension("../", String["json"], false)
```

```shell
# REPL
julia> FileCLI.Search.search_by_extension(".", String["jl"], false)
4-element Array{Dict{String,String},1}:
 Dict("folder"=>"C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\","file"=>"test.jl")
 Dict("folder"=>"C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\src","file"=>"FileCLI.jl")
 Dict("folder"=>"C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\src","file"=>"search.jl")
 Dict("folder"=>"C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\test","file"=>"runtests.jl")
```

# Test
```shell
pkg> activate .
(FileCLI) pkg> test
```
# TODO
- Search files by name/extension [DONE]
- Image convertion i.e `png <-> jpg`
- Audio convertion i.e `wav <-> mp3`