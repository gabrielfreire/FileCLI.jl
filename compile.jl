using ApplicationBuilder

app_path = joinpath(abspath(@__DIR__), "src", "FileCLI.jl")
# ApplicationBuilder.build_app_bundle(app_path, appname="FileCLI")
ApplicationBuilder.build_app_bundle(app_path, appname="FileCLI", commandline_app=true, verbose=true, snoopfile=joinpath(abspath(app_path, ".."), "snoop.jl"), create_installer=true)