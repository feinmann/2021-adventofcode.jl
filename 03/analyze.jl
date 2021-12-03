using DataFrames
using CSV

df = CSV.read("03/input.txt", DataFrame; header = false, types=String)

# What is the power consumption of the submarine?
result_mat = ones(0, 12)
for idx in 1:size(df)[1]
    row_vec = split(df[idx, :Column1], "")
    convert(Int, row_vec)
    result_mat = [result_mat;permutedims(row_vec)] # WTF: https://discourse.julialang.org/t/transpose-of-an-array-of-strings/40431/3
end

result_mat = parse.(Int, result_mat)
result_sums = sum(result_mat, dims=1)

for digit in result_sums
    if digit > 500
        print(1)
    else 
        print(0)
    end
end

# --> 110111000111 is gamma-rate
# --> 001000111000 is epsilon-rate (fuck)

# Solution for star 1:
print( Int(0b110111000111) * Int(0b001000111000))

