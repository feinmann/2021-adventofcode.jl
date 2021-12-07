# day 0: 4, crowd_count = 1
# day 1: 3
# day 2: 2
# day 3: 1
# day 4: 0
# day 5: 6 and another fish with 8, i. e. crowd_count = 2
# day 6: 5 and another fish with 7
# day 7: 4 and another fish with 6
# day 8: 3 and another fish with 5
# day 9: 2 and another fish with 4
#day 10: 1 and another fish with 3
#day 11: 0 and another fish with 2
#day 12: 6 and another fish with 1 and another fish with 8, i.e. crowd_count = 3

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

function grow_fish_crowd(days, input)
    output_crowd = copy(input)
    for day in 1:days
        one_day(output_crowd)
    end
    length(output_crowd)
end

function iterate_thru_swarm(swarm)
    number_of_fish = 0
    for fish in swarm
        number_of_fish += grow_fish_crowd(256, Int8[fish])
    end
    number_of_fish
end

swarm_delta_1 = iterate_thru_swarm(1)
swarm_delta_2 = iterate_thru_swarm(2)
swarm_delta_3 = iterate_thru_swarm(3)
swarm_delta_4 = iterate_thru_swarm(4)
swarm_delta_5 = iterate_thru_swarm(5)

my_values_to_solve_this_challenging_riddle = [swarm_delta_1, swarm_delta_2, swarm_delta_3, swarm_delta_4, swarm_delta_5]

total = 0
for fish in puzzle_input
    total += my_values_to_solve_this_challenging_riddle[fish] 
end