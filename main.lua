function love.load()
    love.graphics.setBackgroundColor(255, 255, 255)

    gridXCount = 10
    gridYCount = 18

    inert = {}
    for y = 1, gridYCount do
        inert[y] = {}
        for x = 1, gridXCount do
            inert[y][x] = ' '
        end
    end

    box = {
        {'i','i','i','i'},
        {'i','i','i','i'},
        {'i','i','i','i'},
        {'i','i','i','i'}
    }

    pieceX = 5
    pieceY = 0

    pieceXCount = 4
    pieceYCount = 4

    timer = 0

    inert[8][5] = 'i';


    function canPieceMove(testX, testY)
        for x = 1, pieceXCount do
            for y = 1, pieceYCount do
                if box[y][x] ~= ' '
                and (testX + x) < 1 then
                    return false
                elseif box[y][x] ~= ' '
                and (testX + x) > gridXCount then
                    return false
                elseif box[y][x] ~= ' '
                and (testY + y) > gridYCount then
                    return false
                elseif inert[testY+y][testX+x] ~= ' ' then
                    return false
                end
            end
        end
        return true
    end
end

function love.update(dt)
    timer = timer + dt
    local timerLimit = 0.5
    if timer >= timerLimit then
        timer = timer - timerLimit
        -- pieceY = pieceY + 1
        local testY = pieceY + 1
        if canPieceMove(pieceX,testY) then
            pieceY = testY
        end
    end
end

function love.draw()
    local function drawBlock(x,y)
        local blockSize = 20
        local blockDrawSize = blockSize - 1
        love.graphics.rectangle(
            'fill',
            (x - 1) * blockSize,
            (y - 1) * blockSize,
            blockDrawSize,
            blockDrawSize
        )
    end

    for y = 1,gridYCount do
        for x = 1, gridXCount do
            
            -- local block = inert[y][x]
            local color = {.87, .87, .87}
            love.graphics.setColor(color)
            drawBlock(x,y)
        end
    end

    for y = 1, pieceYCount do
        for x = 1, pieceXCount do
            local block = box[y][x]
            local fcolor = {.47, .76, .94}
            love.graphics.setColor(fcolor)
            drawBlock(x+pieceX,y+pieceY)
        end
    end
end

function love.keypressed(key)
    if key == 'left' then
        local testX = pieceX - 1
        if canPieceMove(testX, pieceY) then
            pieceX = pieceX - 1
        end
    elseif key == 'right' then
        local testX = pieceX + 1
        if canPieceMove(testX, pieceY) then
            pieceX = pieceX + 1
        end
    end
end     
