using Test

# ------------------------------- Search tests
include("../src/FileCLI.jl")

@testset "Search tests" begin

    js_files_found = FileCLI.Search.search_by_extension("test_folder", String["js"])
    @test length(js_files_found) == 2
    @test occursin(r"js$", js_files_found[1].file) == true

    txt_files_found = FileCLI.Search.search_by_extension("test_folder", String["txt"], true)
    @test length(txt_files_found) == 2
    @test occursin(r"txt$", txt_files_found[1].file) == true

    txt_and_js_files_found = FileCLI.Search.search_by_extension("test_folder", String["txt", "js"], false)
    @test length(txt_and_js_files_found) == 4

    txt_file_found = FileCLI.Search.search_by_extension("test_folder", String["text.txt"], false)
    @test length(txt_file_found) == 1

    js_file_found = FileCLI.Search.search_by_extension("test_folder", String["jsFile.js"], false)
    @test length(js_file_found) == 1

    js_file_not_found = FileCLI.Search.search_by_extension("test_folder", String["jsFile2.js"], false)
    @test length(js_file_not_found) == 0
    
    match_all_files_found = FileCLI.Search.search_by_extension("test_folder", String[""], false)
    @test length(match_all_files_found) == 4

end