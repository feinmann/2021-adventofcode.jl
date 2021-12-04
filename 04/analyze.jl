using Images 

mat = Array{Union{Float64, Int64}}(undef, 0, 5)
open("04/input.txt") do file
    for ln in eachline(file)
        if length(ln) > 14
            global vector_of_numbers = parse.(Int, split(ln, ","))
        end
        
        if length(ln) == 14
            row_vec = parse.(Int, filter(!=(""), split(ln, " ")))
            @assert length(row_vec) == 5
            global mat = [mat; row_vec']
        end
    end
end

mat = reshape(mat', 5, 5, :) 
# WWWTTTTFFFF: I don't know!!! But I need the transpose and still the matrices are wrong, 
# but doesnt matter (any more) in this case

# now iterate thru `vector_of_numbers`
# at every iteration we substitute the number with `NaN` in `mat`
# then we calculate row- and column-sums
# when any one of the sums is zero, we have identified the winning (sub-)matrix
# solution is then calculated with this matrix
iter_mat = copy(mat)
for number in vector_of_numbers
    println(number)
    replace!(iter_mat, number => NaN)
    row_sums_mat = sumfinite(iter_mat, dims=2)
    col_sums_mat = sumfinite(iter_mat, dims=1) # returns zero if all elements are NaN! (ARGH)
    row_winner = findall( x -> x == 0, row_sums_mat )
    col_winner = findall( x -> x == 0, col_sums_mat )
    if (length( row_winner ) > 0)
        println("We have a row winner after number $number.")
        println(row_winner)
        break
    end
    if (length( col_winner ) > 0)
        println("We have a col winner after number $number.")
        println(col_winner)
        break
    end
end

# We have a row winner after number 66.
# CartesianIndex{3}[CartesianIndex(3, 1, 84)]
iter_mat[:, :, 84] |> sumfinite
print(668 * 66)