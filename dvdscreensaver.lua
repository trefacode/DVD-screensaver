math.randomseed(os.clock())

turn = false

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end
    local resX, resY = getScreenResolution()
    tbl = {
        pos = {x = resX / 2, y = resY / 2},
        size = {x = 400, y = 200},
        angle = math.random(1,360),
        color = randomcolor(),
        texture = renderLoadTextureFromFile("moonloader/resource/dvd.png")
    }
    sampRegisterChatCommand("dvd",function()
        turn = not turn
        if turn then
            tbl.pos.x = resX / 2
            tbl.pos.y = resY / 2
            tbl.angle = math.random(1,360)
            tbl.color = randomcolor()
        end
    end)
    while true do
        if turn then
            draw()
            if tbl.pos.y >= (resY - tbl.size.y) or tbl.pos.y <= 0 or tbl.pos.x >= (resX - tbl.size.x) or tbl.pos.x <= 0 then
                tbl.angle = test(tbl.angle,((tbl.pos.y >= (resY - tbl.size.y) or tbl.pos.y <= tbl.size.y) and 0 or 90))
                tbl.color = randomcolor()
            end
        end
        wait(0)
    end
end

function test(a,b)
    local angle = math.fmod(((180 + a) + 2 * (90 + b - (180 + a)) + 360 *5), 360)
    return (angle > 180 and angle - 360 or angle)
end

function update()
    tbl.pos.x = tbl.pos.x + math.cos(math.rad(tbl.angle)) * 2
    tbl.pos.y = tbl.pos.y + math.sin(math.rad(tbl.angle)) * 2
end

function draw()
    renderDrawTexture(tbl.texture, tbl.pos.x, tbl.pos.y, tbl.size.x, tbl.size.y, 0, tbl.color)
    update()
end

function randomcolor()
    math.randomseed(os.clock())
    return string.format("0xff%06X",join_argb(10,math.random(0, 255), math.random(0, 255), math.random(0, 255)))
end

function join_argb(a, r, g, b)
    local argb = b  -- b
    argb = bit.bor(argb, bit.lshift(g, 8))  -- g
    argb = bit.bor(argb, bit.lshift(r, 16)) -- r
    return argb
end
