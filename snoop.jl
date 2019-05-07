using SnoopCompile

SnoopCompile.@snoop "http_compiles.csv" begin
    using Pkg
    include("test/runtests.jl")
end

data = SnoopCompile.read("http_compiles.csv")

pc = SnoopCompile.parcel(reverse!(data[2]))
SnoopCompile.write("src/precompile", pc)