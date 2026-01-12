local Library = {}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local function RemoveExistingUI(name)
    local existing = PlayerGui:FindFirstChild(name)
    if existing then
        existing:Destroy()
    end
end

function Library:CreateWindow(config)
    local WindowName = config.Name or "UI Library"
    local UIName = config.UIName or "MinimalistUI"
    
    RemoveExistingUI(UIName)
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = UIName
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = PlayerGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 520, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 23, 28)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame
    
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 28, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 20, 25))
    }
    UIGradient.Rotation = 135
    UIGradient.Parent = MainFrame
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(45, 40, 43)
    UIStroke.Thickness = 1
    UIStroke.Transparency = 0.4
    UIStroke.Parent = MainFrame
    
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 45)
    TopBar.BackgroundColor3 = Color3.fromRGB(28, 26, 30)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 12)
    TopCorner.Parent = TopBar
    
    local TopBarBottom = Instance.new("Frame")
    TopBarBottom.Size = UDim2.new(1, 0, 0, 12)
    TopBarBottom.Position = UDim2.new(0, 0, 1, -12)
    TopBarBottom.BackgroundColor3 = Color3.fromRGB(28, 26, 30)
    TopBarBottom.BorderSizePixel = 0
    TopBarBottom.Parent = TopBar
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = WindowName
    Title.TextColor3 = Color3.fromRGB(240, 240, 245)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Name = "ButtonContainer"
    ButtonContainer.Size = UDim2.new(0, 70, 1, 0)
    ButtonContainer.Position = UDim2.new(1, -85, 0, 0)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = TopBar
    
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(0, 0, 0.5, -15)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 37, 42)
    MinimizeButton.Text = "—"
    MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 210)
    MinimizeButton.TextSize = 18
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Parent = ButtonContainer
    
    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = MinimizeButton
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(0, 40, 0.5, -15)
    CloseButton.BackgroundColor3 = Color3.fromRGB(45, 37, 40)
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(220, 180, 180)
    CloseButton.TextSize = 22
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = ButtonContainer
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton
    
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 140, 1, -55)
    TabContainer.Position = UDim2.new(0, 10, 0, 50)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = MainFrame
    
    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 6)
    TabList.Parent = TabContainer
    
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -165, 1, -60)
    ContentContainer.Position = UDim2.new(0, 155, 0, 52)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ClipsDescendants = true
    ContentContainer.Parent = MainFrame
    
    local UISizeConstraint = Instance.new("UISizeConstraint")
    UISizeConstraint.MinSize = Vector2.new(400, 300)
    UISizeConstraint.Parent = MainFrame
    
    local isMinimized = false
    local originalPosition = MainFrame.Position
    local originalSize = MainFrame.Size
    
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            MainFrame.Size = UDim2.new(0, 220, 0, 45)
            MainFrame.Position = UDim2.new(1, -230, 1, -55)
            ContentContainer.Visible = false
            TabContainer.Visible = false
            MinimizeButton.Text = "□"
        else
            MainFrame.Size = originalSize
            MainFrame.Position = originalPosition
            ContentContainer.Visible = true
            TabContainer.Visible = true
            MinimizeButton.Text = "—"
        end
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    local Window = {}
    Window.Tabs = {}
    Window.CurrentTab = nil
    
    function Window:CreateTab(config)
        local TabName = config.Name or "Tab"
        
        local TabButton = Instance.new("TextButton")
        TabButton.Name = TabName
        TabButton.Size = UDim2.new(1, 0, 0, 36)
        TabButton.BackgroundColor3 = Color3.fromRGB(35, 32, 37)
        TabButton.Text = TabName
        TabButton.TextColor3 = Color3.fromRGB(160, 160, 170)
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.BorderSizePixel = 0
        TabButton.Parent = TabContainer
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabButton
        
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = TabName .. "Content"
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(60, 55, 62)
        TabContent.Visible = false
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabContent.Parent = ContentContainer
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 8)
        ContentLayout.Parent = TabContent
        
        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.PaddingTop = UDim.new(0, 5)
        ContentPadding.PaddingRight = UDim.new(0, 10)
        ContentPadding.Parent = TabContent
        
        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab.Button.BackgroundColor3 = Color3.fromRGB(35, 32, 37)
                tab.Button.TextColor3 = Color3.fromRGB(160, 160, 170)
                tab.Content.Visible = false
            end
            TabButton.BackgroundColor3 = Color3.fromRGB(48, 43, 50)
            TabButton.TextColor3 = Color3.fromRGB(220, 220, 230)
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end)
        
        local Tab = {}
        Tab.Button = TabButton
        Tab.Content = TabContent
        
        function Tab:CreateSection(config)
            local SectionName = config.Name or "Section"
            
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Name = SectionName
            SectionFrame.Size = UDim2.new(1, 0, 0, 0)
            SectionFrame.AutomaticSize = Enum.AutomaticSize.Y
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.Parent = TabContent
            
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "Title"
            SectionTitle.Size = UDim2.new(1, 0, 0, 28)
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Text = SectionName
            SectionTitle.TextColor3 = Color3.fromRGB(200, 200, 210)
            SectionTitle.TextSize = 13
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            SectionTitle.Parent = SectionFrame
            
            local SectionContainer = Instance.new("Frame")
            SectionContainer.Name = "Container"
            SectionContainer.Size = UDim2.new(1, 0, 0, 0)
            SectionContainer.Position = UDim2.new(0, 0, 0, 28)
            SectionContainer.AutomaticSize = Enum.AutomaticSize.Y
            SectionContainer.BackgroundTransparency = 1
            SectionContainer.Parent = SectionFrame
            
            local SectionLayout = Instance.new("UIListLayout")
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionLayout.Padding = UDim.new(0, 6)
            SectionLayout.Parent = SectionContainer
            
            local Section = {}
            
            function Section:CreateButton(config)
                local ButtonName = config.Name or "Button"
                local Callback = config.Callback or function() end
                
                local Button = Instance.new("TextButton")
                Button.Name = ButtonName
                Button.Size = UDim2.new(1, 0, 0, 36)
                Button.BackgroundColor3 = Color3.fromRGB(42, 38, 44)
                Button.Text = ButtonName
                Button.TextColor3 = Color3.fromRGB(210, 210, 220)
                Button.TextSize = 13
                Button.Font = Enum.Font.GothamMedium
                Button.BorderSizePixel = 0
                Button.Parent = SectionContainer
                
                local BtnCorner = Instance.new("UICorner")
                BtnCorner.CornerRadius = UDim.new(0, 7)
                BtnCorner.Parent = Button
                
                Button.MouseButton1Click:Connect(function()
                    Callback()
                end)
                
                return Button
            end
            
            function Section:CreateToggle(config)
                local ToggleName = config.Name or "Toggle"
                local DefaultValue = config.Default or false
                local Callback = config.Callback or function() end
                
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Name = ToggleName
                ToggleFrame.Size = UDim2.new(1, 0, 0, 36)
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(42, 38, 44)
                ToggleFrame.BorderSizePixel = 0
                ToggleFrame.Parent = SectionContainer
                
                local TgCorner = Instance.new("UICorner")
                TgCorner.CornerRadius = UDim.new(0, 7)
                TgCorner.Parent = ToggleFrame
                
                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Size = UDim2.new(1, -55, 1, 0)
                ToggleLabel.Position = UDim2.new(0, 12, 0, 0)
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Text = ToggleName
                ToggleLabel.TextColor3 = Color3.fromRGB(210, 210, 220)
                ToggleLabel.TextSize = 13
                ToggleLabel.Font = Enum.Font.GothamMedium
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabel.Parent = ToggleFrame
                
                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Size = UDim2.new(0, 40, 0, 20)
                ToggleButton.Position = UDim2.new(1, -48, 0.5, -10)
                ToggleButton.BackgroundColor3 = Color3.fromRGB(55, 50, 57)
                ToggleButton.Text = ""
                ToggleButton.BorderSizePixel = 0
                ToggleButton.Parent = ToggleFrame
                
                local TgBtnCorner = Instance.new("UICorner")
                TgBtnCorner.CornerRadius = UDim.new(1, 0)
                TgBtnCorner.Parent = ToggleButton
                
                local ToggleIndicator = Instance.new("Frame")
                ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
                ToggleIndicator.Position = UDim2.new(0, 2, 0.5, -8)
                ToggleIndicator.BackgroundColor3 = Color3.fromRGB(140, 140, 150)
                ToggleIndicator.BorderSizePixel = 0
                ToggleIndicator.Parent = ToggleButton
                
                local IndCorner = Instance.new("UICorner")
                IndCorner.CornerRadius = UDim.new(1, 0)
                IndCorner.Parent = ToggleIndicator
                
                local toggled = DefaultValue
                
                local function UpdateToggle()
                    if toggled then
                        ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 80, 85)
                        ToggleIndicator.Position = UDim2.new(1, -18, 0.5, -8)
                        ToggleIndicator.BackgroundColor3 = Color3.fromRGB(220, 180, 185)
                    else
                        ToggleButton.BackgroundColor3 = Color3.fromRGB(55, 50, 57)
                        ToggleIndicator.Position = UDim2.new(0, 2, 0.5, -8)
                        ToggleIndicator.BackgroundColor3 = Color3.fromRGB(140, 140, 150)
                    end
                end
                
                UpdateToggle()
                
                ToggleButton.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    UpdateToggle()
                    Callback(toggled)
                end)
                
                local Toggle = {}
                function Toggle:Set(value)
                    toggled = value
                    UpdateToggle()
                end
                
                return Toggle
            end
            
            function Section:CreateSlider(config)
                local SliderName = config.Name or "Slider"
                local MinValue = config.Min or 0
                local MaxValue = config.Max or 100
                local DefaultValue = config.Default or 50
                local Increment = config.Increment or 1
                local Callback = config.Callback or function() end
                
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Name = SliderName
                SliderFrame.Size = UDim2.new(1, 0, 0, 50)
                SliderFrame.BackgroundColor3 = Color3.fromRGB(42, 38, 44)
                SliderFrame.BorderSizePixel = 0
                SliderFrame.Parent = SectionContainer
                
                local SlCorner = Instance.new("UICorner")
                SlCorner.CornerRadius = UDim.new(0, 7)
                SlCorner.Parent = SliderFrame
                
                local SliderLabel = Instance.new("TextLabel")
                SliderLabel.Size = UDim2.new(1, -70, 0, 20)
                SliderLabel.Position = UDim2.new(0, 12, 0, 6)
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Text = SliderName
                SliderLabel.TextColor3 = Color3.fromRGB(210, 210, 220)
                SliderLabel.TextSize = 13
                SliderLabel.Font = Enum.Font.GothamMedium
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                SliderLabel.Parent = SliderFrame
                
                local SliderValue = Instance.new("TextLabel")
                SliderValue.Size = UDim2.new(0, 50, 0, 20)
                SliderValue.Position = UDim2.new(1, -58, 0, 6)
                SliderValue.BackgroundTransparency = 1
                SliderValue.Text = tostring(DefaultValue)
                SliderValue.TextColor3 = Color3.fromRGB(180, 180, 190)
                SliderValue.TextSize = 12
                SliderValue.Font = Enum.Font.GothamMedium
                SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                SliderValue.Parent = SliderFrame
                
                local SliderBar = Instance.new("Frame")
                SliderBar.Size = UDim2.new(1, -24, 0, 6)
                SliderBar.Position = UDim2.new(0, 12, 1, -14)
                SliderBar.BackgroundColor3 = Color3.fromRGB(55, 50, 57)
                SliderBar.BorderSizePixel = 0
                SliderBar.Parent = SliderFrame
                
                local BarCorner = Instance.new("UICorner")
                BarCorner.CornerRadius = UDim.new(1, 0)
                BarCorner.Parent = SliderBar
                
                local SliderFill = Instance.new("Frame")
                SliderFill.Size = UDim2.new(0, 0, 1, 0)
                SliderFill.BackgroundColor3 = Color3.fromRGB(100, 80, 85)
                SliderFill.BorderSizePixel = 0
                SliderFill.Parent = SliderBar
                
                local FillCorner = Instance.new("UICorner")
                FillCorner.CornerRadius = UDim.new(1, 0)
                FillCorner.Parent = SliderFill
                
                local currentValue = DefaultValue
                
                local function UpdateSlider(value)
                    currentValue = math.clamp(math.floor((value - MinValue) / Increment + 0.5) * Increment + MinValue, MinValue, MaxValue)
                    SliderValue.Text = tostring(currentValue)
                    local percent = (currentValue - MinValue) / (MaxValue - MinValue)
                    SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                    Callback(currentValue)
                end
                
                UpdateSlider(DefaultValue)
                
                local draggingSlider = false
                
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        draggingSlider = true
                        local percent = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                        local value = MinValue + (MaxValue - MinValue) * percent
                        UpdateSlider(value)
                    end
                end)
                
                SliderBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        draggingSlider = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local percent = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                        local value = MinValue + (MaxValue - MinValue) * percent
                        UpdateSlider(value)
                    end
                end)
                
                local Slider = {}
                function Slider:Set(value)
                    UpdateSlider(value)
                end
                
                return Slider
            end
            
            function Section:CreateInput(config)
                local InputName = config.Name or "Input"
                local PlaceholderText = config.Placeholder or "Enter text..."
                local Callback = config.Callback or function() end
                
                local InputFrame = Instance.new("Frame")
                InputFrame.Name = InputName
                InputFrame.Size = UDim2.new(1, 0, 0, 65)
                InputFrame.BackgroundColor3 = Color3.fromRGB(42, 38, 44)
                InputFrame.BorderSizePixel = 0
                InputFrame.Parent = SectionContainer
                
                local InCorner = Instance.new("UICorner")
                InCorner.CornerRadius = UDim.new(0, 7)
                InCorner.Parent = InputFrame
                
                local InputLabel = Instance.new("TextLabel")
                InputLabel.Size = UDim2.new(1, -24, 0, 20)
                InputLabel.Position = UDim2.new(0, 12, 0, 6)
                InputLabel.BackgroundTransparency = 1
                InputLabel.Text = InputName
                InputLabel.TextColor3 = Color3.fromRGB(210, 210, 220)
                InputLabel.TextSize = 13
                InputLabel.Font = Enum.Font.GothamMedium
                InputLabel.TextXAlignment = Enum.TextXAlignment.Left
                InputLabel.Parent = InputFrame
                
                local InputBox = Instance.new("TextBox")
                InputBox.Size = UDim2.new(1, -24, 0, 30)
                InputBox.Position = UDim2.new(0, 12, 0, 28)
                InputBox.BackgroundColor3 = Color3.fromRGB(35, 32, 37)
                InputBox.Text = ""
                InputBox.PlaceholderText = PlaceholderText
                InputBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
                InputBox.TextColor3 = Color3.fromRGB(200, 200, 210)
                InputBox.TextSize = 12
                InputBox.Font = Enum.Font.Gotham
                InputBox.ClearTextOnFocus = false
                InputBox.BorderSizePixel = 0
                InputBox.Parent = InputFrame
                
                local BoxCorner = Instance.new("UICorner")
                BoxCorner.CornerRadius = UDim.new(0, 6)
                BoxCorner.Parent = InputBox
                
                local BoxPadding = Instance.new("UIPadding")
                BoxPadding.PaddingLeft = UDim.new(0, 10)
                BoxPadding.PaddingRight = UDim.new(0, 10)
                BoxPadding.Parent = InputBox
                
                InputBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        Callback(InputBox.Text)
                    end
                end)
                
                local Input = {}
                function Input:Set(text)
                    InputBox.Text = text
                end
                
                return Input
            end
            
            return Section
        end
        
        table.insert(Window.Tabs, Tab)
        
        if #Window.Tabs == 1 then
            TabButton.BackgroundColor3 = Color3.fromRGB(48, 43, 50)
            TabButton.TextColor3 = Color3.fromRGB(220, 220, 230)
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end
        
        return Tab
    end
    
    return Window
end

return Library
