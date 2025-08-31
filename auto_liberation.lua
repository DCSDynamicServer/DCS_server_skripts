local logfile = io.open("C:\\DCS Server Liberation\\dcs_liberation.13.0.0\\auto_liberation.log", "a")

local function log(msg)
    net.log(msg)
    if logfile then
        logfile:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. msg .. "\n")
        logfile:flush()
    end
end

local function load_next()
    local miz = "C:\\DCS Server Liberation\\dcs_liberation.13.0.0\\next.miz"
    if lfs.attributes(miz) then
        log("Liberation AutoLoader: Lade " .. miz)
        net.load_mission(miz)
        return true
    else
        log("Liberation AutoLoader: next.miz noch nicht gefunden.")
        return false
    end
end

local function on_end()
    log("Liberation AutoLoader: Mission beendet, starte Liberation-CLI ...")
    os.execute('cmd /c "C:\\DCS Server Liberation\\dcs_liberation.13.0.0\\liberation_next_turn.bat"')

    log("Liberation AutoLoader: Warte auf neue next.miz (max 120 Sekunden) ...")
    local success = false
    for i = 1, 12 do  -- 12 Versuche à 10 Sekunden = 120 Sekunden
        os.execute("ping -n 10 127.0.0.1 > nul") -- 10 Sekunden warten
        if load_next() then
            success = true
            break
        end
    end
    if not success then
        log("Liberation AutoLoader: Keine neue Mission gefunden, Abbruch nach 120 Sekunden!")
    end
end

DCS.setUserCallbacks({
    onSimulationStart = load_next,
    onMissionEnd = on_end
})
