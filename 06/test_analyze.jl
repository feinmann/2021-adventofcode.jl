
function read_input()
    output = readline(open("06/test_input.txt"))
    output = split(output, ",") .|> (x -> parse(Int, x))
    output
end

puzzle_input = read_input()

function one_day(input)
    for fish_idx in 1:length(input)
        if input[fish_idx] == 0
            input[fish_idx] = 6 
            append!(input, 8)
        else
            input[fish_idx] -= 1
        end
    end
    input
end

for days in 1:18
    one_day(puzzle_input)
end

@assert puzzle_input == [6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8]