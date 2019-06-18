Base.eval(:(have_color=true))
using ApplicationBuilder

base_path = abspath(@__DIR__)
main_file_path = joinpath(base_path, "src", "FileCLI.jl")
snoop_file_path = joinpath(base_path, "src", "call_functions.jl")

function clean()
    printstyled("Cleaning...\n", color=:light_blue)
    builddir = joinpath(base_path, "builddir")
    fcli_iss = joinpath(base_path, "fcli.iss")
    fcli_exe = joinpath(base_path, "fcliSetup.exe")
    isdir(builddir) && rm(builddir, force=true, recursive=true)
    isfile(fcli_iss) && rm(fcli_iss, force=true)
    isfile(fcli_exe) && rm(fcli_exe, force=true)
end

clean()

printstyled("Building...\n", color=:light_blue)

# https://github.com/gabrielfreire/ApplicationBuilder.jl
ApplicationBuilder.build_app_bundle(main_file_path, 
                                    appname="fcli", 
                                    binary_name="fcli", 
                                    commandline_app=true, 
                                    verbose=true, 
                                    snoopfile=snoop_file_path, 
                                    create_installer=true)

