
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

result = calculate_fuel_consumptions(puzzle_input)
println("The least fuel consumption is ", minimum(result))