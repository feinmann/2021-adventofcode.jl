using DataFrames
using CSV

df = CSV.read("02/input.txt", DataFrame; header = false)

# What do you get if you multiply your final horizontal position by your final depth?
horz_pos = 0
vert_pos = 0
for idx in 1:size(df)[1]
    if df[idx, :Column1] == "forward"
        horz_pos += df[idx, :Column2]
    elseif df[idx, :Column1] == "down"
        vert_pos += df[idx, :Column2]
    elseif df[idx, :Column1] == "up"
        vert_pos -= df[idx, :Column2]
    end
end

println("The product is ", horz_pos * vert_pos)

# Altered commands
# What do you get if you multiply your final horizontal position by your final depth?

horz_pos_2 = 0
vert_pos_2 = 0
aim = 0
for idx in 1:size(df)[1]
    if df[idx, :Column1] == "forward"
        horz_pos_2 += df[idx, :Column2]
        vert_pos_2 += (aim * df[idx, :Column2])
    elseif df[idx, :Column1] == "down"
        aim += df[idx, :Column2]
    elseif df[idx, :Column1] == "up"
        aim -= df[idx, :Column2]
    end
end

println("The product is ", horz_pos_2 * vert_pos_2)