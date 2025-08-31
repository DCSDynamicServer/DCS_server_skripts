-- Auto-End Script für Liberation Missionen
-- Beendet die Mission nach fester Zeit und gibt vorher eine Warnung

local missionStartTime = nil
local missionDuration = 600   -- 10 Minuten = 600 Sekunden (für Test)
local warningTime = 60        -- 1 Minute vor Ablauf Warnung

DCS.setUserCallbacks({
    onSimulationStart = function()
        missionStartTime = DCS.getModelTime()
        net.send_chat_to("⚠ Mission gestartet. Testlauf: 10 Minuten.", 0)
    end,

    onSimulationFrame = function()
        if missionStartTime then
            local now = DCS.getModelTime()
            local elapsed = now - missionStartTime

            if elapsed >= (missionDuration - warningTime) and elapsed < missionDuration then
                net.send_chat_to("⚠ Mission endet in 1 Minute!", 0)
            end

            if elapsed >= missionDuration then
                net.send_chat_to("⏹ Mission endet jetzt. Neue Mission wird generiert...", 0)
                DCS.stopMission()
                missionStartTime = nil
            end
        end
    end
})
