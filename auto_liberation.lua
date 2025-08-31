local function load_next()
    net.log("Liberation AutoLoader: Lade next.miz ...")
    local miz = "C:\\DCS Server Liberation\\dcs_liberation.13.0.0\\next.miz"
    if lfs.attributes(miz) then
        net.load_mission(miz)
        net.log("Liberation AutoLoader: Mission geladen -> " .. miz)
    else
        net.log("Liberation AutoLoader: Konnte next.miz nicht finden!")
    end
end

local function on_end()
    net.log("Liberation AutoLoader: Mission beendet, starte Liberation-CLI ...")
    -- Batch-Skript ausführen
    os.execute('cmd /c "C:\\DCS Server Liberation\\dcs_liberation.13.0.0\\liberation_next_turn.bat"')
    -- Wartezeit (40 Sekunden), damit Liberation genug Zeit hat, die neue .miz zu schreiben
    net.log("Liberation AutoLoader: Warte 40 Sekunden bevor next.miz geladen wird ...")
    os.execute("ping -n 40 127.0.0.1 > nul")
    -- Neue Mission laden
    load_next()
end

DCS.setUserCallbacks({
    onSimulationStart = load_next,
    onMissionEnd = on_end
})
