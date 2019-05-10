module FileCompare

export file_compare

function file_compare(path1::AbstractString, path2::AbstractString, print_result=false)
    stat1, stat2 = stat(path1), stat(path2)
    printstyled("\nComparing:\n\tFILE 1: $path1\tsize: $(filesize(stat1)) bytes\n\tFILE 2: $path2\tsize: $(filesize(stat2)) bytes\n", color=:light_yellow);
    if !(isfile(stat1) && isfile(stat2)) || filesize(stat1) != filesize(stat2)
        if (print_result)
            printstyled("\nThe files are different\n", color=:red);
            # return false # or should it throw if a file doesn't exist?
        end
    else
        if (stat1 == stat2)
            printstyled("\nThe files are equal\n", color=:light_green);
        else
            open(path1, "r") do file1
                open(path2, "r") do file2
                    buf1 = Vector{UInt8}(undef, 32768)
                    buf2 = similar(buf1)
                    while !eof(file1) && !eof(file2)
                        n1 = readbytes!(file1, buf1)
                        n2 = readbytes!(file2, buf2)
                        if (n1 != n2)
                            printstyled("\nThe files are different\n", color=:red);
                        elseif (Base._memcmp(buf1, buf2, n1) != 0)
                            printstyled("\nThe files are different\n", color=:red);
                        # 0 != Base._memcmp(buf1, buf2, n1) && return false
                        end
                    end
                    if (eof(file1) == eof(file2))
                        printstyled("\nThe files are equal\n", color=:light_green)
                    end
                end
            end
        end
    end
end

end