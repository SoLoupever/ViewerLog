local addonName, ns = ...

-- Sélecteur numérique [-] valeur [+]. Maj + clic : pas de 5.

ns.UI = ns.UI or {}

function ns.UI.Stepper(parent, min, max, getter, setter, tip)
    local f = CreateFrame("Frame", nil, parent)
    f:SetSize(82, 22)

    local minus = ns.UI.Button(f, 22, 22, "-")
    minus:SetPoint("LEFT")
    local plus = ns.UI.Button(f, 22, 22, "+")
    plus:SetPoint("RIGHT")

    local val = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    val:SetPoint("CENTER")
    ns.UI.Tint(val, "text")

    local function Step(dir)
        local n = (tonumber(getter()) or min) + dir * (IsShiftKeyDown() and 5 or 1)
        setter(math.max(min, math.min(max, n)))
        f.Refresh()
    end
    minus:SetScript("OnClick", function() Step(-1) end)
    plus:SetScript("OnClick",  function() Step(1)  end)

    if tip then
        for _, b in ipairs({ minus, plus }) do
            b:HookScript("OnEnter", function(s)
                GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
                GameTooltip:AddLine(tip, 1, 1, 0.7, true)
                GameTooltip:Show()
            end)
            b:HookScript("OnLeave", function() GameTooltip:Hide() end)
        end
    end

    function f.Refresh()
        val:SetText(tonumber(getter()) or min)
    end

    function f.SetEnabled(on)
        for _, b in ipairs({ minus, plus }) do
            if on then b:Enable() else b:Disable() end
        end
        f:SetAlpha(on and 1 or 0.35)
    end

    f.Refresh()
    return f
end
