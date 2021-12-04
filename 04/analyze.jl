using Images 

function read_input_data()
    mat = Array{Union{Float64, Int64}}(undef, 0, 5)
    open("04/input.txt") do file
        for ln in eachline(file)
            if length(ln) > 14
                vector_of_numbers = parse.(Int, split(ln, ","))
            end
            
            if length(ln) == 14
                row_vec = parse.(Int, filter(!=(""), split(ln, " ")))
                @assert length(row_vec) == 5
                mat = [mat; row_vec']
            end
        end
    end
    mat = reshape(mat', 5, 5, :)
    (mat, vector_of_numbers)
end

mat, vector_of_numbers = read_input_data(); # 1.296 ms (5159 allocations: 5.77 MiB)

# WWWTTTTFFFF: I don't know!!! But I need the transpose and still the matrices are wrong, 
# but doesnt matter (any more) in this case

# now iterate thru `vector_of_numbers`
# at every iteration we substitute the number with `NaN` in `mat`
# then we calculate row- and column-sums
# when any one of the sums is zero, we have identified the winning (sub-)matrix
# solution is then calculated with this matrix

function get_first_winner_board(iter_mat, vector_of_numbers)
    for number in vector_of_numbers
        replace!(iter_mat, number => NaN)
        row_sums_mat = sumfinite(iter_mat, dims=2)
        col_sums_mat = sumfinite(iter_mat, dims=1) # returns zero if all elements are NaN! (ARGH)
        row_winner = findall( x -> x == 0, row_sums_mat )
        col_winner = findall( x -> x == 0, col_sums_mat )
        if (length( row_winner ) == 1)
            println("We have a row winner after number $number.")
            println(row_winner)
            break
        end
        if (length( col_winner ) == 1)
            println("We have a col winner after number $number.")
            println(col_winner)
            break
        end
    end # before: 101.725 ms (3108 allocations: 72.99 MiB)
end

get_first_winner_board(copy(mat), vector_of_numbers) # 536.937 μs (649 allocations: 505.11 KiB)

# We have a row winner after number 66.
# CartesianIndex{3}[CartesianIndex(3, 1, 84)]
iter_mat[:, :, 84] |> sumfinite
print(668 * 66)


# Solution for star 2:
# https://adventofcode.com/2021/day/4#part2

# Strategy: play to the end and inspect the last board that was winning

function get_last_winnerboard(iter_mat)
    for number in vector_of_numbers
        println(number)
        replace!(iter_mat, number => NaN)
        row_sums_mat = sumfinite(iter_mat, dims=2)
        col_sums_mat = sumfinite(iter_mat, dims=1) # returns zero if all elements are NaN! (ARGH)
        row_winners = findall( x -> x == 0, row_sums_mat )
        col_winners = findall( x -> x == 0, col_sums_mat )
        for row_winner in row_winners
            println("We have a row winner after number $number.")
            println("The rest-sum is ", iter_mat[:, :, row_winner[3]] |> sumfinite)
            println(row_winner)
            iter_mat[:, :, row_winner[3]] .= -1 # replace winner board with -1's
        end
        for col_winner in col_winners
            println("We have a col winner after number $number.")
            println("The rest-sum is ", iter_mat[:, :, col_winner[3]] |> sumfinite)
            println(col_winner)
            iter_mat[:, :, col_winner[3]] .= -1 # replace winner board with -1's
        end
    end # before: 1.665 ms (2908 allocations: 1.70 MiB)
end

@btime get_last_winnerboard(copy(mat)) # oh oh: 6.585 ms (9662 allocations: 1.99 MiB)

# The last board winning is number 10 with a rest-sum of 263 after the number 90 
# W T FFFFFFF
# ->>> solution is 90 * 263 = 23670
