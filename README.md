# FileCLI.jl [W.I.P.]

A *work in progress* CLI written in Julia lang for easy file search and manipulation in the terminal

# Build Binary
First you need my fork of the `ApplicationBuilder` package and the `PackageCompiler` package.
```shell
(v1.3) pkg> add https://github.com/gabrielfreire/ApplicationBuilder.jl.git
(v1.3) pkg> dev PackageCompiler
```
Now, on Windows, run
```shell
$ julia compile.jl
```
This command will compile this package to a standalone binary at `./builddir` and generate a InnoScript Setup file `fcli.iss` that can be compiled with `Inno Script Studio` and will generate a `fcliSetup.exe` that can be installed in any computer.

# **Usage**
## As Binary
After compiling, generating the binary and compiling the setup script.
The installation in `fcliSetup.exe` will add the `bin` installation folder to your `PATH` environment variable so you can use the `cli tool` like so:
```shell
$ fcli_ -s . dll
```
This will search for `.dll` files in the current folder
```shell
$ fcli_ -s ../ dll
```
This will search for `.dll` files in the parent folder

## In Julia
Run
```shell
(v1.3) pkg> add https://github.com/gabrielfreire/FileCLI.jl.git
```
### Get help
```shell
$ julia src/FileCLI.jl -h
Search files using the full file name or only the extension using the flag [-s]


Commands:
        -> help [-h]
        -> search [-s]
        -> compare [-c]

Usage: julia src/FileCLI.jl -s path ext1 ext2 ext3

---------------------------------
             Search
---------------------------------
- To search for .jl files in the CURRENT directory

Run:    julia src/FileCLI.jl -s . jl

- To search for .jl files in the PARENT directory

Run:    julia src/FileCLI.jl -s ../ jl

- To search for a files called package.json in the PARENT directory

Run:    julia src/FileCLI.jl -s ../ package.json

----------------------------------
             Compare
----------------------------------
- To compare two files

Run:    julia src/FileCLI.jl -c file1 file2
```

## **Search** 
### Search for .jl files in current directory
```shell
$ julia src/FileCLI.jl -s . jl
Looking at C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\...
Successfully Finished.
 ->  compile.jl         at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\
 ->  snoop.jl   at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\
 ->  call_functions.jl  at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\src
 ->  compare.jl         at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\src
 ->  FileCLI.jl         at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\src
 ->  helpers.jl         at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\src
 ->  search.jl  at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\src
 ->  precompile_Base.jl         at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\src\precompile
 ->  precompile_Crayons.jl      at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\src\precompile
 ->  precompile_FileCLI.jl      at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\src\precompile
 ->  precompile_Random.jl       at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\src\precompile
 ->  precompile_Test.jl         at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\src\precompile
 ->  precompile_unknown.jl      at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\src\precompile
 ->  runtests.jl        at       C:\Users\gabrielfreiredev\Documents\workspace\FileCLI.jl\test
14 files were found

```
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
4-element Array{FileCLI.Search.FileDump,1}:
 FileCLI.Search.FileDump("test.jl", "C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\")
 FileCLI.Search.FileDump("FileCLI.jl", "C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\src")
 FileCLI.Search.FileDump("search.jl", "C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\src")
 FileCLI.Search.FileDump("runtests.jl", "C:\\Users\\gabriel.freire\\Documents\\workspace\\FileCLI.jl\\test")
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