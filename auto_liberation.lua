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
    else
        log("Liberation AutoLoader: Konnte next.miz nicht finden!")
    end
end

local function on_end()
    log("Liberation AutoLoader: Mission beendet, starte Liberation-CLI ...")
    os.execute('cmd /c "C:\\DCS Server Liberation\\dcs_liberation.13.0.0\\liberation_next_turn.bat"')
    log("Liberation AutoLoader: Warte 40 Sekunden, bevor next.miz geladen wird ...")
    os.execute("ping -n 40 127.0.0.1 > nul")
    load_next()
end

DCS.setUserCallbacks({
    onSimulationStart = load_next,
    onMissionEnd = on_end
})
