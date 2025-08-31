-- Auto Liberation Hook (Variante B)
-- Nutzt den Standard-Namen: liberation_nextturn.miz

-- Mission beim Serverstart laden
do
    local miz = "C:\\Users\\Administrator\\Saved Games\\DCS.openbeta_server\\Missions\\liberation_nextturn.miz"
    if lfs.attributes(miz) then
        net.load_mission(miz)
        net.log("Liberation AutoLoader: Initial mission geladen -> " .. miz)
    else
        net.log("Liberation AutoLoader: liberation_nextturn.miz nicht gefunden!")
    end
end

-- Ablauf bei Missionsende
local function on_end()
    net.log("Liberation AutoLoader: Mission beendet, starte Liberation-CLI ...")

    -- Batch starten -> neue Mission generieren
    os.execute('cmd /c "C:\\DCS Server Liberation\\dcs_liberation.13.0.0\\liberation_next_turn.bat"')

    -- Wartezeit, damit DCS idle ist und die Mission exportiert wurde
    net.log("Liberation AutoLoader: Warte 40 Sekunden ...")
    os.execute("ping -n 40 127.0.0.1 > nul")

    -- Neue Mission laden
    local miz = "C:\\Users\\Administrator\\Saved Games\\DCS.openbeta_server\\Missions\\liberation_nextturn.miz"
    if lfs.attributes(miz) then
        net.load_mission(miz)
        net.log("Liberation AutoLoader: Neue Mission geladen -> " .. miz)
    else
        net.log("Liberation AutoLoader: Konnte liberation_nextturn.miz nicht finden!")
    end
end

DCS.setUserCallbacks({
    onMissionEnd = on_end
})
