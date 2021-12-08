
function read_input()
    output = readline(open("07/input.txt"))
    output = split(output, ",") .|> (x -> parse(Int, x))
    output
end

puzzle_input = read_input()

function calculate_fuel_consumptions(input)
    # for every position, calculate the fuelconsumption from every other position
    fuel_consumptions = zeros(Int, length(input))
    for to_idx in 1:length(input)
        consumptions_tmp = zeros(Int, length(input))
        for from_idx in 1:length(input)
            consumptions_tmp[from_idx] = abs(input[to_idx] - input[from_idx])
        end
        fuel_consumptions[to_idx] = sum(consumptions_tmp)
    end
    fuel_consumptions
end

function calculate_fuel_consumptions_2(input)
    # for every _possible_ position, calculate the fuelconsumption from every other position
    fuel_consumptions = zeros(Int, maximum(puzzle_input))
    for from in 1:maximum(puzzle_input)
        consumptions_tmp = zeros(Int, length(input))
        for to_idx in 1:length(input)
            number_of_steps = abs(input[to_idx] - from)
            consumptions_tmp[to_idx] = sum(1:number_of_steps)
        end
        fuel_consumptions[from] = sum(consumptions_tmp)
    end
    fuel_consumptions
end

result = calculate_fuel_consumptions(puzzle_input)
println("The least fuel consumption is ", minimum(result))

result_2 = calculate_fuel_consumptions_2(puzzle_input)
println("The least fuel consumption is ", findmin(result_2)[1], 
        " when switching to horizontal position ", findmin(result_2)[2], ".")
