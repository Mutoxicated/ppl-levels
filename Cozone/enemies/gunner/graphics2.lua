local gfx = require("/dynamic/helpers/graphics_helpers.lua")

local ax = 7
local ay = 5
local ayOff = 3
local bx = 7
local cy = 11
local white = 0xffffffff
local square_y_off = 4
local sq_x = 7
local sq_y = 5
local extraYOff = 5
local lowerXY = 3
local mult1 = 2.1
local z1,z2,z3 = -2,1,3

local mesh = {
    vertexes = {{-ax,-ay+ayOff,z3},{-ax-bx,-ay+bx+ayOff,z3},{-ax-(bx*2),-ay+(bx/4),z3},{-ax,-ay-cy,z3},{ax,-ay-cy,z3},{ax+(bx*2),-ay+(bx/4),z3},{ax+bx,-ay+bx+ayOff,z3},{ax,-ay+ayOff,z3},
    {sq_x,sq_y+square_y_off,z3},{-sq_x,sq_y+square_y_off,z3},
    {-ax-(bx*2)-extraYOff/8+lowerXY,-ay+(bx/4)-extraYOff-lowerXY,z2},{-ax-extraYOff/8,-ay-cy-extraYOff,z2},{ax+extraYOff/8,-ay-cy-extraYOff,z2},{ax+(bx*2)+extraYOff/8-lowerXY,-ay+(bx/4)-extraYOff-lowerXY,z2},
    {-ax-(bx*2)-(extraYOff/16)*mult1+(lowerXY*2.5),-ay+(bx/4)-extraYOff*mult1-(lowerXY*2.5),z1},{-ax-(extraYOff/16)*mult1,-ay-cy-extraYOff*mult1,z1},{ax+(extraYOff/16)*mult1,-ay-cy-extraYOff*mult1,z1},{ax+(bx*2)+(extraYOff/16)*mult1-(lowerXY*2.5),-ay+(bx/4)-extraYOff*mult1-(lowerXY*2.5),z1},
    
    {-ax-bx-extraYOff/1.5,-ay+bx+ayOff+extraYOff/1.5,z2},{-ax-(bx*2)-extraYOff/1.5,-ay+(bx/4)+extraYOff/1.5,z2},
    {sq_x,sq_y+square_y_off+extraYOff,z2},{-sq_x,sq_y+square_y_off+extraYOff,z2},
    {ax+(bx*2)+extraYOff/1.5,-ay+(bx/4)+extraYOff/1.5,z2},{ax+bx+extraYOff/1.5,-ay+bx+ayOff+extraYOff/1.5,z2},

    {0,-6,z2},{0,12,z2}},
    segments = {{0,1,2,3,4,5,6,7,8,9,0},{10,11,12,13},{14,15,16,17},{18,19},{20,21},{22,23},{24,25}},
    colors = {white,white,white,white,white,white,white,white,white,white,
    white,white,white,white,white,white,white,white,white,white,white,white,white,white,
    white,white}
}

local yOff = math.abs(-ay-cy-extraYOff*mult1)-(sq_y+square_y_off+extraYOff)
for i = 1, 24 do 
    mesh.vertexes[i][2] = mesh.vertexes[i][2] + yOff/2
end

--print(mesh.vertexes[16][2].." | "..mesh.vertexes[21][2])

for i=1,#mesh.vertexes do
    local x = mesh.vertexes[i][1]
    mesh.vertexes[i][1] = mesh.vertexes[i][2]
    mesh.vertexes[i][2] = x
end

local ext = 0.05
local frame_count = 15

local frames = {}

local function extend_lines(vertexes,index1,index2,i)
    local cx,cy = (vertexes[index1][1]+vertexes[index2][1])/2, (vertexes[index1][2]+vertexes[index2][2])/2
    cx,cy = gfx.normalize(cx,cy)
    vertexes[index1][1] = vertexes[index1][1]+ cx * ((i-1)*ext)
    vertexes[index1][2] = vertexes[index1][2]+ cy * ((i-1)*ext)

    vertexes[index2][1] = vertexes[index2][1]+ cx * ((i-1)*ext)
    vertexes[index2][2] = vertexes[index2][2]+ cy * ((i-1)*ext)
end

for i = 1, frame_count do
    local m = gfx.copy(mesh)
    extend_lines(mesh.vertexes,19,20,i)
    extend_lines(mesh.vertexes,21,22,i)
    extend_lines(mesh.vertexes,23,24,i)
    table.insert(frames,m)
end

meshes = frames