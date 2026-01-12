local Library = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local UI_NAME = "ModernDarkUI"

for _, existingUI in ipairs(PlayerGui:GetChildren()) do
    if existingUI.Name == UI_NAME and existingUI:IsA("ScreenGui") then
        existingUI:Destroy()
    end
end

local function createUICorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 12)
    corner.Parent = parent
    return corner
end

local function createUIPadding(parent, all)
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, all or 0)
    padding.PaddingBottom = UDim.new(0, all or 0)
    padding.PaddingLeft = UDim.new(0, all or 0)
    padding.PaddingRight = UDim.new(0, all or 0)
    padding.Parent = parent
    return padding
end

local function createGradient(parent, rotation, colorSequence)
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = rotation or 45
    gradient.Color = colorSequence
    gradient.Parent = parent
    return gradient
end

local function createStroke(parent, thickness, color, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness or 1
    stroke.Color = color or Color3.fromRGB(80, 80, 80)
    stroke.Transparency = transparency or 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

local function makeDraggable(frame, dragHandle)
    local dragging = false
    local dragStart = nil
    local startPos = nil

    local function update(input)
        if dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            update(input)
        end
    end)

    dragHandle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

function Library:CreateWindow(config)
    config = config or {}
    local windowTitle = config.Title or "Modern UI"
    local windowSubtitle = config.Subtitle or ""
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = UI_NAME
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 550, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    createUICorner(mainFrame, 16)
    createStroke(mainFrame, 1, Color3.fromRGB(60, 60, 65), 0.6)

    local bgGradient = createGradient(mainFrame, 135, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 30, 28)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(28, 25, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 28, 25))
    })

    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 50)
    topBar.Position = UDim2.new(0, 0, 0, 0)
    topBar.BackgroundColor3 = Color3.fromRGB(30, 28, 32)
    topBar.BorderSizePixel = 0
    topBar.Parent = mainFrame
    createUICorner(topBar, 16)

    local topBarGradient = createGradient(topBar, 90, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 35, 38)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 30, 33))
    })

    local topBarBottom = Instance.new("Frame")
    topBarBottom.Size = UDim2.new(1, 0, 0, 16)
    topBarBottom.Position = UDim2.new(0, 0, 1, -16)
    topBarBottom.BackgroundColor3 = Color3.fromRGB(30, 28, 32)
    topBarBottom.BorderSizePixel = 0
    topBarBottom.Parent = topBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -100, 0, 20)
    titleLabel.Position = UDim2.new(0, 15, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = windowTitle
    titleLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
    titleLabel.TextSize = 16
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = topBar

    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Name = "Subtitle"
    subtitleLabel.Size = UDim2.new(1, -100, 0, 15)
    subtitleLabel.Position = UDim2.new(0, 15, 0, 28)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = windowSubtitle
    subtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 155)
    subtitleLabel.TextSize = 12
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    subtitleLabel.Parent = topBar

    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = "ButtonContainer"
    buttonContainer.Size = UDim2.new(0, 80, 0, 30)
    buttonContainer.Position = UDim2.new(1, -90, 0, 10)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = topBar

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 35, 0, 30)
    minimizeButton.Position = UDim2.new(0, 0, 0, 0)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(45, 40, 43)
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Text = "—"
    minimizeButton.TextColor3 = Color3.fromRGB(200, 200, 205)
    minimizeButton.TextSize = 18
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.Parent = buttonContainer
    createUICorner(minimizeButton, 8)
    createStroke(minimizeButton, 1, Color3.fromRGB(70, 65, 68), 0.5)

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 35, 0, 30)
    closeButton.Position = UDim2.new(0, 45, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(55, 35, 40)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.fromRGB(240, 150, 160)
    closeButton.TextSize = 24
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = buttonContainer
    createUICorner(closeButton, 8)
    createStroke(closeButton, 1, Color3.fromRGB(90, 60, 65), 0.5)

    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(0, 140, 1, -60)
    tabContainer.Position = UDim2.new(0, 10, 0, 55)
    tabContainer.BackgroundTransparency = 1
    tabContainer.BorderSizePixel = 0
    tabContainer.Parent = mainFrame

    local tabList = Instance.new("ScrollingFrame")
    tabList.Name = "TabList"
    tabList.Size = UDim2.new(1, 0, 1, 0)
    tabList.Position = UDim2.new(0, 0, 0, 0)
    tabList.BackgroundTransparency = 1
    tabList.BorderSizePixel = 0
    tabList.ScrollBarThickness = 4
    tabList.ScrollBarImageColor3 = Color3.fromRGB(80, 75, 78)
    tabList.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabList.Parent = tabContainer

    local tabListLayout = Instance.new("UIListLayout")
    tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabListLayout.Padding = UDim.new(0, 8)
    tabListLayout.Parent = tabList

    tabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabList.CanvasSize = UDim2.new(0, 0, 0, tabListLayout.AbsoluteContentSize.Y + 10)
    end)

    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Size = UDim2.new(1, -165, 1, -65)
    contentContainer.Position = UDim2.new(0, 155, 0, 55)
    contentContainer.BackgroundTransparency = 1
    contentContainer.BorderSizePixel = 0
    contentContainer.ClipsDescendants = true
    contentContainer.Parent = mainFrame

    makeDraggable(mainFrame, topBar)

    local Window = {}
    Window.Tabs = {}
    Window.CurrentTab = nil
    Window.IsMinimized = false
    Window.OriginalPosition = mainFrame.Position
    Window.OriginalSize = mainFrame.Size

    minimizeButton.MouseButton1Click:Connect(function()
        if not Window.IsMinimized then
            Window.OriginalPosition = mainFrame.Position
            Window.OriginalSize = mainFrame.Size
            
            local viewportSize = workspace.CurrentCamera.ViewportSize
            mainFrame.Position = UDim2.new(1, -160, 1, -60)
            mainFrame.Size = UDim2.new(0, 150, 0, 50)
            
            tabContainer.Visible = false
            contentContainer.Visible = false
            buttonContainer.Visible = false
            subtitleLabel.Visible = false
            
            Window.IsMinimized = true
        else
            mainFrame.Position = Window.OriginalPosition
            mainFrame.Size = Window.OriginalSize
            
            tabContainer.Visible = true
            contentContainer.Visible = true
            buttonContainer.Visible = true
            subtitleLabel.Visible = true
            
            Window.IsMinimized = false
        end
    end)

    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    function Window:CreateTab(tabName)
        local Tab = {}
        Tab.Name = tabName
        Tab.Sections = {}

        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName
        tabButton.Size = UDim2.new(1, 0, 0, 38)
        tabButton.BackgroundColor3 = Color3.fromRGB(35, 32, 35)
        tabButton.BorderSizePixel = 0
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(180, 180, 185)
        tabButton.TextSize = 14
        tabButton.Font = Enum.Font.GothamMedium
        tabButton.TextXAlignment = Enum.TextXAlignment.Left
        tabButton.Parent = tabList
        createUICorner(tabButton, 10)
        createStroke(tabButton, 1, Color3.fromRGB(60, 55, 58), 0.6)
        createUIPadding(tabButton, 12)

        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = tabName .. "Content"
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.Position = UDim2.new(0, 0, 0, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.BorderSizePixel = 0
        tabContent.ScrollBarThickness = 6
        tabContent.ScrollBarImageColor3 = Color3.fromRGB(80, 75, 78)
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.Visible = false
        tabContent.Parent = contentContainer

        local contentLayout = Instance.new("UIListLayout")
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.Padding = UDim.new(0, 10)
        contentLayout.Parent = tabContent

        contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 10)
        end)

        tabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab.Button.BackgroundColor3 = Color3.fromRGB(35, 32, 35)
                tab.Button.TextColor3 = Color3.fromRGB(180, 180, 185)
                tab.Content.Visible = false
            end

            tabButton.BackgroundColor3 = Color3.fromRGB(50, 45, 48)
            tabButton.TextColor3 = Color3.fromRGB(240, 240, 245)
            tabContent.Visible = true
            Window.CurrentTab = Tab
        end)

        Tab.Button = tabButton
        Tab.Content = tabContent
        table.insert(Window.Tabs, Tab)

        if #Window.Tabs == 1 then
            tabButton.BackgroundColor3 = Color3.fromRGB(50, 45, 48)
            tabButton.TextColor3 = Color3.fromRGB(240, 240, 245)
            tabContent.Visible = true
            Window.CurrentTab = Tab
        end

        function Tab:CreateSection(sectionName)
            local Section = {}
            Section.Name = sectionName

            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = sectionName
            sectionFrame.Size = UDim2.new(1, 0, 0, 0)
            sectionFrame.BackgroundColor3 = Color3.fromRGB(32, 30, 33)
            sectionFrame.BorderSizePixel = 0
            sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
            sectionFrame.Parent = tabContent
            createUICorner(sectionFrame, 12)
            createStroke(sectionFrame, 1, Color3.fromRGB(55, 50, 53), 0.6)

            local sectionHeader = Instance.new("TextLabel")
            sectionHeader.Name = "Header"
            sectionHeader.Size = UDim2.new(1, -24, 0, 35)
            sectionHeader.Position = UDim2.new(0, 12, 0, 8)
            sectionHeader.BackgroundTransparency = 1
            sectionHeader.Text = sectionName
            sectionHeader.TextColor3 = Color3.fromRGB(220, 220, 225)
            sectionHeader.TextSize = 15
            sectionHeader.Font = Enum.Font.GothamBold
            sectionHeader.TextXAlignment = Enum.TextXAlignment.Left
            sectionHeader.Parent = sectionFrame

            local sectionContent = Instance.new("Frame")
            sectionContent.Name = "Content"
            sectionContent.Size = UDim2.new(1, -24, 0, 0)
            sectionContent.Position = UDim2.new(0, 12, 0, 43)
            sectionContent.BackgroundTransparency = 1
            sectionContent.AutomaticSize = Enum.AutomaticSize.Y
            sectionContent.Parent = sectionFrame

            local sectionLayout = Instance.new("UIListLayout")
            sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            sectionLayout.Padding = UDim.new(0, 8)
            sectionLayout.Parent = sectionContent

            local bottomPadding = Instance.new("Frame")
            bottomPadding.Size = UDim2.new(1, 0, 0, 12)
            bottomPadding.BackgroundTransparency = 1
            bottomPadding.LayoutOrder = 9999
            bottomPadding.Parent = sectionContent

            Section.Frame = sectionFrame
            Section.Content = sectionContent
            table.insert(Tab.Sections, Section)

            function Section:CreateButton(buttonConfig)
                buttonConfig = buttonConfig or {}
                local buttonText = buttonConfig.Text or "Button"
                local buttonCallback = buttonConfig.Callback or function() end

                local button = Instance.new("TextButton")
                button.Name = buttonText
                button.Size = UDim2.new(1, 0, 0, 38)
                button.BackgroundColor3 = Color3.fromRGB(40, 38, 41)
                button.BorderSizePixel = 0
                button.Text = buttonText
                button.TextColor3 = Color3.fromRGB(220, 220, 225)
                button.TextSize = 13
                button.Font = Enum.Font.GothamMedium
                button.Parent = sectionContent
                createUICorner(button, 10)
                createStroke(button, 1, Color3.fromRGB(65, 60, 63), 0.5)

                button.MouseEnter:Connect(function()
                    button.BackgroundColor3 = Color3.fromRGB(50, 48, 51)
                end)

                button.MouseLeave:Connect(function()
                    button.BackgroundColor3 = Color3.fromRGB(40, 38, 41)
                end)

                button.MouseButton1Click:Connect(function()
                    button.BackgroundColor3 = Color3.fromRGB(55, 53, 56)
                    wait(0.1)
                    button.BackgroundColor3 = Color3.fromRGB(50, 48, 51)
                    buttonCallback()
                end)

                return button
            end

            function Section:CreateToggle(toggleConfig)
                toggleConfig = toggleConfig or {}
                local toggleText = toggleConfig.Text or "Toggle"
                local defaultState = toggleConfig.Default or false
                local toggleCallback = toggleConfig.Callback or function() end

                local toggleFrame = Instance.new("Frame")
                toggleFrame.Name = toggleText
                toggleFrame.Size = UDim2.new(1, 0, 0, 38)
                toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 38, 41)
                toggleFrame.BorderSizePixel = 0
                toggleFrame.Parent = sectionContent
                createUICorner(toggleFrame, 10)
                createStroke(toggleFrame, 1, Color3.fromRGB(65, 60, 63), 0.5)

                local toggleLabel = Instance.new("TextLabel")
                toggleLabel.Size = UDim2.new(1, -70, 1, 0)
                toggleLabel.Position = UDim2.new(0, 15, 0, 0)
                toggleLabel.BackgroundTransparency = 1
                toggleLabel.Text = toggleText
                toggleLabel.TextColor3 = Color3.fromRGB(220, 220, 225)
                toggleLabel.TextSize = 13
                toggleLabel.Font = Enum.Font.GothamMedium
                toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                toggleLabel.Parent = toggleFrame

                local toggleButton = Instance.new("TextButton")
                toggleButton.Name = "Toggle"
                toggleButton.Size = UDim2.new(0, 50, 0, 24)
                toggleButton.Position = UDim2.new(1, -60, 0.5, -12)
                toggleButton.BackgroundColor3 = Color3.fromRGB(50, 45, 48)
                toggleButton.BorderSizePixel = 0
                toggleButton.Text = ""
                toggleButton.Parent = toggleFrame
                createUICorner(toggleButton, 12)

                local toggleIndicator = Instance.new("Frame")
                toggleIndicator.Name = "Indicator"
                toggleIndicator.Size = UDim2.new(0, 18, 0, 18)
                toggleIndicator.Position = UDim2.new(0, 3, 0.5, -9)
                toggleIndicator.BackgroundColor3 = Color3.fromRGB(80, 75, 78)
                toggleIndicator.BorderSizePixel = 0
                toggleIndicator.Parent = toggleButton
                createUICorner(toggleIndicator, 9)

                local isToggled = defaultState

                local function updateToggle()
                    if isToggled then
                        toggleButton.BackgroundColor3 = Color3.fromRGB(100, 150, 100)
                        toggleIndicator.Position = UDim2.new(1, -21, 0.5, -9)
                        toggleIndicator.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
                    else
                        toggleButton.BackgroundColor3 = Color3.fromRGB(50, 45, 48)
                        toggleIndicator.Position = UDim2.new(0, 3, 0.5, -9)
                        toggleIndicator.BackgroundColor3 = Color3.fromRGB(80, 75, 78)
                    end
                end

                updateToggle()

                toggleButton.MouseButton1Click:Connect(function()
                    isToggled = not isToggled
                    updateToggle()
                    toggleCallback(isToggled)
                end)

                return {
                    Set = function(self, value)
                        isToggled = value
                        updateToggle()
                    end
                }
            end

            function Section:CreateSlider(sliderConfig)
                sliderConfig = sliderConfig or {}
                local sliderText = sliderConfig.Text or "Slider"
                local minValue = sliderConfig.Min or 0
                local maxValue = sliderConfig.Max or 100
                local defaultValue = sliderConfig.Default or 50
                local sliderCallback = sliderConfig.Callback or function() end

                local sliderFrame = Instance.new("Frame")
                sliderFrame.Name = sliderText
                sliderFrame.Size = UDim2.new(1, 0, 0, 55)
                sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 38, 41)
                sliderFrame.BorderSizePixel = 0
                sliderFrame.Parent = sectionContent
                createUICorner(sliderFrame, 10)
                createStroke(sliderFrame, 1, Color3.fromRGB(65, 60, 63), 0.5)

                local sliderLabel = Instance.new("TextLabel")
                sliderLabel.Size = UDim2.new(1, -80, 0, 20)
                sliderLabel.Position = UDim2.new(0, 15, 0, 8)
                sliderLabel.BackgroundTransparency = 1
                sliderLabel.Text = sliderText
                sliderLabel.TextColor3 = Color3.fromRGB(220, 220, 225)
                sliderLabel.TextSize = 13
                sliderLabel.Font = Enum.Font.GothamMedium
                sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                sliderLabel.Parent = sliderFrame

                local sliderValue = Instance.new("TextLabel")
                sliderValue.Size = UDim2.new(0, 60, 0, 20)
                sliderValue.Position = UDim2.new(1, -70, 0, 8)
                sliderValue.BackgroundTransparency = 1
                sliderValue.Text = tostring(defaultValue)
                sliderValue.TextColor3 = Color3.fromRGB(180, 180, 185)
                sliderValue.TextSize = 12
                sliderValue.Font = Enum.Font.GothamBold
                sliderValue.TextXAlignment = Enum.TextXAlignment.Right
                sliderValue.Parent = sliderFrame

                local sliderBar = Instance.new("Frame")
                sliderBar.Name = "SliderBar"
                sliderBar.Size = UDim2.new(1, -30, 0, 6)
                sliderBar.Position = UDim2.new(0, 15, 1, -20)
                sliderBar.BackgroundColor3 = Color3.fromRGB(50, 45, 48)
                sliderBar.BorderSizePixel = 0
                sliderBar.Parent = sliderFrame
                createUICorner(sliderBar, 3)

                local sliderFill = Instance.new("Frame")
                sliderFill.Name = "Fill"
                sliderFill.Size = UDim2.new(0, 0, 1, 0)
                sliderFill.BackgroundColor3 = Color3.fromRGB(120, 160, 120)
                sliderFill.BorderSizePixel = 0
                sliderFill.Parent = sliderBar
                createUICorner(sliderFill, 3)

                local sliderHandle = Instance.new("Frame")
                sliderHandle.Name = "Handle"
                sliderHandle.Size = UDim2.new(0, 14, 0, 14)
                sliderHandle.Position = UDim2.new(0, -7, 0.5, -7)
                sliderHandle.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
                sliderHandle.BorderSizePixel = 0
                sliderHandle.Parent = sliderFill
                createUICorner(sliderHandle, 7)
                createStroke(sliderHandle, 2, Color3.fromRGB(100, 150, 100), 0)

                local currentValue = defaultValue
                local dragging = false

                local function updateSlider(input)
                    local barPos = sliderBar.AbsolutePosition.X
                    local barSize = sliderBar.AbsoluteSize.X
                    local mousePos = input.Position.X
                    local percentage = math.clamp((mousePos - barPos) / barSize, 0, 1)
                    currentValue = math.floor(minValue + (maxValue - minValue) * percentage)
                    
                    sliderValue.Text = tostring(currentValue)
                    sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                    
                    sliderCallback(currentValue)
                end

                local function setSliderValue(value)
                    currentValue = math.clamp(value, minValue, maxValue)
                    local percentage = (currentValue - minValue) / (maxValue - minValue)
                    sliderValue.Text = tostring(currentValue)
                    sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                end

                setSliderValue(defaultValue)

                sliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        updateSlider(input)
                    end
                end)

                sliderBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        updateSlider(input)
                    end
                end)

                return {
                    Set = function(self, value)
                        setSliderValue(value)
                    end
                }
            end

            function Section:CreateInput(inputConfig)
                inputConfig = inputConfig or {}
                local inputText = inputConfig.Text or "Input"
                local placeholderText = inputConfig.Placeholder or "Enter text..."
                local inputCallback = inputConfig.Callback or function() end

                local inputFrame = Instance.new("Frame")
                inputFrame.Name = inputText
                inputFrame.Size = UDim2.new(1, 0, 0, 55)
                inputFrame.BackgroundColor3 = Color3.fromRGB(40, 38, 41)
                inputFrame.BorderSizePixel = 0
                inputFrame.Parent = sectionContent
                createUICorner(inputFrame, 10)
                createStroke(inputFrame, 1, Color3.fromRGB(65, 60, 63), 0.5)

                local inputLabel = Instance.new("TextLabel")
                inputLabel.Size = UDim2.new(1, -30, 0, 20)
                inputLabel.Position = UDim2.new(0, 15, 0, 8)
                inputLabel.BackgroundTransparency = 1
                inputLabel.Text = inputText
                inputLabel.TextColor3 = Color3.fromRGB(220, 220, 225)
                inputLabel.TextSize = 13
                inputLabel.Font = Enum.Font.GothamMedium
                inputLabel.TextXAlignment = Enum.TextXAlignment.Left
                inputLabel.Parent = inputFrame

                local inputBox = Instance.new("TextBox")
                inputBox.Name = "InputBox"
                inputBox.Size = UDim2.new(1, -30, 0, 24)
                inputBox.Position = UDim2.new(0, 15, 1, -30)
                inputBox.BackgroundColor3 = Color3.fromRGB(50, 45, 48)
                inputBox.BorderSizePixel = 0
                inputBox.Text = ""
                inputBox.PlaceholderText = placeholderText
                inputBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 125)
                inputBox.TextColor3 = Color3.fromRGB(220, 220, 225)
                inputBox.TextSize = 12
                inputBox.Font = Enum.Font.Gotham
                inputBox.ClearTextOnFocus = false
                inputBox.Parent = inputFrame
                createUICorner(inputBox, 8)
                createUIPadding(inputBox, 8)

                inputBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        inputCallback(inputBox.Text)
                    end
                end)

                return {
                    Set = function(self, text)
                        inputBox.Text = text
                    end
                }
            end

            return Section
        end

        return Tab
    end

    return Window
end

return Library
