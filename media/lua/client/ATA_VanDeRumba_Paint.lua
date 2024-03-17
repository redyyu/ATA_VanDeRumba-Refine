require "PaintVehicle.lua"

local vehiclePaintTable = {
    ["Base.ATA_VanDeRumba"] = {
        ["White"] = {
            skinIndex = 0,
            paintTable = {
                ["PaintWhite"] = 5,
            }
        },
        ["ChillSummer"] = {
            skinIndex = 1,
            paintTable = {
                ["PaintBlack"] = 3,
                ["PaintPink"] = 1,
                ["PaintYellow"] = 1,
            }
        },
        ["SweetSummer"] = {
            skinIndex = 2,
            paintTable = {
                ["PaintRed"] = 3,
                ["PaintPink"] = 1,
                ["PaintYellow"] = 1,
            }
        },
        ["FoundParadise"] = {
            skinIndex = 3,
            paintTable = {
                ["PaintWhite"] = 1,
                ["PaintPink"] = 1,
                ["PaintYellow"] = 3,
            }
        },
    }
}


local function doFillMenuOutsideVehicle(playerObj, context, vehicle, test)
    local playerInv = playerObj:getInventory()
    local paintPlanTable = vehiclePaintTable[vehicle:getScriptName()]

    if paintPlanTable then
        
        local paintMenuOpt, paintSubMenu = PaintVehicle.getOrCreatePaintMenu(context)
        local menuAvailable = false
        
        for k, v in pairs(paintPlanTable) do
            if (vehicle:getSkinIndex()) ~= v.skinIndex then
                optAvailable = PaintVehicle.createPaintMenuOpt(paintSubMenu,
                                                               playerObj,
                                                               context,
                                                               vehicle,
                                                               v.skinIndex,
                                                               getText("ContextMenu_Paint_"..k),
                                                               v.paintTable,
                                                               'SeatRearLeft')
                if optAvailable then
                    -- any opt available is good to go.
                    menuAvailable = true
                end
            end
        end

        if not menuAvailable then
            paintMenuOpt.notAvailable = true
        end

    end
end


local function onfillMenuOutsideVehicleMenu(player, context, worldobjects, test)
    PaintVehicle.doPrepareOutsideVehicleMenu(player, doFillMenuOutsideVehicle, context, worldobjects, test)
end


Events.OnFillWorldObjectContextMenu.Add(onfillMenuOutsideVehicleMenu)