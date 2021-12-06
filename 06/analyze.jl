
function read_input()
    output = readline(open("06/input.txt"))
    output = split(output, ",") .|> (x -> parse(Int, x))
    output
end

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

puzzle_input = read_input()

for days in 1:80
    one_day(puzzle_input)
end

println(length(puzzle_input))