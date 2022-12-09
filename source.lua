--[[
  // Made by SupLua#0945
  // Don't take this without my permission!
]]

local NotiLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/noSkidlol/Roblox/main/UI-Libs/Notify.lua')))()
local Library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/noSkidlol/Roblox/main/UI-Libs/KeySystem.lua')))()

local Tab = Library:Window("Turtle Obfuscator")

Tab:Label("")

Tab:Box("Type Script Here", function(b)
  _G.ScriptToObfuscate = b
end)

Tab:Button("Obfuscate", function()
  NotiLib:Notify("Turtle Obfuscator", "Script Obfuscating...", 3)
  wait(3)
  NotiLib:Notify("Turtle Obfuscator", "File has been obfuscated.", 3)
  Obfuscate(_G.ScriptToObfuscate)
end)

function Obfuscate(f)
local Script = f
function Encode(Text)
    Text = tostring(Text)
    local Table = {}
    for i = 1, #Text do
        local T = Text:sub(i, i)
        table.insert(Table, T)
    end
    local T = {}
    local MyText = "'"
    for i, v in pairs(Table) do
        local Key = string.byte(v)
        MyText = MyText..math.floor(Key/128)
        Key = Key % 128
        MyText = MyText..math.floor(Key/64)
        Key = Key % 64
        MyText = MyText..math.floor(Key/32)
        Key = Key % 32
        MyText = MyText..math.floor(Key/16)
        Key = Key % 16
        MyText = MyText..math.floor(Key/8)
        Key = Key % 8
        MyText = MyText..math.floor(Key/4)
        Key = Key % 4
        MyText = MyText..math.floor(Key/2)
        Key = Key % 2
        MyText = MyText..math.floor(Key/1)
        Key = Key % 1
        MyText=MyText.."','"
    end
    MyText = MyText:sub(1, #MyText -1)
    if tonumber(MyText) then
        MyText = tonumber(MyText)
    end
    return MyText
end

local Encoded = Encode(Script)
local code = [[local Z={"Turtle Obfuscator"} local BinaryEncrypted = ]].."table.concat({"..Encoded.."})"..[[ function decode(str) local function binary_to_string(bin) return string.char(tonumber(bin, 2));end;return (str:gsub("(".. ("[01]"):rep(8) .. ")", binary_to_string));end;local Binary = BinaryEncrypted _G.EncodedBinary = decode(Binary);loadstring(_G.EncodedBinary)()]]

request({
    Url = _G.WebHook,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Body = game.HttpService:JSONEncode({
        content = "```File has been obfuscated!```"
   })
})

wait(1)

request({
    Url = _G.WebHook,
    Method = "POST",
    Headers = {
        ["Content-Type"] = "application/json"
    },
    Body = game.HttpService:JSONEncode({
        content = "```lua\n"..code.."\n```",
   })
})
end
