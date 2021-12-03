using DataFrames
using CSV

df = CSV.read("03/input.txt", DataFrame; header = false, types=String)

# What is the power consumption of the submarine?
result_mat = ones(0, 12)
for idx in 1:size(df)[1]
    row_vec = split(df[idx, :Column1], "")
    result_mat = [result_mat; permutedims(row_vec)] # WTF: https://discourse.julialang.org/t/transpose-of-an-array-of-strings/40431/3
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

# https://adventofcode.com/2021/day/3#part2
# What is the life support rating of the submarine?

# oxygen_generator_rating
iter_mat = copy(result_mat)
for act_col in 1:12
    col_sum = sum(iter_mat[:, act_col])
    number_of_rows = size(iter_mat)[1]
    if col_sum > number_of_rows/2
        most_column_value = 1
    elseif col_sum == number_of_rows/2
        most_column_value = 1
    else
        most_column_value = 0
    end
    iter_mat = iter_mat[iter_mat[:, act_col] .== most_column_value, :]
end

iter_mat
# --> 100111110011

# co2_scrubber_rating (just reverse the rules)
iter_mat = copy(result_mat)
for act_col in 1:12
    number_of_rows = size(iter_mat)[1]
    if number_of_rows > 1
        col_sum = sum(iter_mat[:, act_col])
        if col_sum > number_of_rows/2
            least_column_value = 0
        elseif col_sum == number_of_rows/2
            least_column_value = 0
        else
            least_column_value = 1
        end
        iter_mat = iter_mat[iter_mat[:, act_col] .== least_column_value, :]
    end
end

# --> 001011100001

print(Int(0b100111110011) * Int(0b001011100001))