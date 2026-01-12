local Library = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local function RemoveExistingUI(name)
    local existing = PlayerGui:FindFirstChild(name)
    if existing then
        existing:Destroy()
    end
end

local function CreateElement(className, properties)
    local element = Instance.new(className)
    for prop, value in pairs(properties) do
        element[prop] = value
    end
    return element
end

function Library:CreateWindow(config)
    local windowName = config.Name or "UI Library"
    
    RemoveExistingUI(windowName)
    
    local ScreenGui = CreateElement("ScreenGui", {
        Name = windowName,
        Parent = PlayerGui,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    
    local MainFrame = CreateElement("Frame", {
        Name = "MainFrame",
        Parent = ScreenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 550, 0, 400),
        BackgroundColor3 = Color3.fromRGB(25, 23, 28),
        BorderSizePixel = 0
    })
    
    local Gradient = CreateElement("UIGradient", {
        Parent = MainFrame,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 28, 30)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 20, 25))
        }),
        Rotation = 45
    })
    
    local Corner = CreateElement("UICorner", {
        Parent = MainFrame,
        CornerRadius = UDim.new(0, 12)
    })
    
    local Shadow = CreateElement("ImageLabel", {
        Name = "Shadow",
        Parent = MainFrame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 30, 1, 30),
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
        ImageColor3 = Color3.fromRGB(0, 0, 0),
        ImageTransparency = 0.7,
        ZIndex = 0
    })
    
    local TopBar = CreateElement("Frame", {
        Name = "TopBar",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = Color3.fromRGB(35, 32, 38),
        BorderSizePixel = 0
    })
    
    local TopBarCorner = CreateElement("UICorner", {
        Parent = TopBar,
        CornerRadius = UDim.new(0, 12)
    })
    
    local TopBarBottom = CreateElement("Frame", {
        Parent = TopBar,
        Position = UDim2.new(0, 0, 1, -12),
        Size = UDim2.new(1, 0, 0, 12),
        BackgroundColor3 = Color3.fromRGB(35, 32, 38),
        BorderSizePixel = 0
    })
    
    local Title = CreateElement("TextLabel", {
        Name = "Title",
        Parent = TopBar,
        Position = UDim2.new(0, 15, 0, 0),
        Size = UDim2.new(0.6, 0, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = windowName,
        TextColor3 = Color3.fromRGB(240, 240, 245),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local ButtonContainer = CreateElement("Frame", {
        Name = "ButtonContainer",
        Parent = TopBar,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -10, 0, 0),
        Size = UDim2.new(0, 70, 1, 0),
        BackgroundTransparency = 1
    })
    
    local MinimizeButton = CreateElement("TextButton", {
        Name = "MinimizeButton",
        Parent = ButtonContainer,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -35, 0.5, 0),
        Size = UDim2.new(0, 28, 0, 28),
        BackgroundColor3 = Color3.fromRGB(45, 42, 48),
        Font = Enum.Font.GothamBold,
        Text = "—",
        TextColor3 = Color3.fromRGB(200, 200, 210),
        TextSize = 14,
        BorderSizePixel = 0
    })
    
    local MinimizeCorner = CreateElement("UICorner", {
        Parent = MinimizeButton,
        CornerRadius = UDim.new(0, 6)
    })
    
    local CloseButton = CreateElement("TextButton", {
        Name = "CloseButton",
        Parent = ButtonContainer,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 28, 0, 28),
        BackgroundColor3 = Color3.fromRGB(180, 60, 70),
        Font = Enum.Font.GothamBold,
        Text = "✕",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        BorderSizePixel = 0
    })
    
    local CloseCorner = CreateElement("UICorner", {
        Parent = CloseButton,
        CornerRadius = UDim.new(0, 6)
    })
    
    local TabContainer = CreateElement("Frame", {
        Name = "TabContainer",
        Parent = MainFrame,
        Position = UDim2.new(0, 0, 0, 45),
        Size = UDim2.new(0, 140, 1, -45),
        BackgroundColor3 = Color3.fromRGB(28, 26, 31),
        BorderSizePixel = 0
    })
    
    local TabList = CreateElement("UIListLayout", {
        Parent = TabContainer,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    })
    
    local TabPadding = CreateElement("UIPadding", {
        Parent = TabContainer,
        PaddingTop = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 10)
    })
    
    local ContentContainer = CreateElement("Frame", {
        Name = "ContentContainer",
        Parent = MainFrame,
        Position = UDim2.new(0, 140, 0, 45),
        Size = UDim2.new(1, -140, 1, -45),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    })
    
    local MinimizedFrame = CreateElement("Frame", {
        Name = "MinimizedFrame",
        Parent = ScreenGui,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -10, 0, 10),
        Size = UDim2.new(0, 180, 0, 50),
        BackgroundColor3 = Color3.fromRGB(32, 28, 30),
        BorderSizePixel = 0,
        Visible = false
    })
    
    local MinimizedCorner = CreateElement("UICorner", {
        Parent = MinimizedFrame,
        CornerRadius = UDim.new(0, 10)
    })
    
    local MinimizedGradient = CreateElement("UIGradient", {
        Parent = MinimizedFrame,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(32, 28, 30)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 20, 25))
        }),
        Rotation = 45
    })
    
    local MinimizedTitle = CreateElement("TextLabel", {
        Parent = MinimizedFrame,
        Position = UDim2.new(0, 12, 0, 0),
        Size = UDim2.new(0.7, 0, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        Text = windowName,
        TextColor3 = Color3.fromRGB(240, 240, 245),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local RestoreButton = CreateElement("TextButton", {
        Name = "RestoreButton",
        Parent = MinimizedFrame,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 30, 0, 30),
        BackgroundColor3 = Color3.fromRGB(45, 42, 48),
        Font = Enum.Font.GothamBold,
        Text = "□",
        TextColor3 = Color3.fromRGB(200, 200, 210),
        TextSize = 14,
        BorderSizePixel = 0
    })
    
    local RestoreCorner = CreateElement("UICorner", {
        Parent = RestoreButton,
        CornerRadius = UDim.new(0, 6)
    })
    
    local isMinimized = false
    
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = true
        MainFrame.Visible = false
        MinimizedFrame.Visible = true
    end)
    
    RestoreButton.MouseButton1Click:Connect(function()
        isMinimized = false
        MainFrame.Visible = true
        MinimizedFrame.Visible = false
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    local dragToggle = false
    local dragStart = nil
    local startPos = nil
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragToggle then
                updateInput(input)
            end
        end
    end)
    
    local Window = {
        Tabs = {},
        CurrentTab = nil
    }
    
    function Window:CreateTab(tabName)
        local TabButton = CreateElement("TextButton", {
            Name = tabName,
            Parent = TabContainer,
            Size = UDim2.new(1, 0, 0, 38),
            BackgroundColor3 = Color3.fromRGB(38, 35, 40),
            Font = Enum.Font.Gotham,
            Text = tabName,
            TextColor3 = Color3.fromRGB(180, 180, 190),
            TextSize = 13,
            BorderSizePixel = 0
        })
        
        local TabCorner = CreateElement("UICorner", {
            Parent = TabButton,
            CornerRadius = UDim.new(0, 8)
        })
        
        local TabContent = CreateElement("ScrollingFrame", {
            Name = tabName .. "Content",
            Parent = ContentContainer,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Color3.fromRGB(60, 55, 65),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false
        })
        
        local ContentList = CreateElement("UIListLayout", {
            Parent = TabContent,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        })
        
        local ContentPadding = CreateElement("UIPadding", {
            Parent = TabContent,
            PaddingTop = UDim.new(0, 12),
            PaddingLeft = UDim.new(0, 12),
            PaddingRight = UDim.new(0, 12),
            PaddingBottom = UDim.new(0, 12)
        })
        
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 24)
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab.Button.BackgroundColor3 = Color3.fromRGB(38, 35, 40)
                tab.Button.TextColor3 = Color3.fromRGB(180, 180, 190)
                tab.Content.Visible = false
            end
            
            TabButton.BackgroundColor3 = Color3.fromRGB(85, 70, 100)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end)
        
        local Tab = {
            Button = TabButton,
            Content = TabContent,
            Sections = {}
        }
        
        table.insert(Window.Tabs, Tab)
        
        if #Window.Tabs == 1 then
            TabButton.BackgroundColor3 = Color3.fromRGB(85, 70, 100)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabContent.Visible = true
            Window.CurrentTab = Tab
        end
        
        function Tab:CreateSection(sectionName)
            local SectionFrame = CreateElement("Frame", {
                Name = sectionName,
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundColor3 = Color3.fromRGB(32, 30, 35),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            local SectionCorner = CreateElement("UICorner", {
                Parent = SectionFrame,
                CornerRadius = UDim.new(0, 8)
            })
            
            local SectionTitle = CreateElement("TextLabel", {
                Name = "SectionTitle",
                Parent = SectionFrame,
                Size = UDim2.new(1, 0, 0, 35),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                Text = sectionName,
                TextColor3 = Color3.fromRGB(220, 220, 230),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            
            local SectionTitlePadding = CreateElement("UIPadding", {
                Parent = SectionTitle,
                PaddingLeft = UDim.new(0, 12)
            })
            
            local SectionContent = CreateElement("Frame", {
                Name = "SectionContent",
                Parent = SectionFrame,
                Position = UDim2.new(0, 0, 0, 35),
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            local SectionList = CreateElement("UIListLayout", {
                Parent = SectionContent,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 6)
            })
            
            local SectionContentPadding = CreateElement("UIPadding", {
                Parent = SectionContent,
                PaddingLeft = UDim.new(0, 12),
                PaddingRight = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 10)
            })
            
            local Section = {}
            
            function Section:CreateButton(buttonName, callback)
                local Button = CreateElement("TextButton", {
                    Name = buttonName,
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 36),
                    BackgroundColor3 = Color3.fromRGB(45, 42, 48),
                    Font = Enum.Font.Gotham,
                    Text = buttonName,
                    TextColor3 = Color3.fromRGB(200, 200, 210),
                    TextSize = 13,
                    BorderSizePixel = 0
                })
                
                local ButtonCorner = CreateElement("UICorner", {
                    Parent = Button,
                    CornerRadius = UDim.new(0, 6)
                })
                
                Button.MouseEnter:Connect(function()
                    Button.BackgroundColor3 = Color3.fromRGB(55, 52, 58)
                end)
                
                Button.MouseLeave:Connect(function()
                    Button.BackgroundColor3 = Color3.fromRGB(45, 42, 48)
                end)
                
                Button.MouseButton1Click:Connect(function()
                    if callback then
                        callback()
                    end
                end)
                
                return Button
            end
            
            function Section:CreateToggle(toggleName, defaultValue, callback)
                local ToggleFrame = CreateElement("Frame", {
                    Name = toggleName,
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 36),
                    BackgroundColor3 = Color3.fromRGB(45, 42, 48),
                    BorderSizePixel = 0
                })
                
                local ToggleCorner = CreateElement("UICorner", {
                    Parent = ToggleFrame,
                    CornerRadius = UDim.new(0, 6)
                })
                
                local ToggleLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = ToggleFrame,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(0.7, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Font = Enum.Font.Gotham,
                    Text = toggleName,
                    TextColor3 = Color3.fromRGB(200, 200, 210),
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                local ToggleButton = CreateElement("TextButton", {
                    Name = "ToggleButton",
                    Parent = ToggleFrame,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -12, 0.5, 0),
                    Size = UDim2.new(0, 42, 0, 22),
                    BackgroundColor3 = defaultValue and Color3.fromRGB(85, 70, 100) or Color3.fromRGB(60, 55, 65),
                    BorderSizePixel = 0,
                    Text = ""
                })
                
                local ToggleButtonCorner = CreateElement("UICorner", {
                    Parent = ToggleButton,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local ToggleIndicator = CreateElement("Frame", {
                    Name = "Indicator",
                    Parent = ToggleButton,
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = defaultValue and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                    Size = UDim2.new(0, 18, 0, 18),
                    BackgroundColor3 = Color3.fromRGB(240, 240, 245),
                    BorderSizePixel = 0
                })
                
                local IndicatorCorner = CreateElement("UICorner", {
                    Parent = ToggleIndicator,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local toggled = defaultValue or false
                
                ToggleButton.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    
                    ToggleButton.BackgroundColor3 = toggled and Color3.fromRGB(85, 70, 100) or Color3.fromRGB(60, 55, 65)
                    ToggleIndicator.Position = toggled and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                    
                    if callback then
                        callback(toggled)
                    end
                end)
                
                return ToggleFrame
            end
            
            function Section:CreateSlider(sliderName, min, max, defaultValue, callback)
                local SliderFrame = CreateElement("Frame", {
                    Name = sliderName,
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 52),
                    BackgroundColor3 = Color3.fromRGB(45, 42, 48),
                    BorderSizePixel = 0
                })
                
                local SliderCorner = CreateElement("UICorner", {
                    Parent = SliderFrame,
                    CornerRadius = UDim.new(0, 6)
                })
                
                local SliderLabel = CreateElement("TextLabel", {
                    Name = "Label",
                    Parent = SliderFrame,
                    Position = UDim2.new(0, 12, 0, 6),
                    Size = UDim2.new(0.7, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Font = Enum.Font.Gotham,
                    Text = sliderName,
                    TextColor3 = Color3.fromRGB(200, 200, 210),
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                
                local SliderValue = CreateElement("TextLabel", {
                    Name = "Value",
                    Parent = SliderFrame,
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, -12, 0, 6),
                    Size = UDim2.new(0.25, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Font = Enum.Font.GothamBold,
                    Text = tostring(defaultValue or min),
                    TextColor3 = Color3.fromRGB(220, 220, 230),
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Right
                })
                
                local SliderBar = CreateElement("Frame", {
                    Name = "SliderBar",
                    Parent = SliderFrame,
                    Position = UDim2.new(0, 12, 1, -20),
                    Size = UDim2.new(1, -24, 0, 6),
                    BackgroundColor3 = Color3.fromRGB(60, 55, 65),
                    BorderSizePixel = 0
                })
                
                local SliderBarCorner = CreateElement("UICorner", {
                    Parent = SliderBar,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local SliderFill = CreateElement("Frame", {
                    Name = "Fill",
                    Parent = SliderBar,
                    Size = UDim2.new((defaultValue - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(85, 70, 100),
                    BorderSizePixel = 0
                })
                
                local SliderFillCorner = CreateElement("UICorner", {
                    Parent = SliderFill,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local SliderButton = CreateElement("TextButton", {
                    Name = "SliderButton",
                    Parent = SliderBar,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = ""
                })
                
                local dragging = false
                local currentValue = defaultValue or min
                
                local function updateSlider(input)
                    local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    currentValue = math.floor(min + (max - min) * pos)
                    
                    SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                    SliderValue.Text = tostring(currentValue)
                    
                    if callback then
                        callback(currentValue)
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
                
                return SliderFrame
            end
            
            function Section:CreateInput(inputName, placeholder, callback)
                local InputFrame = CreateElement("Frame", {
                    Name = inputName,
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 36),
                    BackgroundColor3 = Color3.fromRGB(45, 42, 48),
                    BorderSizePixel = 0
                })
                
                local InputCorner = CreateElement("UICorner", {
                    Parent = InputFrame,
                    CornerRadius = UDim.new(0, 6)
                })
                
                local InputBox = CreateElement("TextBox", {
                    Name = "InputBox",
                    Parent = InputFrame,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(1, -24, 1, 0),
                    BackgroundTransparency = 1,
                    Font = Enum.Font.Gotham,
                    PlaceholderText = placeholder or "Enter text...",
                    PlaceholderColor3 = Color3.fromRGB(120, 120, 130),
                    Text = "",
                    TextColor3 = Color3.fromRGB(200, 200, 210),
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ClearTextOnFocus = false
                })
                
                InputBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed and callback then
                        callback(InputBox.Text)
                    end
                end)
                
                return InputFrame
            end
            
            return Section
        end
        
        return Tab
    end
    
    return Window
end

return Library
