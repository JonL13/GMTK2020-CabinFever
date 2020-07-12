function convertTileToPixel(tileX, tileY)
    local x = (tileX - 1) * TILE_SIZE
    local y = (tileY - 1) * TILE_SIZE
    return x, y
end

function convertPixelToTile(x,y)
    local tileX, tileY
    tileX = math.floor(x / TILE_SIZE) + 1
    tileY = math.floor(y / TILE_SIZE) + 1

    return tileX, tileY
end