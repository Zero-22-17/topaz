-----------------------------------
-- Shattering Stars
-- Qu'Bia Arena Maat battlefield
-----------------------------------
require("scripts/globals/battlefield")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/titles")
-----------------------------------

function onBattlefieldTick(battlefield, tick)
    tpz.battlefield.onBattlefieldTick(battlefield, tick)
end

function onBattlefieldRegister(player, battlefield)
end

function onBattlefieldEnter(player, battlefield)
end

function onBattlefieldLeave(player, battlefield, leavecode)
    if leavecode == tpz.battlefield.leaveCode.WON then
        local name, clearTime, partySize = battlefield:getRecord()
        player:startEvent(32001, battlefield:getArea(), clearTime, partySize, battlefield:getTimeInside(), 1, battlefield:getLocalVar("[cs]bit"), 0)
    elseif leavecode == tpz.battlefield.leaveCode.LOST then
        player:startEvent(32002)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 32001 then
        player:addTitle(tpz.title.MAAT_MASHER)

        if player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.SHATTERING_STARS) == QUEST_ACCEPTED then
            npcUtil.giveItem(player, 4181) -- scroll_of_instant_warp
        end

        local maatsCap = player:getCharVar("maatsCap")
        local pjob = player:getMainJob()
        player:setCharVar("maatDefeated", pjob)
        if bit.band(maatsCap, bit.lshift(1, pjob - 1)) ~= 1 then
            player:setCharVar("maatsCap", bit.bor(maatsCap, bit.lshift(1, pjob - 1)))
        end
    end
end
