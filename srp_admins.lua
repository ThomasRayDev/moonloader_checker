require 'lib.moonloader'
local sampev = require 'lib.samp.events'

local admin_list = {
	{
		nick = "Flazy_Fad",
		level = "10"
	},
	{
		nick = "Donny_Hayes",
		level = "10"
	},
	{
		nick = "El_Capone",
		level = "9"
	},
	{
		nick = "Vyacheslav_Ivankov",
		level = "9"
	},
	{
		nick = "Pavel_Snow",
		level = "7"
	},
	{
		nick = "Carmine_Bonanno",
		level = "6"
	},
	{
		nick = "Leksi_Wayne",
		level = "6"
	},
	{
		nick = "Foren_Smith",
		level = "6"
	},
	{
		nick = "Alessandro_Armani",
		level = "5"
	},
	{
		nick = "Max_Zorety",
		level = "5"
	},
	{
		nick = "Denis_Fat",
		level = "5"
	},
	{
		nick = "Jove_Apples",
		level = "5"
	},
	{
		nick = "Edwyle_Stark",
		level = "5"
	},
	{
		nick = "Molly_Blubery",
		level = "5"
	},
	{
		nick = "Anton_Xabibullin",
		level = "5"
	},
	{
		nick = "Nastya_Fletcher",
		level = "5"
	},
	{
		nick = "Donny_Moon",
		level = "5"
	},
	{
		nick = "Stas_Greh",
		level = "5"
	},
	{
		nick = "Paul_Newman",
		level = "5"
	},
	{
		nick = "Andrey_Reisor",
		level = "5"
	},
	{
		nick = "Funny_Valentine",
		level = "5"
	},
	{
		nick = "Konstantin_Patisson",
		level = "5"
	},
	{
		nick = "Davor_Rodriguez",
		level = "5"
	},
	{
		nick = "Pavel_Volov",
		level = "5"
	},
	{
		nick = "Perfecto_Rodriguez",
		level = "5"
	},
	{
		nick = "Alan_Bam",
		level = "4"
	},
	{
		nick = "Danny_Harper",
		level = "4"
	},
	{
		nick = "Catharina_Schmidt",
		level = "4"
	},
	{
		nick = "Mark_Faster",
		level = "4"
	},
	{
		nick = "Mia_Martinez",
		level = "3"
	},
	{
		nick = "Jesus_Baldassare",
		level = "3"
	},
	{
		nick = "Dmitriy_Kayzer",
		level = "3"
	},
	{
		nick = "Haughty_Hurricane",
		level = "3"
	},
	{
		nick = "Aisau_Mori",
		level = "2"
	},
	{
		nick = "Sean_Breezy",
		level = "2"
	},
	{
		nick = "Oleg_Cassado",
		level = "2"
	},
	{
		nick = "Gleb_Mironov",
		level = "2"
	},
	{
		nick = "Dwayne_Johnsons",
		level = "2"
	},
	{
		nick = "Sombrero_Kazak",
		level = "2"
	},
}

function main()
	if not doesDirectoryExist("moonloader/config/srp_adm_checker") then createDirectory("moonloader/config/srp_adm_checker") end

	if not doesFileExist("moonloader/config/srp_adm_checker/cfg.json") then
		local file = io.open("moonloader/config/srp_adm_checker/cfg.json", "w")
		if file then
			file:write(encodeJson(admin_list))
			file:close()
			print("Config was created and saved.")
		end
	else
		local file = io.open("moonloader/config/srp_adm_checker/cfg.json", "r")
		if file then
			admin_list = decodeJson(file:read("*a"))
			file:close()
		end
	end

	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	
	sampAddChatMessage("I am gay!", -1)

	sampRegisterChatCommand("radmins", cmd_main)
	sampRegisterChatCommand("rsave", cmd_rsave)
	sampRegisterChatCommand("rlist", cmd_rlist)
	sampRegisterChatCommand("redit", cmd_redit)
	sampRegisterChatCommand("rremove", cmd_remove)
	sampRegisterChatCommand("rrender", cmd_render)

	while true do
		wait(0)
	end
end

function cmd_main()
	sampAddChatMessage("===================================", -1)
	sampAddChatMessage("Àäìèíèñòðàòîðû Samp-Rp 02 â ñåòè:", -1)

	for i=0, 1004 do
		if sampIsPlayerConnected(i) then
			local inick = sampGetPlayerNickname(i)

			for _, val in ipairs(admin_list) do
				if inick == val["nick"] then
					sampAddChatMessage(" - " .. inick .. "[" .. i .. "] - " .. val["level"] .. " lvl - ", -1)
				end
			end
		end
	end

	sampAddChatMessage("===================================", -1)
end

function cmd_rsave()
	saveConfig()
end

function cmd_rlist()
	sampAddChatMessage("===================================", -1)
	sampAddChatMessage("Ñïèñîê àäìèíèñòðàòîðîâ Samp-Rp 02:", -1)
	for key, val in ipairs(admin_list) do
		sampAddChatMessage("[" .. key .. "] - " .. val["nick"] .. " (" .. val["level"] .. " lvl) - ", -1)
	end
	sampAddChatMessage("===================================", -1)
end

function cmd_redit(arg)
	local k_key, new_nick, new_level = string.match(arg, "(.+) (.+) (.+)")
	if k_key == nil or k_key == "" then
		sampAddChatMessage("Èñïîëüçóéòå: /redit [êëþ÷] [íèê] [óðîâåíü]", -1)
		sampAddChatMessage("Åñëè âû õîòèòå äîáàâèòü àäìèíèñòðàòîðà, íà ìåñòå [êëþ÷] ïèøèòå \"+\"", -1)
	else
		if k_key == "+" then
			table.insert(admin_list, #admin_list + 1, {nick = new_nick, level = new_level})
			sampAddChatMessage("Äîáàâëåí àäìèíèñòðàòîð " .. new_nick .. " (" .. new_level .. " lvl)", -1)
			saveConfig()
		else
			local old_nick = admin_list[tonumber(k_key)]["nick"]
			local old_level = admin_list[tonumber(k_key)]["level"]
			admin_list[tonumber(k_key)]["nick"] = new_nick
			admin_list[tonumber(k_key)]["level"] = new_level
			sampAddChatMessage("Ñòàðûé íèê: " .. old_nick .. " | Íîâûé íèê: " .. new_nick, -1)
			sampAddChatMessage("Ñòàðûé óðîâåíü: " .. old_level .. " | Íîâûé óðîâåíü: " .. new_level, -1)
			saveConfig()
		end
	end
end

function cmd_remove(arg)
	if #arg == 0 then
		sampAddChatMessage("Èñïîëüçóéòå: /rremove [êëþ÷]", -1)
	else
		if admin_list[tonumber(arg)] ~= nil then
			local old_nick = admin_list[tonumber(arg)]["nick"]
			local old_level = admin_list[tonumber(arg)]["level"]
			table.remove(admin_list, arg)
			sampAddChatMessage("Àäìèíèñòðàòîð " .. old_nick .. " (" .. old_level .. " lvl) óäàëåí.", -1)
			saveConfig()
		else
			sampAddChatMessage("Îøèáêà! Óêàçàííûé ýëåìåíò íå ñóùåñòâóåò.", -1)
		end
	end
end

function cmd_render()
	render_status = not render_status
end

function sampev.onPlayerJoin(playerid, color, isNpc, nickname)
	for _, val in ipairs(admin_list) do
		if nickname == val["nick"] then
			sampAddChatMessage("Àäìèíèñòðàòîð " .. nickname .. "[" .. playerid .. "] (" .. val["level"] .. " lvl) ïîäêëþ÷èëñÿ ê ñåðâåðó", 0xBEBEBE)
		end
	end
end

function sampev.onPlayerQuit(playerid, reason)
	nickname = sampGetPlayerNickname(playerid)

	for _, val in ipairs(admin_list) do
		if nickname == val["nick"] then
			sampAddChatMessage("Àäìèíèñòðàòîð " .. nickname .. "[" .. playerid .. "] (" .. val["level"] .. " lvl) îòêëþ÷èëñÿ îò ñåðâåðà", 0xBEBEBE)
		end
	end
end

function saveConfig()
	if doesFileExist("moonloader/config/srp_adm_checker/cfg.json") then os.remove("moonloader/config/srp_adm_checker/cfg.json") end
	local file = io.open("moonloader/config/srp_adm_checker/cfg.json", "w")
	if file then
		file:write(encodeJson(admin_list))
		file:close()
	end
	sampAddChatMessage("Êîíôèã ñîõðàíåí.", -1)
end
