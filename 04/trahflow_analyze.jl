using BenchmarkTools

function parse_board(board_lines)
    board_lines = [parse.(Int, filter(!=(""), split(ln, " "))) for ln in board_lines]
    hcat(board_lines...)
end

parse_draws(line) = parse.(Int, split(line, ","))

function read_data(file)
    board_lines = String[]
    draws = Int[]
    boards = Matrix{Int}[]
    for ln in eachline(file)
        if length(ln) == 0
            if length(board_lines) != 0
                push!(boards, parse_board(board_lines))
            end
            board_lines = String[]
        elseif length(ln) == 14
            push!(board_lines, ln)
            append!
        else
            draws = parse_draws(ln)
        end
    end
    draws, cat(boards..., dims=3)
end

function winning_boards(marks)
    winners = dropdims(any(all(marks, dims=1), dims=2) .| any(all(marks, dims=2), dims=1), dims=(1, 2))
    (1:size(marks)[3])[winners]
end

function score_winning_board(draws, boards)
    marks = zeros(Bool, size(boards))
    winners = Int[]
    i = 0
    while length(winners) == 0
        i += 1
        marks .|= boards .== draws[i]
        winners = winning_boards(marks)
    end
    @assert length(winners) == 1
    winnerboard = @view boards[:, :, winners[1]]
    winnermarks = @view marks[:, :, winners[1]]
    sum((!).(winnermarks) .* winnerboard) * draws[i]
end


draws, boards = open(read_data, "04/input.txt");
@btime score_winning_board(draws, boards)