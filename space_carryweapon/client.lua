local weaponAdded = false
local animationEnabled = false 

RegisterCommand("carryweapon", function()
    animationEnabled = not animationEnabled 
    local ped = PlayerPedId()

    if animationEnabled then
        TriggerEvent('chat:addMessage', { args = { "[Sistema]", "Animación activada." } })
    else
        TriggerEvent('chat:addMessage', { args = { "[Sistema]", "Animación desactivada." } })
        ResetPedMovementClipset(ped, 0.0)
    end

end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(150)
        local ped = PlayerPedId()

        if animationEnabled then
            if not weaponAdded then
                GiveWeaponToPed(ped, GetHashKey("weapon_petrolcan"), 0, false, true)
                RemoveWeaponFromPed(ped, GetHashKey("weapon_petrolcan"))
                weaponAdded = true
            end

            if IsPedArmed(ped, 4) then
                SetPedWeaponMovementClipset(ped, "move_ped_wpn_jerrycan_generic", 0.50)
            else
                ResetPedMovementClipset(ped, 0.0)
            end
        else
            ResetPedMovementClipset(ped, 0.0)
        end
    end
end)
