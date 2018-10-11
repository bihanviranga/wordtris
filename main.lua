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
        {' ',' ',' ',' '},
        {'i','i','i','i'},
        {' ',' ',' ',' '},
        {' ',' ',' ',' '}
    }

    pieceX = 5
    pieceY = 0

    timer = 0
end

function love.update(dt)
    timer = timer + dt
    local timerLimit = 0.5
    if timer >= timerLimit then
        timer = timer - timerLimit
        pieceY = pieceY + 1
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
    -- for y = 1,4 do
    --     for x = 1,4 do
    --         local fcolor = {.47, .76, .94}
    --         love.graphics.setColor(fcolor)
    --         drawBlock(x,y)
    --     end
    -- end

    for y = 1, 4 do
        for x = 1, 4 do
            local block = box[y][x]
            local fcolor = {.47, .76, .94}
            love.graphics.setColor(fcolor)
            drawBlock(x+pieceX,y+pieceY)
        end
    end
end

function love.keypressed(key)
    if key == 'left' then
        pieceX = pieceX - 1
    elseif key == 'right' then
        pieceX = pieceX + 1
    end
end
