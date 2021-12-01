using DataFrames
using CSV

df = CSV.read("input.txt", DataFrame; header = false)

# Count how often a value is higher than preceeding value
count = 0
for idx in 2:size(df)[1]
    if df[idx, :Column1] - df[idx - 1, :Column1] > 0
        count += 1
    end
end

println("Values in df are ", count, " times increasing.")

# Consider sums of a three-measurement sliding window. How many sums are larger than the previous sum?

count_2 = 0
for idx in 3:(size(df)[1]-1)
    if sum(df[(idx-1):(idx+1), :Column1]) - sum(df[(idx-2):idx, :Column1]) > 0
        count_2 += 1
    end
end

println("Rolling-three-sum is ", count_2, " times increasing.")