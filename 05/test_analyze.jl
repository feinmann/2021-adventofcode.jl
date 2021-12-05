
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


function place_line(line_coordinates, board, consider_diagonals=false)
    for line in line_coordinates
        println("Line: $line")
        reverse_x = false
        reverse_y = false
        x1, y1 = line[1] 
        x2, y2 = line[2]
        x1 += 1; x2 += 1; y1 += 1; y2 += 1;
        if x1 > x2
            x2, x1 = x1, x2
            reverse_x = true
        end
        if y1 > y2
            y2, y1 = y1, y2
            reverse_y = true
        end
        # consider only vertical or horizontal lines
        if x1 == x2 || y1 == y2
            board[y1:y2, x1:x2] .+= 1
        else # this is handling the diagonal case for star #2
            if consider_diagonals
                if reverse_x && reverse_y
                    for line_points in zip(reverse(x1:x2), reverse(y1:y2))
                        board[line_points[2], line_points[1]] += 1
                    end
                elseif reverse_x
                    for line_points in zip(reverse(x1:x2), y1:y2)
                        board[line_points[2], line_points[1]] += 1
                    end
                elseif reverse_y
                    for line_points in zip(x1:x2, reverse(y1:y2))
                        board[line_points[2], line_points[1]] += 1
                    end
                else
                    for line_points in zip(x1:x2, y1:y2)
                        board[line_points[2], line_points[1]] += 1
                    end
                end
            end
        end
    end
    board
end


line_coords = parse_lines()

board_without_diagonals = place_line(line_coords, zeros(Int8, 10, 10))
board_with_diagonals = place_line(line_coords, zeros(Int8, 10, 10), true)

@assert count(i->(i > 1), board_without_diagonals) == 5
@assert count(i->(i > 1), board_with_diagonals) == 12