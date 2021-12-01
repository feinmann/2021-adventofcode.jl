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
