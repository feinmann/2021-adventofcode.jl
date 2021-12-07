
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

function grow_fish(fish_crowd, days)
    for day in 1:days
        one_day(fish_crowd)
    end
    fish_crowd
end

function grow_fish_crowd(days, input)
    output_crowd = copy(input)
    for day in 1:days
        one_day(output_crowd)
    end
    length(output_crowd)
end

puzzle_input = read_input()

function iterate_thru_swarm(swarm, days)
    number_of_fish = 0
    for fish in swarm
        number_of_fish += grow_fish_crowd(days, Int8[fish])
    end
    number_of_fish
end

days_for_the_puzzle = 80

swarm_delta_1 = iterate_thru_swarm(1, days_for_the_puzzle)
swarm_delta_2 = iterate_thru_swarm(2, days_for_the_puzzle)
swarm_delta_3 = iterate_thru_swarm(3, days_for_the_puzzle)
swarm_delta_4 = iterate_thru_swarm(4, days_for_the_puzzle)
swarm_delta_5 = iterate_thru_swarm(5, days_for_the_puzzle)

my_values_to_solve_this_challenging_riddle = [
    swarm_delta_1, 
    swarm_delta_2,
    swarm_delta_3, 
    swarm_delta_4, 
    swarm_delta_5
    ]

total = 0
for fish in puzzle_input
    total += my_values_to_solve_this_challenging_riddle[fish] 
end

println(total)