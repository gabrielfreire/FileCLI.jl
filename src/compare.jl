module FileComparsion

function filecmp(path1::AbstractString, path2::AbstractString)
    stat1, stat2 = stat(path1), stat(path2)
    if !(isfile(stat1) && isfile(stat2)) || filesize(stat1) != filesize(stat2)
        return false # or should it throw if a file doesn't exist?
    end
    stat1 == stat2 && return true # same file
    open(path1, "r") do file1
        open(path2, "r") do file2
            buf1 = Vector{UInt8}(undef, 32768)
            buf2 = similar(buf1)
            while !eof(file1) && !eof(file2)
                n1 = readbytes!(file1, buf1)
                n2 = readbytes!(file2, buf2)
                n1 != n2 && return false
                0 != Base._memcmp(buf1, buf2, n1) && return false
            end
            return eof(file1) == eof(file2)
        end
    end
end

end