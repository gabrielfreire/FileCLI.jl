include("FileCLI.jl")

FileCLI.julia_main(String[""])
FileCLI.Search.search_by_extension(".", String[""], true)
FileCLI.Search.search_by_extension(".", String["jl"], true)
FileCLI.Search.search_by_extension(".", String["jl", "js"], false)