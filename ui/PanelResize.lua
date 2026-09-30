local addonName, ns = ...

-- Poignée de redimensionnement du panneau de paramètres (bas-droite).
-- Même mécanisme visuel que AltViewerLog/ui/MainFrame.lua (grabber
-- Blizzard), appliqué ici au panneau ViewerLog. La taille choisie est
-- persistée dans ViewerLogDB.settings, le même registre déjà utilisé
-- par tout le panneau (cf. Panel.lua) — pas de stockage parallèle.
--
-- Le panneau ViewerLog n'a pas de fond texturé coûteux comme
-- AltViewerLog (juste un backdrop couleur unie) : pas besoin du
-- backdrop temporaire "resize" utilisé là-bas pour limiter le coût
-- de rendu pendant le geste.

ns.UI = ns.UI or {}

function ns.UI.MakeResizeGrip(panel, minW, minH, maxW, maxH, onResizeStop)
    panel:SetResizable(true)
    if panel.SetResizeBounds then
        panel:SetResizeBounds(minW, minH, maxW, maxH)
    else
        panel:SetMinResize(minW, minH)
        panel:SetMaxResize(maxW, maxH)
    end

    local grip = CreateFrame("Frame", nil, panel)
    grip:SetSize(16, 16)
    grip:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -2, 2)
    grip:SetFrameLevel(panel:GetFrameLevel() + 10)
    grip:EnableMouse(true)

    local tex = grip:CreateTexture(nil, "OVERLAY")
    tex:SetAllPoints()
    tex:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
    local hl = grip:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAllPoints()
    hl:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")

    grip:SetScript("OnMouseDown", function(_, btn)
        if btn ~= "LeftButton" then return end
        -- Le panneau est ancré en TOPRIGHT (près du bouton minimap). Sans
        -- renormaliser l'ancrage en TOPLEFT avant le redimensionnement,
        -- une poignée en bas-à-droite ferait grandir le panneau vers la
        -- gauche au lieu de vers le bas-droite (même idiome que
        -- AltViewerLog/ui/MainFrame.lua pour son propre drag de fenêtre).
        local x, y = panel:GetLeft(), panel:GetTop()
        panel:ClearAllPoints()
        panel:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
        panel:StartSizing("BOTTOMRIGHT")
    end)
    grip:SetScript("OnMouseUp", function(_, btn)
        if btn ~= "LeftButton" then return end
        panel:StopMovingOrSizing()

        ViewerLogDB.settings = ViewerLogDB.settings or {}
        ViewerLogDB.settings.panelWidth  = panel:GetWidth()
        ViewerLogDB.settings.panelHeight = panel:GetHeight()

        if onResizeStop then onResizeStop() end
    end)

    panel.resizeGrip = grip
    return grip
end
