Base.eval(:(have_color=true))
using ApplicationBuilder
using SnoopCompile

app_name = "fcli"
base_path = abspath(@__DIR__)
main_file_path = joinpath(base_path, "src", "FileCLI.jl")
snoop_file_path = joinpath(base_path, "src", "call_functions.jl")

function clean()
    printstyled("Cleaning...\n", color=:light_blue)
    builddir = joinpath(base_path, "builddir")
    fcli_iss = joinpath(base_path, "$app_name.iss")
    fcli_exe = joinpath(base_path, "$(app_name)Setup.exe")
    isdir(builddir) && rm(builddir, force=true, recursive=true)
    isfile(fcli_iss) && rm(fcli_iss, force=true)
    isfile(fcli_exe) && rm(fcli_exe, force=true)
end

function make_snoop()
    printstyled("Checking for snoop files.\n", color=:light_green)
    precomp_path = joinpath(base_path, "src", "precompile")
    if !isdir(precomp_path)
        printstyled("Generating snoop files.\n", color=:light_green)
        
        SnoopCompile.@snoop "http_compiles.csv" begin
            using Pkg
            include("test/runtests.jl")
        end

        data = SnoopCompile.read("http_compiles.csv")

        pc = SnoopCompile.parcel(reverse!(data[2]))
        SnoopCompile.write(precomp_path, pc)
        rm("http_compiles.csv")
    end
    printstyled("Done.\n", color=:light_green)
end


#=
    COMPILE
=#
clean() # initial clean
make_snoop() # make all snoop files

printstyled("Building...\n", color=:light_blue)

# https://github.com/gabrielfreire/ApplicationBuilder.jl
ApplicationBuilder.build_app_bundle(main_file_path, 
                                    appname=appname, 
                                    binary_name=appname, 
                                    commandline_app=true, 
                                    verbose=true, 
                                    snoopfile=snoop_file_path, 
                                    create_installer=true)

