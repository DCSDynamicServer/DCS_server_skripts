local function auto_load()
    net.log("Liberation AutoLoader: Versuche Mission zu laden...")
    local miz = "C:\\DCS Server Liberation\\dcs_liberation.13.0.0\\next.miz"
    if lfs.attributes(miz) then
        net.load_mission(miz)
        net.log("Liberation AutoLoader: Mission geladen -> " .. miz)
    else
        net.log("Liberation AutoLoader: Konnte next.miz nicht finden!")
    end
end

DCS.setUserCallbacks({ onSimulationStart = auto_load })
