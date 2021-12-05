
function parse_lines()
    line_coords = []
    open("05/test_input.txt") do file
        for ln in eachline(file)
            line_from = split(ln, " -> ")[1]
            line_to = split(ln, " -> ")[2]
            x1 = split(line_from, ",")[1] |> (y -> parse(Int, y))
            y1 = split(line_from, ",")[2] |> (y -> parse(Int, y))
            x2 = split(line_to, ",")[1] |> (y -> parse(Int, y))
            y2 = split(line_to, ",")[2] |> (y -> parse(Int, y))
            push!(line_coords, [(x1, y1), (x2, y2)])
        end
    end
    line_coords
end

line_coords = parse_lines()
board = zeros(Int8, 10, 10)

function place_line(line_coordinates, board)
    for line in line_coordinates
        println("Line: $line")
        x1, y1 = line[1] 
        x2, y2 = line[2]
        x1 += 1; x2 += 1; y1 += 1; y2 += 1;
        if x1 > x2
            x2, x1 = x1, x2
        end
        if y1 > y2
            y2, y1 = y1, y2
        end
        # consider only vertical or horizontal lines
        if x1 == x2 || y1 == y2
            board[y1:y2, x1:x2] .+= 1
        else
            println("($x1,$y1) -> ($x2, $y2) not horizontal")
        end
    end
    board
end

my_board = place_line(line_coords, board)
println(count(i->(i > 1), my_board))

@assert count(i->(i > 1), my_board) == 5