local Library = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MinimalUI"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

function Library:CreateWindow(config)
    local WindowFrame = Instance.new("Frame")
    WindowFrame.Name = "MainWindow"
    WindowFrame.Size = UDim2.new(0, 550, 0, 400)
    WindowFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
    WindowFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    WindowFrame.BorderSizePixel = 0
    WindowFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = WindowFrame

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(40, 40, 45)
    UIStroke.Thickness = 1
    UIStroke.Parent = WindowFrame

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = WindowFrame

    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 8)
    TopBarCorner.Parent = TopBar

    local BottomCover = Instance.new("Frame")
    BottomCover.Size = UDim2.new(1, 0, 0, 8)
    BottomCover.Position = UDim2.new(0, 0, 1, -8)
    BottomCover.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    BottomCover.BorderSizePixel = 0
    BottomCover.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = config.Name or "UI Library"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Name = "ButtonContainer"
    ButtonContainer.Size = UDim2.new(0, 70, 1, 0)
    ButtonContainer.Position = UDim2.new(1, -75, 0, 0)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = TopBar

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(0, 0, 0.5, -15)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    MinimizeButton.Text = "—"
    MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    MinimizeButton.TextSize = 14
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Parent = ButtonContainer

    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 4)
    MinimizeCorner.Parent = MinimizeButton

    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(0, 35, 0.5, -15)
    CloseButton.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    CloseButton.TextSize = 18
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = ButtonContainer

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = CloseButton

    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 120, 1, -50)
    TabContainer.Position = UDim2.new(0, 10, 0, 45)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = WindowFrame

    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    TabList.Parent = TabContainer

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -145, 1, -50)
    ContentContainer.Position = UDim2.new(0, 135, 0, 45)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ClipsDescendants = true
    ContentContainer.Parent = WindowFrame

    local isMinimized = false
    local originalSize = WindowFrame.Size

    MinimizeButton.MouseButton1Click:Connect(function()
        if isMinimized then
            WindowFrame.Size = originalSize
            ContentContainer.Visible = true
            TabContainer.Visible = true
            isMinimized = false
        else
            WindowFrame.Size = UDim2.new(0, 550, 0, 40)
            ContentContainer.Visible = false
            TabContainer.Visible = false
            isMinimized = true
        end
    end)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local dragging = false
    local dragInput, mousePos, framePos

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = WindowFrame.Position
        end
    end)

    TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - mousePos
            WindowFrame.Position = UDim2.new(
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

    function Window:CreateTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(180, 180, 180)
        TabButton.TextSize = 13
        TabButton.Font = Enum.Font.Gotham
        TabButton.BorderSizePixel = 0
        TabButton.Parent = TabContainer

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton

        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = name .. "Content"
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 65)
        TabContent.Visible = false
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.Parent = ContentContainer

        local ContentList = Instance.new("UIListLayout")
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, 8)
        ContentList.Parent = TabContent

        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 10)
        end)

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab.Button.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
                tab.Button.TextColor3 = Color3.fromRGB(180, 180, 180)
                tab.Content.Visible = false
            end

            TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end)

        local Tab = {}
        Tab.Button = TabButton
        Tab.Content = TabContent
        Tab.Sections = {}

        function Tab:CreateSection(name)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Name = name
            SectionFrame.Size = UDim2.new(1, -10, 0, 0)
            SectionFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
            SectionFrame.BorderSizePixel = 0
            SectionFrame.Parent = TabContent

            local SectionCorner = Instance.new("UICorner")
            SectionCorner.CornerRadius = UDim.new(0, 6)
            SectionCorner.Parent = SectionFrame

            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "Title"
            SectionTitle.Size = UDim2.new(1, -20, 0, 30)
            SectionTitle.Position = UDim2.new(0, 10, 0, 5)
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Text = name
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 13
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            SectionTitle.Parent = SectionFrame

            local ElementContainer = Instance.new("Frame")
            ElementContainer.Name = "Elements"
            ElementContainer.Size = UDim2.new(1, -20, 1, -40)
            ElementContainer.Position = UDim2.new(0, 10, 0, 35)
            ElementContainer.BackgroundTransparency = 1
            ElementContainer.Parent = SectionFrame

            local ElementList = Instance.new("UIListLayout")
            ElementList.SortOrder = Enum.SortOrder.LayoutOrder
            ElementList.Padding = UDim.new(0, 6)
            ElementList.Parent = ElementContainer

            ElementList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionFrame.Size = UDim2.new(1, -10, 0, ElementList.AbsoluteContentSize.Y + 45)
            end)

            local Section = {}
            Section.Frame = SectionFrame
            Section.Container = ElementContainer

            function Section:CreateButton(config)
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(1, 0, 0, 35)
                Button.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
                Button.Text = config.Name or "Button"
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 12
                Button.Font = Enum.Font.Gotham
                Button.BorderSizePixel = 0
                Button.Parent = ElementContainer

                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Parent = Button

                Button.MouseButton1Click:Connect(function()
                    if config.Callback then
                        config.Callback()
                    end
                end)

                return Button
            end

            function Section:CreateToggle(config)
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
                ToggleFrame.BorderSizePixel = 0
                ToggleFrame.Parent = ElementContainer

                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 4)
                ToggleCorner.Parent = ToggleFrame

                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
                ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Text = config.Name or "Toggle"
                ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabel.TextSize = 12
                ToggleLabel.Font = Enum.Font.Gotham
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabel.Parent = ToggleFrame

                local ToggleButton = Instance.new("TextButton")
                ToggleButton.Size = UDim2.new(0, 40, 0, 20)
                ToggleButton.Position = UDim2.new(1, -45, 0.5, -10)
                ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
                ToggleButton.Text = ""
                ToggleButton.BorderSizePixel = 0
                ToggleButton.Parent = ToggleFrame

                local ToggleButtonCorner = Instance.new("UICorner")
                ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
                ToggleButtonCorner.Parent = ToggleButton

                local ToggleIndicator = Instance.new("Frame")
                ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
                ToggleIndicator.Position = UDim2.new(0, 2, 0.5, -8)
                ToggleIndicator.BackgroundColor3 = Color3.fromRGB(120, 120, 125)
                ToggleIndicator.BorderSizePixel = 0
                ToggleIndicator.Parent = ToggleButton

                local IndicatorCorner = Instance.new("UICorner")
                IndicatorCorner.CornerRadius = UDim.new(1, 0)
                IndicatorCorner.Parent = ToggleIndicator

                local toggled = config.Default or false

                if toggled then
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
                    ToggleIndicator.Position = UDim2.new(1, -18, 0.5, -8)
                    ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                end

                ToggleButton.MouseButton1Click:Connect(function()
                    toggled = not toggled

                    if toggled then
                        ToggleButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
                        ToggleIndicator.Position = UDim2.new(1, -18, 0.5, -8)
                        ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    else
                        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
                        ToggleIndicator.Position = UDim2.new(0, 2, 0.5, -8)
                        ToggleIndicator.BackgroundColor3 = Color3.fromRGB(120, 120, 125)
                    end

                    if config.Callback then
                        config.Callback(toggled)
                    end
                end)

                return ToggleFrame
            end

            function Section:CreateSlider(config)
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Size = UDim2.new(1, 0, 0, 50)
                SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
                SliderFrame.BorderSizePixel = 0
                SliderFrame.Parent = ElementContainer

                local SliderCorner = Instance.new("UICorner")
                SliderCorner.CornerRadius = UDim.new(0, 4)
                SliderCorner.Parent = SliderFrame

                local SliderLabel = Instance.new("TextLabel")
                SliderLabel.Size = UDim2.new(1, -20, 0, 20)
                SliderLabel.Position = UDim2.new(0, 10, 0, 5)
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Text = config.Name or "Slider"
                SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderLabel.TextSize = 12
                SliderLabel.Font = Enum.Font.Gotham
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                SliderLabel.Parent = SliderFrame

                local SliderValue = Instance.new("TextLabel")
                SliderValue.Size = UDim2.new(0, 50, 0, 20)
                SliderValue.Position = UDim2.new(1, -60, 0, 5)
                SliderValue.BackgroundTransparency = 1
                SliderValue.Text = tostring(config.Default or config.Min)
                SliderValue.TextColor3 = Color3.fromRGB(200, 200, 200)
                SliderValue.TextSize = 11
                SliderValue.Font = Enum.Font.Gotham
                SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                SliderValue.Parent = SliderFrame

                local SliderBar = Instance.new("Frame")
                SliderBar.Size = UDim2.new(1, -20, 0, 6)
                SliderBar.Position = UDim2.new(0, 10, 1, -15)
                SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
                SliderBar.BorderSizePixel = 0
                SliderBar.Parent = SliderFrame

                local SliderBarCorner = Instance.new("UICorner")
                SliderBarCorner.CornerRadius = UDim.new(1, 0)
                SliderBarCorner.Parent = SliderBar

                local SliderFill = Instance.new("Frame")
                SliderFill.Size = UDim2.new(0, 0, 1, 0)
                SliderFill.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
                SliderFill.BorderSizePixel = 0
                SliderFill.Parent = SliderBar

                local SliderFillCorner = Instance.new("UICorner")
                SliderFillCorner.CornerRadius = UDim.new(1, 0)
                SliderFillCorner.Parent = SliderFill

                local min = config.Min or 0
                local max = config.Max or 100
                local default = config.Default or min
                local value = default

                local function updateSlider(val)
                    value = math.clamp(val, min, max)
                    local percentage = (value - min) / (max - min)
                    SliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                    SliderValue.Text = tostring(math.floor(value))

                    if config.Callback then
                        config.Callback(value)
                    end
                end

                updateSlider(default)

                local dragging = false

                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        local mousePos = input.Position.X
                        local barPos = SliderBar.AbsolutePosition.X
                        local barSize = SliderBar.AbsoluteSize.X
                        local percentage = math.clamp((mousePos - barPos) / barSize, 0, 1)
                        updateSlider(min + (max - min) * percentage)
                    end
                end)

                SliderBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local mousePos = input.Position.X
                        local barPos = SliderBar.AbsolutePosition.X
                        local barSize = SliderBar.AbsoluteSize.X
                        local percentage = math.clamp((mousePos - barPos) / barSize, 0, 1)
                        updateSlider(min + (max - min) * percentage)
                    end
                end)

                return SliderFrame
            end

            function Section:CreateInput(config)
                local InputFrame = Instance.new("Frame")
                InputFrame.Size = UDim2.new(1, 0, 0, 50)
                InputFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
                InputFrame.BorderSizePixel = 0
                InputFrame.Parent = ElementContainer

                local InputCorner = Instance.new("UICorner")
                InputCorner.CornerRadius = UDim.new(0, 4)
                InputCorner.Parent = InputFrame

                local InputLabel = Instance.new("TextLabel")
                InputLabel.Size = UDim2.new(1, -20, 0, 20)
                InputLabel.Position = UDim2.new(0, 10, 0, 5)
                InputLabel.BackgroundTransparency = 1
                InputLabel.Text = config.Name or "Input"
                InputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                InputLabel.TextSize = 12
                InputLabel.Font = Enum.Font.Gotham
                InputLabel.TextXAlignment = Enum.TextXAlignment.Left
                InputLabel.Parent = InputFrame

                local InputBox = Instance.new("TextBox")
                InputBox.Size = UDim2.new(1, -20, 0, 20)
                InputBox.Position = UDim2.new(0, 10, 1, -25)
                InputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
                InputBox.Text = config.Default or ""
                InputBox.PlaceholderText = config.Placeholder or "Enter text..."
                InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                InputBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 125)
                InputBox.TextSize = 11
                InputBox.Font = Enum.Font.Gotham
                InputBox.BorderSizePixel = 0
                InputBox.ClearTextOnFocus = false
                InputBox.Parent = InputFrame

                local InputBoxCorner = Instance.new("UICorner")
                InputBoxCorner.CornerRadius = UDim.new(0, 4)
                InputBoxCorner.Parent = InputBox

                InputBox.FocusLost:Connect(function(enterPressed)
                    if config.Callback then
                        config.Callback(InputBox.Text)
                    end
                end)

                return InputFrame
            end

            table.insert(Tab.Sections, Section)
            return Section
        end

        table.insert(Window.Tabs, Tab)

        if #Window.Tabs == 1 then
            TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end

        return Tab
    end

    return Window
end

return Library
