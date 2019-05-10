using ApplicationBuilder

app_path = joinpath(abspath(@__DIR__), "FileCLI.jl")
# ApplicationBuilder.build_app_bundle(app_path, appname="FileCLI")
ApplicationBuilder.build_app_bundle(app_path, 
                                    appname="fcli", 
                                    binary_name="fcli", 
                                    commandline_app=true, 
                                    verbose=true, 
                                    snoopfile=joinpath(@__DIR__, "call_functions.jl"), 
                                    create_installer=true)