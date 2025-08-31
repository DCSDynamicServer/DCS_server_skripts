do
    local miz = "C:\\Users\\Administrator\\Saved Games\\DCS.openbeta_server\\Missions\\next.miz"
    if lfs.attributes(miz) then
        net.load_mission(miz)
        net.log("Liberation AutoLoader: Initial mission geladen -> " .. miz)
    else
        net.log("Liberation AutoLoader: next.miz nicht gefunden!")
    end
end

local function on_end()
    net.log("Liberation AutoLoader: Mission beendet, starte Liberation-CLI ...")
    os.execute('cmd /c "C:\\DCS Server Liberation\\dcs_liberation.13.0.0\\liberation_next_turn.bat"')
    net.log("Liberation AutoLoader: Warte 40 Sekunden auf neue Mission ...")
    os.execute("ping -n 40 127.0.0.1 > nul")
    local miz = "C:\\Users\\Administrator\\Saved Games\\DCS.openbeta_server\\Missions\\next.miz"
    if lfs.attributes(miz) then
        net.load_mission(miz)
        net.log("Liberation AutoLoader: Neue Mission geladen -> " .. miz)
    else
        net.log("Liberation AutoLoader: Keine neue Mission gefunden!")
    end
end

DCS.setUserCallbacks({
    onMissionEnd = on_end
})


