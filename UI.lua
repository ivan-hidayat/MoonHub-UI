local Library = {}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local UI_NAME = "CustomUILibrary"

function Library:CreateWindow(config)
    local existingUI = PlayerGui:FindFirstChild(UI_NAME)
    if existingUI then
        existingUI:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = UI_NAME
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = PlayerGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 550, 0, 400)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 22, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 28, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 20, 18))
    }
    UIGradient.Rotation = 45
    UIGradient.Parent = MainFrame

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(35, 30, 27)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 8)
    TopBarCorner.Parent = TopBar

    local TopBarFix = Instance.new("Frame")
    TopBarFix.Size = UDim2.new(1, 0, 0, 20)
    TopBarFix.Position = UDim2.new(0, 0, 1, -20)
    TopBarFix.BackgroundColor3 = Color3.fromRGB(35, 30, 27)
    TopBarFix.BorderSizePixel = 0
    TopBarFix.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = config.Name or "UI Library"
    Title.TextColor3 = Color3.fromRGB(220, 210, 200)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -75, 0.5, 0)
    MinimizeButton.AnchorPoint = Vector2.new(0.5, 0.5)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(45, 38, 33)
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = Color3.fromRGB(220, 210, 200)
    MinimizeButton.TextSize = 20
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = TopBar

    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 4)
    MinimizeCorner.Parent = MinimizeButton

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0.5, 0)
    CloseButton.AnchorPoint = Vector2.new(0.5, 0.5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(80, 35, 30)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(220, 210, 200)
    CloseButton.TextSize = 16
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TopBar

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = CloseButton

    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 140, 1, -50)
    TabContainer.Position = UDim2.new(0, 10, 0, 45)
    TabContainer.BackgroundColor3 = Color3.fromRGB(30, 26, 23)
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = TabContainer

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Padding = UDim.new(0, 5)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Parent = TabContainer

    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 5)
    TabPadding.PaddingBottom = UDim.new(0, 5)
    TabPadding.PaddingLeft = UDim.new(0, 5)
    TabPadding.PaddingRight = UDim.new(0, 5)
    TabPadding.Parent = TabContainer

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -170, 1, -50)
    ContentContainer.Position = UDim2.new(0, 160, 0, 45)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local originalPosition = MainFrame.Position
    local originalSize = MainFrame.Size
    local isMinimized = false

    MinimizeButton.MouseButton1Click:Connect(function()
        if isMinimized then
            MainFrame.Size = originalSize
            MainFrame.Position = originalPosition
            MinimizeButton.Text = "-"
            isMinimized = false
        else
            MainFrame.Size = UDim2.new(0, 200, 0, 40)
            MainFrame.Position = UDim2.new(1, -210, 1, -50)
            MainFrame.AnchorPoint = Vector2.new(0, 0)
            MinimizeButton.Text = "+"
            isMinimized = true
        end
    end)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local dragging = false
    local dragInput, mousePos, framePos

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = MainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging and not isMinimized then
            local delta = input.Position - mousePos
            MainFrame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)

    local Window = {}
    Window.Tabs = {}
    Window.CurrentTab = nil

    function Window:CreateTab(tabConfig)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = tabConfig.Name
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 35, 30)
        TabButton.Text = tabConfig.Name
        TabButton.TextColor3 = Color3.fromRGB(180, 170, 160)
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.Gotham
        TabButton.Parent = TabContainer

        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 4)
        TabButtonCorner.Parent = TabButton

        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = tabConfig.Name .. "Content"
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(60, 52, 45)
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.Visible = false
        TabContent.Parent = ContentContainer

        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 8)
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Parent = TabContent

        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.PaddingTop = UDim.new(0, 5)
        ContentPadding.PaddingBottom = UDim.new(0, 5)
        ContentPadding.PaddingLeft = UDim.new(0, 5)
        ContentPadding.PaddingRight = UDim.new(0, 10)
        ContentPadding.Parent = TabContent

        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 10)
        end)

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab.Button.BackgroundColor3 = Color3.fromRGB(40, 35, 30)
                tab.Button.TextColor3 = Color3.fromRGB(180, 170, 160)
                tab.Content.Visible = false
            end

            TabButton.BackgroundColor3 = Color3.fromRGB(60, 50, 43)
            TabButton.TextColor3 = Color3.fromRGB(220, 210, 200)
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end)

        local Tab = {}
        Tab.Button = TabButton
        Tab.Content = TabContent

        function Tab:CreateSection(sectionConfig)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Name = sectionConfig.Name
            SectionFrame.Size = UDim2.new(1, 0, 0, 35)
            SectionFrame.BackgroundColor3 = Color3.fromRGB(35, 30, 27)
            SectionFrame.BorderSizePixel = 0
            SectionFrame.Parent = TabContent

            local SectionCorner = Instance.new("UICorner")
            SectionCorner.CornerRadius = UDim.new(0, 6)
            SectionCorner.Parent = SectionFrame

            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Size = UDim2.new(1, -20, 1, 0)
            SectionLabel.Position = UDim2.new(0, 10, 0, 0)
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Text = sectionConfig.Name
            SectionLabel.TextColor3 = Color3.fromRGB(200, 190, 180)
            SectionLabel.TextSize = 15
            SectionLabel.Font = Enum.Font.GothamBold
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            SectionLabel.Parent = SectionFrame

            return {}
        end

        function Tab:CreateButton(buttonConfig)
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Size = UDim2.new(1, 0, 0, 40)
            ButtonFrame.BackgroundColor3 = Color3.fromRGB(35, 30, 27)
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Parent = TabContent

            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = ButtonFrame

            local Button = Instance.new("TextButton")
            Button.Size = UDim2.new(1, -20, 1, -10)
            Button.Position = UDim2.new(0, 10, 0, 5)
            Button.BackgroundColor3 = Color3.fromRGB(55, 47, 40)
            Button.Text = buttonConfig.Name
            Button.TextColor3 = Color3.fromRGB(220, 210, 200)
            Button.TextSize = 14
            Button.Font = Enum.Font.Gotham
            Button.Parent = ButtonFrame

            local ButtonInnerCorner = Instance.new("UICorner")
            ButtonInnerCorner.CornerRadius = UDim.new(0, 4)
            ButtonInnerCorner.Parent = Button

            Button.MouseButton1Click:Connect(function()
                if buttonConfig.Callback then
                    buttonConfig.Callback()
                end
            end)

            return {}
        end

        function Tab:CreateToggle(toggleConfig)
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 30, 27)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContent

            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Parent = ToggleFrame

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Size = UDim2.new(1, -70, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = toggleConfig.Name
            ToggleLabel.TextColor3 = Color3.fromRGB(200, 190, 180)
            ToggleLabel.TextSize = 14
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = ToggleFrame

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Size = UDim2.new(0, 45, 0, 25)
            ToggleButton.Position = UDim2.new(1, -55, 0.5, 0)
            ToggleButton.AnchorPoint = Vector2.new(0, 0.5)
            ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 43, 37)
            ToggleButton.Text = ""
            ToggleButton.Parent = ToggleFrame

            local ToggleButtonCorner = Instance.new("UICorner")
            ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
            ToggleButtonCorner.Parent = ToggleButton

            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Size = UDim2.new(0, 19, 0, 19)
            ToggleIndicator.Position = UDim2.new(0, 3, 0.5, 0)
            ToggleIndicator.AnchorPoint = Vector2.new(0, 0.5)
            ToggleIndicator.BackgroundColor3 = Color3.fromRGB(120, 110, 100)
            ToggleIndicator.BorderSizePixel = 0
            ToggleIndicator.Parent = ToggleButton

            local IndicatorCorner = Instance.new("UICorner")
            IndicatorCorner.CornerRadius = UDim.new(1, 0)
            IndicatorCorner.Parent = ToggleIndicator

            local toggled = toggleConfig.Default or false

            local function updateToggle()
                if toggled then
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 70, 50)
                    ToggleIndicator.Position = UDim2.new(1, -22, 0.5, 0)
                    ToggleIndicator.BackgroundColor3 = Color3.fromRGB(200, 160, 120)
                else
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 43, 37)
                    ToggleIndicator.Position = UDim2.new(0, 3, 0.5, 0)
                    ToggleIndicator.BackgroundColor3 = Color3.fromRGB(120, 110, 100)
                end
            end

            updateToggle()

            ToggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                updateToggle()
                if toggleConfig.Callback then
                    toggleConfig.Callback(toggled)
                end
            end)

            return {}
        end

        function Tab:CreateSlider(sliderConfig)
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, 0, 0, 60)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 30, 27)
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabContent

            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 6)
            SliderCorner.Parent = SliderFrame

            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Size = UDim2.new(1, -20, 0, 20)
            SliderLabel.Position = UDim2.new(0, 10, 0, 5)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = sliderConfig.Name
            SliderLabel.TextColor3 = Color3.fromRGB(200, 190, 180)
            SliderLabel.TextSize = 14
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Parent = SliderFrame

            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Size = UDim2.new(0, 50, 0, 20)
            ValueLabel.Position = UDim2.new(1, -60, 0, 5)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(sliderConfig.Default or sliderConfig.Min)
            ValueLabel.TextColor3 = Color3.fromRGB(180, 150, 120)
            ValueLabel.TextSize = 13
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Parent = SliderFrame

            local SliderBack = Instance.new("Frame")
            SliderBack.Size = UDim2.new(1, -20, 0, 6)
            SliderBack.Position = UDim2.new(0, 10, 1, -20)
            SliderBack.BackgroundColor3 = Color3.fromRGB(45, 40, 35)
            SliderBack.BorderSizePixel = 0
            SliderBack.Parent = SliderFrame

            local SliderBackCorner = Instance.new("UICorner")
            SliderBackCorner.CornerRadius = UDim.new(1, 0)
            SliderBackCorner.Parent = SliderBack

            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new(0, 0, 1, 0)
            SliderFill.BackgroundColor3 = Color3.fromRGB(140, 100, 70)
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderBack

            local SliderFillCorner = Instance.new("UICorner")
            SliderFillCorner.CornerRadius = UDim.new(1, 0)
            SliderFillCorner.Parent = SliderFill

            local SliderButton = Instance.new("TextButton")
            SliderButton.Size = UDim2.new(1, 0, 1, 0)
            SliderButton.Position = UDim2.new(0, 0, 0, 0)
            SliderButton.BackgroundTransparency = 1
            SliderButton.Text = ""
            SliderButton.Parent = SliderBack

            local currentValue = sliderConfig.Default or sliderConfig.Min
            local dragging = false

            local function updateSlider(input)
                local sizeX = SliderBack.AbsoluteSize.X
                local posX = math.clamp(input.Position.X - SliderBack.AbsolutePosition.X, 0, sizeX)
                local percent = posX / sizeX
                local range = sliderConfig.Max - sliderConfig.Min
                local value = sliderConfig.Min + (percent * range)
                
                if sliderConfig.Increment then
                    value = math.floor(value / sliderConfig.Increment + 0.5) * sliderConfig.Increment
                end
                
                value = math.clamp(value, sliderConfig.Min, sliderConfig.Max)
                currentValue = value

                SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                ValueLabel.Text = tostring(value)

                if sliderConfig.Callback then
                    sliderConfig.Callback(value)
                end
            end

            SliderButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    updateSlider(input)
                end
            end)

            SliderButton.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(input)
                end
            end)

            local initialPercent = (currentValue - sliderConfig.Min) / (sliderConfig.Max - sliderConfig.Min)
            SliderFill.Size = UDim2.new(initialPercent, 0, 1, 0)

            return {}
        end

        function Tab:CreateInput(inputConfig)
            local InputFrame = Instance.new("Frame")
            InputFrame.Size = UDim2.new(1, 0, 0, 60)
            InputFrame.BackgroundColor3 = Color3.fromRGB(35, 30, 27)
            InputFrame.BorderSizePixel = 0
            InputFrame.Parent = TabContent

            local InputCorner = Instance.new("UICorner")
            InputCorner.CornerRadius = UDim.new(0, 6)
            InputCorner.Parent = InputFrame

            local InputLabel = Instance.new("TextLabel")
            InputLabel.Size = UDim2.new(1, -20, 0, 20)
            InputLabel.Position = UDim2.new(0, 10, 0, 5)
            InputLabel.BackgroundTransparency = 1
            InputLabel.Text = inputConfig.Name
            InputLabel.TextColor3 = Color3.fromRGB(200, 190, 180)
            InputLabel.TextSize = 14
            InputLabel.Font = Enum.Font.Gotham
            InputLabel.TextXAlignment = Enum.TextXAlignment.Left
            InputLabel.Parent = InputFrame

            local InputBox = Instance.new("TextBox")
            InputBox.Size = UDim2.new(1, -20, 0, 28)
            InputBox.Position = UDim2.new(0, 10, 1, -33)
            InputBox.BackgroundColor3 = Color3.fromRGB(45, 40, 35)
            InputBox.Text = inputConfig.Default or ""
            InputBox.PlaceholderText = inputConfig.Placeholder or "Enter text..."
            InputBox.TextColor3 = Color3.fromRGB(220, 210, 200)
            InputBox.PlaceholderColor3 = Color3.fromRGB(120, 110, 100)
            InputBox.TextSize = 13
            InputBox.Font = Enum.Font.Gotham
            InputBox.ClearTextOnFocus = false
            InputBox.Parent = InputFrame

            local InputBoxCorner = Instance.new("UICorner")
            InputBoxCorner.CornerRadius = UDim.new(0, 4)
            InputBoxCorner.Parent = InputBox

            local InputPadding = Instance.new("UIPadding")
            InputPadding.PaddingLeft = UDim.new(0, 8)
            InputPadding.PaddingRight = UDim.new(0, 8)
            InputPadding.Parent = InputBox

            InputBox.FocusLost:Connect(function(enterPressed)
                if enterPressed and inputConfig.Callback then
                    inputConfig.Callback(InputBox.Text)
                end
            end)

            return {}
        end

        table.insert(Window.Tabs, Tab)

        if #Window.Tabs == 1 then
            TabButton.BackgroundColor3 = Color3.fromRGB(60, 50, 43)
            TabButton.TextColor3 = Color3.fromRGB(220, 210, 200)
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end

        return Tab
    end

    return Window
end

return Library
