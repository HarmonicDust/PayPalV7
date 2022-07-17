--[[ Some of this stuff was directly skidded off haze (lol (sorry))
    (Specifically the slider formula; also thank you vynixu for the keybinds and concept ideas)

    but seriously, thank you so much haze for letting me steal your code without u knowing XD (sorry again lol(please don't be mad(im so sorry please don't cancel me on twitter :((()))
]]

local UI = {}

local function dragify(Frame)
    local dragToggle = nil
    local dragSpeed = .25
    local dragInput = nil
    local dragStart = nil
    local dragPos = nil
    local startPos = nil

    local function updateInput(input)
        local Delta = input.Position - dragStart
        local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
        game:GetService("TweenService"):Create(Frame, TweenInfo.new(.25), {Position = Position}):Play()
    end

    Frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragToggle = true
            dragStart = input.Position
            startPos = Frame.Position
            input.Changed:Connect(function()
                if (input.UserInputState == Enum.UserInputState.End) then
                    dragToggle = false
                end
            end)
        end
    end)

    Frame.InputChanged:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if (input == dragInput and dragToggle) then
            updateInput(input)
        end
    end)
end

UI.Initiate = function(NewTitle)
    local MainUI = {}

	local Library = Instance.new("ScreenGui")
	Library.Name = "Library"
	Library.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Library.IgnoreGuiInset = true
	Library.Parent = game.CoreGui

    MainUI.ToggleHide = function()
        Library.Enabled = not Library.Enabled
    end

    MainUI.EndProcess = function()
        Library:Destroy()
        MainUI = nil
    end

	local Frame = Instance.new("Frame")
	Frame.ZIndex = 11
	Frame.Size = UDim2.new(0, 460, 0, 32)
	Frame.Position = UDim2.new(0, 317, 0, 87)
	Frame.Active = true
	Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Frame.Parent = Library

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = Frame

	local Content = Instance.new("Frame")
	Content.Name = "Content"
	Content.Size = UDim2.new(0, 460, 0, 228)
	Content.Position = UDim2.new(0, 0, 0, 32)
	Content.BorderSizePixel = 0
	Content.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
	Content.Parent = Frame

    MainUI.Notification = function(Text, Duration)
        local Notification = Instance.new("Frame")
        Notification.Name = "Notification"
        Notification.Size = UDim2.new(1, 0, 0, 0)
        Notification.ClipsDescendants = true
        Notification.BorderSizePixel = 0
        Notification.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
        Notification.Parent = Content

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, -52, 1, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Position = UDim2.new(0, 24, 0, 0)
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.FontSize = Enum.FontSize.Size14
        TextLabel.TextSize = 13
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.Text = Text
        TextLabel.TextWrapped = true
        TextLabel.Font = Enum.Font.SourceSansSemibold
        TextLabel.TextWrap = true
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.Parent = Notification

        local ImageButton = Instance.new("ImageButton")
        ImageButton.AnchorPoint = Vector2.new(0, 0.5)
        ImageButton.Size = UDim2.new(0, 8, 0, 8)
        ImageButton.BackgroundTransparency = 1
        ImageButton.Position = UDim2.new(1, -24, 0.5, 0)
        ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ImageButton.Image = "rbxassetid://89960960"
        ImageButton.Parent = Notification
        ImageButton.MouseButton1Down:Connect(function()
            spawn(function()
                game:GetService("TweenService"):Create(Notification, TweenInfo.new(.6, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                wait(2)
                Notification:Destroy()
            end)
        end)
        spawn(function()
            game:GetService("TweenService"):Create(Notification, TweenInfo.new(.6, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 0, 35)}):Play()
            wait(Duration)
            game:GetService("TweenService"):Create(Notification, TweenInfo.new(.6, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 0, 0)}):Play()
            wait(2)
            Notification:Destroy()
        end)
    end

	local UICorner1 = Instance.new("UICorner")
	UICorner1.CornerRadius = UDim.new(0, 6)
	UICorner1.Parent = Content

    Content:GetPropertyChangedSignal("Size"):Connect(function()
        Content.Parent.Size = UDim2.new(0, Content.AbsoluteSize.X, 0, 32)
        Content.Parent.TopRoundHider.Size = UDim2.new(0, Content.AbsoluteSize.X, 0, 21)
        Content.Parent.BottomRoundHider.Size = UDim2.new(0, Content.AbsoluteSize.X, 0, 21)
        
        Content.Main.TabSelection.Size = UDim2.new(0, Content.AbsoluteSize.X - 12, 0, 24)
        Content.Main.Tabs.Size = UDim2.new(0, Content.AbsoluteSize.X - 12, 0, Content.AbsoluteSize.Y - 42)
    end)

	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Size = UDim2.new(1, 0, 1, 0)
	Main.BackgroundTransparency = 1
	Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Main.Parent = Content

	local TabSelection = Instance.new("Frame")
	TabSelection.Name = "TabSelection"
	TabSelection.Size = UDim2.new(0, 448, 0, 24)
	TabSelection.Position = UDim2.new(0.0130435, 0, 0, 0)
	TabSelection.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
	TabSelection.Parent = Main

	local UICorner2 = Instance.new("UICorner")
	UICorner2.CornerRadius = UDim.new(0, 6)
	UICorner2.Parent = TabSelection

	local ScrollingFrame = Instance.new("ScrollingFrame")
	ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.Active = true
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame.ScrollBarThickness = 0
	ScrollingFrame.Parent = TabSelection

	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)
	UIListLayout.Parent = ScrollingFrame
    UIListLayout.HorizontalAlignment = "Left"
    UIListLayout.FillDirection = "Horizontal"

    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ScrollingFrame.CanvasSize = UDim2.new(0, UIListLayout.AbsoluteContentSize.X + 6, 0, 0)
    end)

	local UIPadding = Instance.new("UIPadding")
	UIPadding.PaddingLeft = UDim.new(0, 4)
	UIPadding.Parent = ScrollingFrame

	local UIListLayout1 = Instance.new("UIListLayout")
	UIListLayout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout1.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout1.Padding = UDim.new(0, 6)
	UIListLayout1.Parent = Main

	local UIPadding1 = Instance.new("UIPadding")
	UIPadding1.PaddingTop = UDim.new(0, 6)
	UIPadding1.Parent = Main

	local Tabs = Instance.new("Frame")
	Tabs.Name = "Tabs"
	Tabs.Size = UDim2.new(0, 448, 0, 186)
	Tabs.Position = UDim2.new(0.0130435, 0, 0.1351351, 0)
	Tabs.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	Tabs.Parent = Main

	local UICorner4 = Instance.new("UICorner")
	UICorner4.CornerRadius = UDim.new(0, 6)
	UICorner4.Parent = Tabs

    MainUI.CreateTab = function(Name)
        local CreatedTab = {}

        local Tab = Instance.new("ScrollingFrame")
        Tab.Name = Name
        Tab.Size = UDim2.new(1, 0, 1, 0)
        Tab.BackgroundTransparency = 1
        Tab.Active = true
        Tab.Visible = false
        Tab.BorderSizePixel = 0
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.ScrollBarThickness = 4
        Tab.Parent = Tabs

        local TextButton = Instance.new("TextButton")
        TextButton.Size = UDim2.new(0, 78, 0, 16)
        TextButton.Position = UDim2.new(0, 0, 0.1666667, 0)
        TextButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TextButton.FontSize = Enum.FontSize.Size14
        TextButton.TextSize = 14
        TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextButton.Text = Name
        TextButton.Font = Enum.Font.SourceSansSemibold
        TextButton.Parent = ScrollingFrame

        TextButton:GetPropertyChangedSignal("TextBounds"):Connect(function()
            TextButton.Size = UDim2.new(0, TextButton.TextBounds.X + 36, 0, 16)
        end)

        TextButton.MouseButton1Down:Connect(function()
            for i,v in next, Tabs:GetChildren() do
                if string.find(v.ClassName, "Frame") then
                    if v.Name == Tab.Name then
                        v.Visible = true
                    else
                        v.Visible = false
                    end
                end
            end
        end)

        local UICorner3 = Instance.new("UICorner")
        UICorner3.CornerRadius = UDim.new(0, 5)
        UICorner3.Parent = TextButton

        local UIPadding2 = Instance.new("UIPadding")
        UIPadding2.PaddingTop = UDim.new(0, 4)
        UIPadding2.PaddingLeft = UDim.new(0, 4)
        UIPadding2.Parent = Tab

        local UIListLayout2 = Instance.new("UIListLayout")
        UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout2.Padding = UDim.new(0, 4)
        UIListLayout2.Parent = Tab

        UIListLayout2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Tab.CanvasSize = UDim2.new(0, 0, 0, UIListLayout2.AbsoluteContentSize.Y + 8)
        end)

        CreatedTab.CreateSection = function(Name, Default)
            local CreatedSection = {}

            local Frame1 = Instance.new("Frame")
            Frame1.Size = UDim2.new(1, -8, 0, 147)
            Frame1.ClipsDescendants = true
            Frame1.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
            Frame1.Parent = Tab

            local Hb = Instance.new("TextButton")
            Hb.Name = "Hb"
            Hb.Size = UDim2.new(1, 0, 0, 33)
            Hb.BackgroundTransparency = 1
            Hb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hb.AutoButtonColor = false
            Hb.FontSize = Enum.FontSize.Size14
            Hb.TextSize = 14
            Hb.TextColor3 = Color3.fromRGB(0, 0, 0)
            Hb.Text = ""
            Hb.Font = Enum.Font.SourceSans
            Hb.Parent = Frame1

            local UICorner5 = Instance.new("UICorner")
            UICorner5.CornerRadius = UDim.new(0, 6)
            UICorner5.Parent = Frame1

            local TextLabel = Instance.new("TextLabel")
            TextLabel.Size = UDim2.new(0, 202, 0, 19)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Position = UDim2.new(0, 14, 0, 7)
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.FontSize = Enum.FontSize.Size18
            TextLabel.TextSize = 15
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.Text = Name
            TextLabel.Font = Enum.Font.SourceSansBold
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel.Parent = Frame1

            local ImageLabel = Instance.new("ImageLabel")
            ImageLabel.Size = UDim2.new(0, 16, 0, 16)
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.Position = UDim2.new(1, -26, 0, 8)
            ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ImageLabel.ImageRectOffset = Vector2.new(200, 550)
            ImageLabel.ImageRectSize = Vector2.new(50, 50)
            ImageLabel.Image = "rbxassetid://6764432408"
            ImageLabel.Parent = Frame1

            local Frame2 = Instance.new("Frame")
            Frame2.Size = UDim2.new(1, -28, 0, 4)
            Frame2.Position = UDim2.new(0, 14, 0, 33)
            Frame2.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
            Frame2.Parent = Frame1

            local UIPadding5 = Instance.new("UIPadding")
            UIPadding5.PaddingTop = UDim.new(0, 4)
            -- UIPadding5.PaddingLeft = UDim.new(0, 2)
            UIPadding5.Parent = Frame2

            local UIListLayout7 = Instance.new("UIListLayout")
            UIListLayout7.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout7.Padding = UDim.new(0, 4)
            UIListLayout7.Parent = Frame2
            UIListLayout7.HorizontalAlignment = "Center"

            spawn(function()
                task.wait()
                if Default == true then
                    ImageLabel.Rotation = 180
                    Frame1.Size = UDim2.new(1, -8, 0, UIListLayout7.AbsoluteContentSize.Y + 50)
                    Frame2.Size = UDim2.new(1, -28, 0, UIListLayout7.AbsoluteContentSize.Y + 8)
                else
                    ImageLabel.Rotation = 0
                    Frame1.Size = UDim2.new(1, -8, 0, 33)
                    Frame2.Size = UDim2.new(1, -28, 0, 8)
                end
            end)

            Hb.MouseButton1Down:Connect(function()
                Default = not Default

                if Default == true then
                    game:GetService("TweenService"):Create(ImageLabel, TweenInfo.new(0.5), { Rotation = 180 }):Play()
                    game:GetService("TweenService"):Create(Frame1, TweenInfo.new(0.5), { Size = UDim2.new(1, -8, 0, UIListLayout7.AbsoluteContentSize.Y + 50) }):Play()
                    game:GetService("TweenService"):Create(Frame2, TweenInfo.new(0.5), { Size = UDim2.new(1, -28, 0, UIListLayout7.AbsoluteContentSize.Y + 8) }):Play()
                else
                    game:GetService("TweenService"):Create(ImageLabel, TweenInfo.new(0.5), { Rotation = 0 }):Play()
                    game:GetService("TweenService"):Create(Frame1, TweenInfo.new(0.5), { Size = UDim2.new(1, -8, 0, 33) }):Play()
                    game:GetService("TweenService"):Create(Frame2, TweenInfo.new(0.5), { Size = UDim2.new(1, -28, 0, 8) }):Play()
                end
            end)

            local UICorner6 = Instance.new("UICorner")
            UICorner6.CornerRadius = UDim.new(0, 6)
            UICorner6.Parent = Frame2

            CreatedSection.CreateButton = function(Text, Callback)
                local CreatedButton = {}

                local Button = Instance.new("TextButton")
                Button.Name = "Button"
                Button.Size = UDim2.new(1, -8, 0, 28)
                Button.ClipsDescendants = true
                Button.BorderSizePixel = 0
                Button.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                Button.FontSize = Enum.FontSize.Size18
                Button.TextSize = 15
                Button.Text = Text
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.Font = Enum.Font.SourceSans
                Button.Parent = Frame2

                local UICorner7 = Instance.new("UICorner")
                UICorner7.CornerRadius = UDim.new(0, 6)
                UICorner7.Parent = Button

                local Sample = Instance.new("ImageLabel")
                Sample.Name = "Sample"
                Sample.BackgroundTransparency = 1
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.ImageTransparency = 0.65
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.Parent = Button

                function CreatedButton:Remove()
                    TweenService:Create(Button, TweenInfo.new(.25, Enum.EasingStyle.Back), {Size = UDim2.new(1.1, 0,0, 32)}):Play()
                    task.wait(.2)
                    TweenService:Create(Button, TweenInfo.new(.25, Enum.EasingStyle.Back), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                    wait(.25)
                    Button:Destroy()
                end

                function CreatedButton:Callback()
                    local TweenService = game:GetService("TweenService")

                    spawn(function()
                        Callback()
                    end)

                    TweenService:Create(Button, TweenInfo.new(.25, Enum.EasingStyle.Back), {TextSize = 5}):Play()
                    task.wait(.1)
                    TweenService:Create(Button, TweenInfo.new(.25, Enum.EasingStyle.Back), {TextSize = 15}):Play()
                    
                    local c = Sample:Clone()
                    c.Parent = Button
                    c.Position = UDim2.new(0.5, 0, 0.5, 0)
                    local len, size = 0.75, nil
                    if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
                        size = (Button.AbsoluteSize.X * 1.5)
                    else
                        size = (Button.AbsoluteSize.Y * 1.5)
                    end
                    c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                    for i = 1, 10 do
                        c.ImageTransparency = c.ImageTransparency + 0.05
                        wait(len / 12)
                    end
                    c:Destroy()
                end

                Button.MouseButton1Down:Connect(CreatedButton.Callback)
                return CreatedButton
            end

            CreatedSection.CreateKeybind = function(Text, Settings, Callback)
                local CreatedKeybind = {}

                local Keybind = Instance.new("TextButton")
                Keybind.Name = "Keybind"
                Keybind.Size = UDim2.new(1, -8, 0, 28)
                Keybind.ClipsDescendants = true
                Keybind.Position = UDim2.new(0.0445545, 0, -0.0416667, 0)
                Keybind.BorderSizePixel = 0
                Keybind.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                Keybind.FontSize = Enum.FontSize.Size18
                Keybind.TextSize = 15
                Keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
                Keybind.Text = ""
                Keybind.Font = Enum.Font.SourceSans
                Keybind.Parent = Frame2

                function CreatedKeybind:Remove()
                    TweenService:Create(Keybind, TweenInfo.new(.25, Enum.EasingStyle.Back), {Size = UDim2.new(1.1, 0,0, 32)}):Play()
                    task.wait(.2)
                    TweenService:Create(Keybind, TweenInfo.new(.25, Enum.EasingStyle.Back), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                    wait(.25)
                    Keybind:Destroy()
                end

                local UICorner8 = Instance.new("UICorner")
                UICorner8.CornerRadius = UDim.new(0, 6)
                UICorner8.Parent = Keybind

                local Sample1 = Instance.new("ImageLabel")
                Sample1.Name = "Sample"
                Sample1.BackgroundTransparency = 1
                Sample1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample1.ImageTransparency = 0.65
                Sample1.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample1.Parent = Keybind

                local TextLabel1 = Instance.new("TextLabel")
                TextLabel1.Size = UDim2.new(0, 202, 0, 28)
                TextLabel1.BackgroundTransparency = 1
                TextLabel1.Position = UDim2.new(0, 6, 0, 0)
                TextLabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel1.FontSize = Enum.FontSize.Size18
                TextLabel1.TextSize = 15
                TextLabel1.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel1.Text = Text
                TextLabel1.Font = Enum.Font.SourceSans
                TextLabel1.TextXAlignment = Enum.TextXAlignment.Left
                TextLabel1.Parent = Keybind

                local Utilities = Instance.new("Frame")
                Utilities.Name = "Utilities"
                Utilities.Size = UDim2.new(1, 0, 1, 0)
                Utilities.BackgroundTransparency = 1
                Utilities.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Utilities.Parent = Keybind

                local UIListLayout3 = Instance.new("UIListLayout")
                UIListLayout3.HorizontalAlignment = Enum.HorizontalAlignment.Right
                UIListLayout3.VerticalAlignment = Enum.VerticalAlignment.Center
                UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout3.Parent = Utilities

                local UIPadding3 = Instance.new("UIPadding")
                UIPadding3.PaddingRight = UDim.new(0, 6)
                UIPadding3.Parent = Utilities

                local Main1 = Instance.new("Frame")
                Main1.Name = "Main"
                Main1.Size = UDim2.new(0, 76, 0, 18)
                Main1.BackgroundTransparency = 1
                Main1.Position = UDim2.new(0.8232558, 0, 0.1785714, 0)
                Main1.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
                Main1.Parent = Utilities

                local BindBg = Instance.new("Frame")
                BindBg.Name = "BindBg"
                BindBg.Size = UDim2.new(1, 0, 1, 0)
                BindBg.Position = UDim2.new(0.8232558, 0, 0.1785714, 0)
                BindBg.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
                BindBg.Parent = Main1

                local UICorner9 = Instance.new("UICorner")
                UICorner9.CornerRadius = UDim.new(0, 4)
                UICorner9.Parent = BindBg

                local BindText = Instance.new("TextLabel")
                BindText.Name = "BindText"
                BindText.Size = UDim2.new(1, 0, 1, 0)
                BindText.BackgroundTransparency = 1
                BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                BindText.FontSize = Enum.FontSize.Size14
                BindText.TextSize = 13
                BindText.TextColor3 = Color3.fromRGB(255, 255, 255)
                BindText.Text = ""
                BindText.Font = Enum.Font.SourceSansSemibold
                BindText.Parent = BindBg

                local UIListLayout4 = Instance.new("UIListLayout")
                UIListLayout4.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIListLayout4.VerticalAlignment = Enum.VerticalAlignment.Center
                UIListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout4.Parent = Main1

                local UIS = game:GetService("UserInputService")

				local Binder = {}

				local ChangeText = function(New)
					BindText.Text = New
				end

				function BindInput()
					ChangeText("...")

					local Connection
					Connection = UIS.InputBegan:Connect(function(input, processed)
						if not processed and not tostring(input.UserInputType):find("Mouse") then
							Connection:Disconnect()
							Set(input.KeyCode)
						end
					end)
				end

				function Set(Bind)
					Settings.Bind = Bind
					ChangeText(Bind.Name)
				end

				table.insert(Binder, Bind)
				Set(Settings.Bind)

				if not true then
					Set(BindText.Text)
				end

				UIS.InputBegan:Connect(function(input, processed)
					if not processed and input.KeyCode == Settings.Bind then
						Callback()
					end
				end)

				Keybind.InputBegan:Connect(function(Input, Processed)
					if not Processed then
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						    BindInput()
                        end
					end
				end)

                Keybind.MouseButton1Down:Connect(function()
                    local TweenService = game:GetService("TweenService")
                    TweenService:Create(BindBg, TweenInfo.new(.35, Enum.EasingStyle.Back), {Size = UDim2.new(.7, 0,.7, 0)}):Play()
                    TweenService:Create(BindBg.BindText, TweenInfo.new(.35, Enum.EasingStyle.Back), {TextSize = 15}):Play()
                    task.wait(.1)
                    TweenService:Create(BindBg, TweenInfo.new(.35, Enum.EasingStyle.Back), {Size = UDim2.new(1, 0,1, 0)}):Play()
                    TweenService:Create(BindText, TweenInfo.new(.35, Enum.EasingStyle.Back), {TextSize = 13}):Play()
                    task.wait(.1)
                    local c = Sample1:Clone()
                    c.Parent = Keybind
                    c.Position = UDim2.new(1, 0, 0.5, 0)
                    local len, size = 0.75, nil
                    if Keybind.AbsoluteSize.X >= Keybind.AbsoluteSize.Y then
                        size = (Keybind.AbsoluteSize.X * 1.5)
                    else
                        size = (Keybind.AbsoluteSize.Y * 1.5)
                    end
                    c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                    for i = 1, 10 do
                        c.ImageTransparency = c.ImageTransparency + 0.05
                        wait(len / 12)
                    end
                    c:Destroy()
                end)
                return CreatedKeybind
            end

            CreatedSection.CreateSlider = function(Text, Settings, Callback)
                local CreatedSlider = {}
                
                local Slider = Instance.new("TextButton")
                Slider.Name = "Slider"
                Slider.Size = UDim2.new(1, -8, 0, 50)
                Slider.ClipsDescendants = true
                Slider.Position = UDim2.new(0.0098039, 0, 0, 0)
                Slider.Active = false
                Slider.BorderSizePixel = 0
                Slider.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                Slider.AutoButtonColor = false
                Slider.FontSize = Enum.FontSize.Size18
                Slider.TextSize = 15
                Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
                Slider.Text = ""
                Slider.Font = Enum.Font.SourceSans
                Slider.Parent = Frame2

                function CreatedSlider:Remove()
                    TweenService:Create(Slider, TweenInfo.new(.25, Enum.EasingStyle.Back), {Size = UDim2.new(1.1, 0,0, 54)}):Play()
                    task.wait(.2)
                    TweenService:Create(Slider, TweenInfo.new(.25, Enum.EasingStyle.Back), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                    wait(.25)
                    Slider:Destroy()
                end

                local UICorner1 = Instance.new("UICorner")
                UICorner1.CornerRadius = UDim.new(0, 6)
                UICorner1.Parent = Slider

                local Title = Instance.new("TextLabel")
                Title.Name = "Title"
                Title.Text = Text
                Title.Size = UDim2.new(0, 188, 0, 12)
                Title.BackgroundTransparency = 1
                Title.Position = UDim2.new(0, 12, 0, 6)
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.FontSize = Enum.FontSize.Size14
                Title.TextSize = 14
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.Font = Enum.Font.SourceSans
                Title.TextXAlignment = Enum.TextXAlignment.Left
                Title.Parent = Slider

                local Value = Instance.new("TextBox")
                Value.Name = "Value"
                Value.Size = UDim2.new(0, 60, 0, 12)
                Value.BackgroundTransparency = 1
                Value.Position = UDim2.new(1, -68, 0.12, 0)
                Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Value.FontSize = Enum.FontSize.Size14
                Value.TextSize = 14
                Value.TextColor3 = Color3.fromRGB(255, 255, 255)
                Value.Text = ""
                Value.PlaceholderText = "..."
                Value.Font = Enum.Font.SourceSansBold
                Value.TextXAlignment = Enum.TextXAlignment.Right
                Value.Parent = Slider

                local Bg = Instance.new("Frame")
                Bg.Name = "Bg"
                Bg.AnchorPoint = Vector2.new(0.5, 0)
                Bg.Size = UDim2.new(1, -20, 0, 6)
                Bg.Position = UDim2.new(0.5, 0, 0.66, 0)
                Bg.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
                Bg.Parent = Slider

                local UICorner2 = Instance.new("UICorner")
                UICorner2.CornerRadius = UDim.new(1, 0)
                UICorner2.Parent = Bg

                local Indicator = Instance.new("Frame")
                Indicator.Name = "Indicator"
                Indicator.Size = UDim2.new(0, 188, 0, 6)
                Indicator.BorderSizePixel = 0
                Indicator.BackgroundColor3 = Color3.fromRGB(42, 53, 115)
                Indicator.Parent = Bg

                local UICorner3 = Instance.new("UICorner")
                UICorner3.CornerRadius = UDim.new(1, 0)
                UICorner3.Parent = Indicator

                local Circle = Instance.new("Frame")
                Circle.Name = "Circle"
                Circle.AnchorPoint = Vector2.new(0.5, 0.5)
                Circle.Size = UDim2.new(0, 10, 0, 10)
                Circle.Position = UDim2.new(1, 0, 0.45, 0)
                Circle.BorderSizePixel = 0
                Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Circle.Parent = Indicator

                local UICorner4 = Instance.new("UICorner")
                UICorner4.CornerRadius = UDim.new(1, 0)
                UICorner4.Parent = Circle

                local UIPadding = Instance.new("UIPadding")
                UIPadding.PaddingTop = UDim.new(0, 4)
                UIPadding.Parent = Frame2

                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 4)
                UIListLayout.Parent = Frame2

                local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

                local IsSliding = false
                local UserInputService = game:GetService("UserInputService")

                CreatedSlider.Set = function(New)
                    New = New or Settings.Min
                    if New >= Settings.Min and New <= Settings.Max then
                        Settings.Value = New
                    else
                        Settings.Value = Settings.Min
                    end
                    Value.Text = tostring(Settings.Value) .. "/" .. tostring(Settings.Max)
                    game:GetService("TweenService"):Create(Indicator, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = UDim2.new(New/Settings.Max, 0, 1, 0)}):Play()
                    Callback(Settings.Value)
                end

                CreatedSlider.Set(Settings.Value)

                Value.FocusLost:Connect(function()
                    if tonumber(Value.Text) and tonumber(Value.Text) >= Settings.Min and tonumber(Value.Text) <= Settings.Max then
                        CreatedSlider.Set(tonumber(Value.Text))
                    else
                        CreatedSlider.Set(Settings.Min)
                    end
                end)

                Slider.MouseButton1Down:Connect(function()
                    IsSliding = true
                end)

                Slider.InputEnded:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        IsSliding = false
                    end
                end)

                local Mouse = game.Players.LocalPlayer:GetMouse()

                local function IsMouseInBoundOf(FrameInBound)
                    local X_Pos, Y_Pos = Mouse.X - FrameInBound.AbsolutePosition.X, Mouse.Y - FrameInBound.AbsolutePosition.Y
                    local X_Size, Y_Size = FrameInBound.AbsoluteSize.X, FrameInBound.AbsoluteSize.Y
                    if X_Pos >= 0 and Y_Pos >= 0 and X_Pos <= X_Size and Y_Pos <= Y_Size then
                        return X_Pos/X_Size, Y_Pos/Y_Size
                    end
                    return nil, nil
                end

                game:GetService("RunService").RenderStepped:Connect(function()
                    if IsSliding and IsMouseInBoundOf(Slider) then
                        local Pos = Mouse.X - Slider.AbsolutePosition.X
                        if Pos >= Slider.AbsoluteSize.X then
                            Pos = Slider.AbsoluteSize.X
                        end
                        CreatedSlider.Set(math.floor((Pos/Slider.AbsoluteSize.X)*Settings.Max+0.5))
                    end
                end)
                return CreatedSlider
            end

            CreatedSection.CreateTextbox = function(Settings, Callback)
                local CreatedTextbox = {}

                local Textbox = Instance.new("TextButton")
                Textbox.Name = "Textbox"
                Textbox.Size = UDim2.new(1, -8, 0, 58)
                Textbox.ClipsDescendants = true
                Textbox.Position = UDim2.new(0.0098039, 0, 0, 0)
                Textbox.Active = false
                Textbox.BorderSizePixel = 0
                Textbox.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                Textbox.AutoButtonColor = false
                Textbox.FontSize = Enum.FontSize.Size18
                Textbox.TextSize = 15
                Textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
                Textbox.Text = ""
                Textbox.Font = Enum.Font.SourceSans
                Textbox.Parent = Frame2

                function CreatedTextbox:Remove()
                    TweenService:Create(Textbox, TweenInfo.new(.25, Enum.EasingStyle.Back), {Size = UDim2.new(1.1, 0,0, 64)}):Play()
                    task.wait(.2)
                    TweenService:Create(Textbox, TweenInfo.new(.25, Enum.EasingStyle.Back), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                    wait(.25)
                    Textbox:Destroy()
                end

                local UICorner = Instance.new("UICorner")
                UICorner.CornerRadius = UDim.new(0, 6)
                UICorner.Parent = Textbox

                local Title = Instance.new("TextLabel")
                Title.Name = "Title"
                Title.Size = UDim2.new(0, 188, 0, 12)
                Title.BackgroundTransparency = 1
                Title.Position = UDim2.new(0, 12, 0, 6)
                Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Title.FontSize = Enum.FontSize.Size14
                Title.TextSize = 14
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.Text = Settings.Name or "Created Textbox"
                Title.Font = Enum.Font.SourceSans
                Title.TextXAlignment = Enum.TextXAlignment.Left
                Title.Parent = Textbox

                local Main = Instance.new("Frame")
                Main.Name = "Main"
                Main.AnchorPoint = Vector2.new(0.5, 0.5)
                Main.Size = UDim2.new(1, -20, 0, 28)
                Main.Position = UDim2.new(0.5, 0, 0, 38)
                Main.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
                Main.Parent = Textbox

                local UICorner1 = Instance.new("UICorner")
                UICorner1.CornerRadius = UDim.new(0, 6)
                UICorner1.Parent = Main

                local TextMain = Instance.new("TextBox")
                TextMain.Name = "TextMain"
                TextMain.Size = UDim2.new(1, -8, 1, 0)
                TextMain.BackgroundTransparency = 1
                TextMain.Position = UDim2.new(0, 8, 0, 0)
                TextMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextMain.FontSize = Enum.FontSize.Size14
                TextMain.TextSize = 14
                TextMain.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextMain.Text = Settings.Text or ""
                TextMain.PlaceholderText = "..."
                TextMain.CursorPosition = -1
                TextMain.Font = Enum.Font.SourceSansSemibold
                TextMain.TextXAlignment = Enum.TextXAlignment.Left
                TextMain.Parent = Main

                function CreatedTextbox:Callback(New)
                    Callback(New)
                end

                function CreatedTextbox:Set(New)
                    TextMain.Text = New
                    CreatedTextbox:Callback(New)
                end

                if Settings.PlayerSelection == nil then
                    Settings.PlayerSelection = false
                end

                TextMain.FocusLost:Connect(function()
                    if Settings.PlayerSelection then
                        local OldCallback = Callback
                        Callback = function()
                            for i,v in next, game:GetService("Players"):GetPlayers() do
                                if (string.sub(string.lower(v.Name), 1, string.len(TextMain.Text))) == string.lower(TextMain.Text) or (string.sub(string.lower(v.DisplayName), 1, string.len(TextMain.Text))) == string.lower(TextMain.Text) then
                                    TextMain.Text = v.Name
                                    OldCallback(TextMain.Text)
                                end
                            end
                        end
                    end
                    Callback(TextMain.Text)
                end)
                return CreatedTextbox
            end

            CreatedSection.CreateToggle = function(Text, Settings, Callback)
                local CreatedToggle = {}

                local Toggle = Instance.new("TextButton")
                Toggle.Name = "Toggle"
                Toggle.Size = UDim2.new(1, -8, 0, 28)
                Toggle.ClipsDescendants = true
                Toggle.BorderSizePixel = 0
                Toggle.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
                Toggle.FontSize = Enum.FontSize.Size18
                Toggle.TextSize = 15
                Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                Toggle.Text = ""
                Toggle.Font = Enum.Font.SourceSans
                Toggle.Parent = Frame2

                function CreatedToggle:Remove()
                    TweenService:Create(Toggle, TweenInfo.new(.25, Enum.EasingStyle.Back), {Size = UDim2.new(1.1, 0,0, 32)}):Play()
                    task.wait(.2)
                    TweenService:Create(Toggle, TweenInfo.new(.25, Enum.EasingStyle.Back), {Size = UDim2.new(0, 0, 0, 0)}):Play()
                    wait(.25)
                    Toggle:Destroy()
                end

                local UICorner10 = Instance.new("UICorner")
                UICorner10.CornerRadius = UDim.new(0, 6)
                UICorner10.Parent = Toggle

                local Sample2 = Instance.new("ImageLabel")
                Sample2.Name = "Sample"
                Sample2.BackgroundTransparency = 1
                Sample2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample2.ImageTransparency = 0.65
                Sample2.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample2.Parent = Handler2

                local Name = Instance.new("TextLabel")
                Name.Name = "Name"
                Name.Size = UDim2.new(0, 202, 0, 28)
                Name.BackgroundTransparency = 1
                Name.Position = UDim2.new(0, 6, 0, 0)
                Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Name.FontSize = Enum.FontSize.Size18
                Name.TextSize = 15
                Name.TextColor3 = Color3.fromRGB(255, 255, 255)
                Name.Text = Text
                Name.Font = Enum.Font.SourceSans
                Name.TextXAlignment = Enum.TextXAlignment.Left
                Name.Parent = Toggle

                local Checkbox = Instance.new("Frame")
                Checkbox.Name = "Checkbox"
                Checkbox.Size = UDim2.new(0, 40, 0, 18)
                Checkbox.Position = UDim2.new(1, -46, 0.178, 0)
                Checkbox.BorderSizePixel = 0
                Checkbox.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                Checkbox.Parent = Toggle

                local UICorner11 = Instance.new("UICorner")
                UICorner11.CornerRadius = UDim.new(0, 4)
                UICorner11.Parent = Checkbox

                local UIListLayout5 = Instance.new("UIListLayout")
                UIListLayout5.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIListLayout5.VerticalAlignment = Enum.VerticalAlignment.Center
                UIListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout5.Parent = Checkbox

                local FramePadding = Instance.new("UIPadding")
                FramePadding.Name = "FramePadding"
                FramePadding.PaddingLeft = UDim.new(0, -18)
                FramePadding.Parent = Checkbox

                local Indicator = Instance.new("Frame")
                Indicator.Name = "Indicator"
                Indicator.Size = UDim2.new(0, 18, 0, 14)
                Indicator.Position = UDim2.new(1, -56, 0.178, 0)
                Indicator.BorderSizePixel = 0
                Indicator.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                Indicator.Parent = Checkbox

                local UICorner12 = Instance.new("UICorner")
                UICorner12.CornerRadius = UDim.new(0, 4)
                UICorner12.Parent = Indicator

                local UIListLayout6 = Instance.new("UIListLayout")
                UIListLayout6.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIListLayout6.VerticalAlignment = Enum.VerticalAlignment.Center
                UIListLayout6.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout6.Parent = Indicator

                local UIPadding4 = Instance.new("UIPadding")
                UIPadding4.Parent = Indicator

                local TweenService = game:GetService("TweenService")

                if Settings.Enabled then
                    FramePadding.PaddingLeft = UDim.new(0, 18)
                    Indicator.BackgroundColor3 = Color3.fromRGB(64, 82, 175)
                    Checkbox.BackgroundColor3 = Color3.fromRGB(42, 53, 115)
                else
                    FramePadding.PaddingLeft = UDim.new(0, -18)
                    Indicator.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    Checkbox.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
                end

                function CreatedToggle:Callback(Enabled)
                    spawn(function()
                        Callback(Enabled)
                    end)
                    
                    if Enabled then
                        TweenService:Create(FramePadding, TweenInfo.new(.35, Enum.EasingStyle.Back), {PaddingLeft = UDim.new(0, 18)}):Play()
                        TweenService:Create(Indicator, TweenInfo.new(.35, Enum.EasingStyle.Back), {Size = UDim2.new(0, 18,0, 4)}):Play()
                        task.wait(.35)
                        TweenService:Create(Indicator, TweenInfo.new(.35, Enum.EasingStyle.Back), {Size = UDim2.new(0, 18,0, 14), BackgroundColor3 = Color3.fromRGB(64, 82, 175)}):Play()
                        TweenService:Create(Checkbox, TweenInfo.new(.35, Enum.EasingStyle.Back), {BackgroundColor3 = Color3.fromRGB(42, 53, 115)}):Play()
                    else
                        TweenService:Create(FramePadding, TweenInfo.new(.35, Enum.EasingStyle.Back), {PaddingLeft = UDim.new(0, -18)}):Play()
                        TweenService:Create(Indicator, TweenInfo.new(.35, Enum.EasingStyle.Back), {Size = UDim2.new(0, 18,0, 4)}):Play()
                        task.wait(.35)
                        TweenService:Create(Indicator, TweenInfo.new(.35, Enum.EasingStyle.Back), {Size = UDim2.new(0, 18,0, 14), BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                        TweenService:Create(Checkbox, TweenInfo.new(.35, Enum.EasingStyle.Back), {BackgroundColor3 = Color3.fromRGB(26, 26, 26)}):Play()
                    end	
                    task.wait(.1)
                    local c = Sample2:Clone()
                    c.Parent = Toggle
                    c.Position = UDim2.new(1, 0, 0.5, 0)
                    local len, size = 0.75, nil
                    if Toggle.AbsoluteSize.X >= Toggle.AbsoluteSize.Y then
                        size = (Toggle.AbsoluteSize.X * 1.5)
                    else
                        size = (Toggle.AbsoluteSize.Y * 1.5)
                    end
                    c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                    for i = 1, 10 do
                        c.ImageTransparency = c.ImageTransparency + 0.05
                        wait(len / 12)
                    end
                    c:Destroy()
                end
                
                Toggle.MouseButton1Down:Connect(function()
                    Settings.Enabled = not Settings.Enabled
                    CreatedToggle:Callback(Settings.Enabled)
                end)

                return CreatedToggle
            end
            return CreatedSection
        end
        return CreatedTab
    end
	local Bg = Instance.new("TextButton")
	Bg.Name = "Bg"
	Bg.ZIndex = 11
	Bg.Visible = false
	Bg.Size = UDim2.new(1, 0, 1.0350878, 0)
	Bg.BackgroundTransparency = 0.75
	Bg.Position = UDim2.new(0, 0, -0.0350877, 0)
	Bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Bg.AutoButtonColor = false
	Bg.FontSize = Enum.FontSize.Size14
	Bg.TextSize = 14
	Bg.TextColor3 = Color3.fromRGB(0, 0, 0)
	Bg.Text = ""
	Bg.Font = Enum.Font.SourceSans
	Bg.Parent = Content

	local UICorner13 = Instance.new("UICorner")
	UICorner13.CornerRadius = UDim.new(0, 6)
	UICorner13.Parent = Bg

	local UIListLayout8 = Instance.new("UIListLayout")
	UIListLayout8.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout8.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout8.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout8.Parent = Bg

	local TouchedPos = Instance.new("Frame")
	TouchedPos.Name = "TouchedPos"
	TouchedPos.ZIndex = 11
	TouchedPos.Size = UDim2.new(0.261236, 0, 0.242915, 0)
	TouchedPos.BackgroundTransparency = 1
	TouchedPos.Position = UDim2.new(0.738764, 0, 0.757085, 0)
	TouchedPos.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TouchedPos.Parent = Content

    local Tweeningsize = Instance.new("LocalScript")
	Tweeningsize.Name = "Tweening size"
	Tweeningsize.Parent = Content

	local Player = game.Players.LocalPlayer
    local mouse = Player:GetMouse()
    local MouseSurf = Content.TouchedPos
    local Move = false

    MouseSurf.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Move = true
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Move = false
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        if Move == true then
            if mouse.X - Content.Position.X.Offset > 50 and mouse.Y - Content.Position.Y.Offset > 50 then
                if Content.AbsoluteSize.X > 100 and Content.AbsoluteSize.Y > 100 then
                    game:GetService("TweenService"):Create(Content, TweenInfo.new(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, mouse.X - Content.Parent.Position.X.Offset , 0, mouse.Y - Content.Parent.Position.Y.Offset)}):Play()
                else
                    if Content.AbsoluteSize.X < 100 and Content.AbsoluteSize.Y < 100 then
                        game:GetService("TweenService"):Create(Content, TweenInfo.new(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 150 , 0, 150)}):Play()
                        Move = false
                    elseif Content.AbsoluteSize.X < 100 then
                        game:GetService("TweenService"):Create(Content, TweenInfo.new(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 150 , 0, Content.AbsoluteSize.Y)}):Play()
                        Move = false
                    elseif Content.AbsoluteSize.Y < 100 then
                        game:GetService("TweenService"):Create(Content, TweenInfo.new(0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Size = UDim2.new(0, Content.AbsoluteSize.X , 0, 150)}):Play()
                        --Move = false
                    end
                end
            end
        end
    end)

	Frame.Position = UDim2.new(0, game.Workspace.Camera.ViewportSize.X / 3, 0, game.Workspace.Camera.ViewportSize.Y / 4)

    dragify(Frame)

	local TopRoundHider = Instance.new("Frame")
	TopRoundHider.Name = "TopRoundHider"
	TopRoundHider.ZIndex = 2
	TopRoundHider.Size = UDim2.new(0, 460, 0, 21)
	TopRoundHider.Position = UDim2.new(0, 0, 0, 11)
	TopRoundHider.BorderSizePixel = 0
	TopRoundHider.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	TopRoundHider.Parent = Frame

	local BottomRoundHider = Instance.new("Frame")
	BottomRoundHider.Name = "BottomRoundHider"
	BottomRoundHider.ZIndex = 0
	BottomRoundHider.Size = UDim2.new(0, 460, 0, 21)
	BottomRoundHider.Position = UDim2.new(0, 0, 0, 32)
	BottomRoundHider.BorderSizePixel = 0
	BottomRoundHider.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
	BottomRoundHider.Parent = Frame

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.ZIndex = 11
	Title.Size = UDim2.new(0, 428, 0, 32)
	Title.BackgroundTransparency = 1
	Title.Position = UDim2.new(0, 16, 0, 0)
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.FontSize = Enum.FontSize.Size18
	Title.TextSize = 18
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	function MainUI:SetNewTitle(New)
        Title.Text = New
    end
    MainUI:SetNewTitle(NewTitle)
    Title.Font = Enum.Font.SourceSansBold
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = Frame
    return MainUI
end

return UI
