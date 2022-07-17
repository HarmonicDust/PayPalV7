-- This file is a seperate file from paypal.

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/HarmonicDust/PayPalV7/main/UI/UI/Library/Library.lua", true))().Initiate("PayPal V7 - Library")

local CreatedTab = Library.CreateTab("Created Tab")

local CreatedSection = CreatedTab.CreateSection("Created Section", true)

CreatedSection.CreateButton("Button", function()
    Library.Notification("Hello!", 5)
end)

CreatedSection.CreateTextbox({Name = "Player", PlayerSelection = true}, function(Player)
    Library.Notification(Player, 7)
end)

CreatedSection.CreateTextbox({Name = "Notification"}, function(Text)
    Library.Notification(Text, 7)
end)

CreatedSection.CreateKeybind("Toggle UI", {Bind = Enum.KeyCode.RightShift}, function()
    Library.ToggleHide()
end)

CreatedSection.CreateSlider("Slider", {Min = 0, Max = 100, Value = 50}, function(Value)
    print(Value)
end)

CreatedSection.CreateToggle("Toggle", {Enabled = false}, function(State)
    print(State)
end)
