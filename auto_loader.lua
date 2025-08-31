-- Auto-Loader: startet nach Missionsende den Liberation-Generator

local function onSimulationStop()
    net.send_chat_to("🔄 Generiere nächste Liberation-Mission...", 0)
    -- Pfad anpassen: hier liegt dein Batch
    os.execute('start "" "C:\\Repos\\DCS_server_skripts\\batch\\generate_mission.bat"')
end

DCS.setUserCallbacks({
    onSimulationStop = onSimulationStop
})
