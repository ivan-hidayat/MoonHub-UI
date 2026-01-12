local Library = {}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local UI_NAME = "ModernUI"

local function RemoveExistingUI()
    local existing = PlayerGui:FindFirstChild(UI_NAME)
    if existing then
        existing:Destroy()
    end
end

local function CreateElement(className, properties)
    local element = Instance.new(className)
    for prop, value in pairs(properties) do
        if prop == "Parent" then
            continue
        end
        element[prop] = value
    end
    if properties.Parent then
        element.Parent = properties.Parent
    end
    return element
end

function Library:CreateWindow(config)
    RemoveExistingUI()
    
    local windowName = config.Name or "Modern UI"
    local loadingEnabled = config.LoadingEnabled ~= false
    
    local ScreenGui = CreateElement("ScreenGui", {
        Name = UI_NAME,
        Parent = PlayerGui,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    
    local MainFrame = CreateElement("Frame", {
        Name = "MainFrame",
        Parent = ScreenGui,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 650, 0, 450),
        BackgroundColor3 = Color3.fromRGB(32, 32, 34),
        BorderSizePixel = 0
    })
    
    CreateElement("UICorner", {
        Parent = MainFrame,
        CornerRadius = UDim.new(0, 8)
    })
    
    local Header = CreateElement("Frame", {
        Name = "Header",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundColor3 = Color3.fromRGB(28, 28, 30),
        BorderSizePixel = 0
    })
    
    CreateElement("UICorner", {
        Parent = Header,
        CornerRadius = UDim.new(0, 8)
    })
    
    local HeaderBottom = CreateElement("Frame", {
        Parent = Header,
        Position = UDim2.new(0, 0, 1, -8),
        Size = UDim2.new(1, 0, 0, 8),
        BackgroundColor3 = Color3.fromRGB(28, 28, 30),
        BorderSizePixel = 0
    })
    
    local Title = CreateElement("TextLabel", {
        Name = "Title",
        Parent = Header,
        Position = UDim2.new(0, 20, 0, 0),
        Size = UDim2.new(0, 300, 1, 0),
        BackgroundTransparency = 1,
        Text = windowName,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold
    })
    
    local CloseButton = CreateElement("TextButton", {
        Name = "CloseButton",
        Parent = Header,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -15, 0.5, 0),
        Size = UDim2.new(0, 30, 0, 30),
        BackgroundColor3 = Color3.fromRGB(40, 40, 42),
        Text = "×",
        TextColor3 = Color3.fromRGB(220, 220, 220),
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0
    })
    
    CreateElement("UICorner", {
        Parent = CloseButton,
        CornerRadius = UDim.new(0, 6)
    })
    
    local MinimizeButton = CreateElement("TextButton", {
        Name = "MinimizeButton",
        Parent = Header,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -48, 0.5, 0),
        Size = UDim2.new(0, 30, 0, 30),
        BackgroundColor3 = Color3.fromRGB(40, 40, 42),
        Text = "−",
        TextColor3 = Color3.fromRGB(220, 220, 220),
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0
    })
    
    CreateElement("UICorner", {
        Parent = MinimizeButton,
        CornerRadius = UDim.new(0, 6)
    })
    
    local ContentFrame = CreateElement("Frame", {
        Name = "ContentFrame",
        Parent = MainFrame,
        Position = UDim2.new(0, 0, 0, 50),
        Size = UDim2.new(1, 0, 1, -50),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    })
    
    local TabContainer = CreateElement("Frame", {
        Name = "TabContainer",
        Parent = ContentFrame,
        Size = UDim2.new(0, 150, 1, 0),
        BackgroundColor3 = Color3.fromRGB(28, 28, 30),
        BorderSizePixel = 0
    })
    
    local TabList = CreateElement("ScrollingFrame", {
        Name = "TabList",
        Parent = TabContainer,
        Size = UDim2.new(1, 0, 1, -10),
        Position = UDim2.new(0, 0, 0, 10),
        BackgroundTransparency = 1,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromRGB(60, 60, 62),
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
    
    CreateElement("UIListLayout", {
        Parent = TabList,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6)
    })
    
    CreateElement("UIPadding", {
        Parent = TabList,
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 5)
    })
    
    local PageContainer = CreateElement("Frame", {
        Name = "PageContainer",
        Parent = ContentFrame,
        Position = UDim2.new(0, 150, 0, 0),
        Size = UDim2.new(1, -150, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    })
    
    local MinimizedFrame = CreateElement("Frame", {
        Name = "MinimizedFrame",
        Parent = ScreenGui,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -15, 0, 15),
        Size = UDim2.new(0, 200, 0, 45),
        BackgroundColor3 = Color3.fromRGB(32, 32, 34),
        BorderSizePixel = 0,
        Visible = false
    })
    
    CreateElement("UICorner", {
        Parent = MinimizedFrame,
        CornerRadius = UDim.new(0, 8)
    })
    
    local MinimizedTitle = CreateElement("TextLabel", {
        Parent = MinimizedFrame,
        Position = UDim2.new(0, 15, 0, 0),
        Size = UDim2.new(1, -55, 1, 0),
        BackgroundTransparency = 1,
        Text = windowName,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamSemibold
    })
    
    local RestoreButton = CreateElement("TextButton", {
        Parent = MinimizedFrame,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 28, 0, 28),
        BackgroundColor3 = Color3.fromRGB(40, 40, 42),
        Text = "+",
        TextColor3 = Color3.fromRGB(220, 220, 220),
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0
    })
    
    CreateElement("UICorner", {
        Parent = RestoreButton,
        CornerRadius = UDim.new(0, 6)
    })
    
    local isMinimized = false
    
    MinimizeButton.MouseButton1Click:Connect(function()
        isMinimized = true
        
        local savedPos = MainFrame.Position
        
        MinimizedFrame.Position = UDim2.new(
            savedPos.X.Scale,
            savedPos.X.Offset + MainFrame.AbsoluteSize.X - MinimizedFrame.AbsoluteSize.X,
            savedPos.Y.Scale,
            savedPos.Y.Offset
        )
        MainFrame.Visible = false
        MinimizedFrame.Visible = true
    end)

    RestoreButton.MouseButton1Click:Connect(function()
        isMinimized = false
       
        MainFrame.Position = MinimizedFrame.Position
        
        MainFrame.Visible = true
        MinimizedFrame.Visible = false
    end)

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    Header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            local newPos = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
            
            MainFrame.Position = newPos
            
            if isMinimized then
                MinimizedFrame.Position = newPos
            end
        end
    end)

    local minDragging = false
    local minDragStart = nil
    local minStartPos = nil

    MinimizedFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            minDragging = true
            minDragStart = input.Position
            minStartPos = MinimizedFrame.Position
        end
    end)

    MinimizedFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            minDragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if minDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - minDragStart
            local newPos = UDim2.new(
                minStartPos.X.Scale,
                minStartPos.X.Offset + delta.X,
                minStartPos.Y.Scale,
                minStartPos.Y.Offset + delta.Y
            )
            
            MinimizedFrame.Position = newPos
            MainFrame.Position = newPos
        end
    end)
    
    local Window = {
        Tabs = {},
        CurrentTab = nil
    }
    
    function Window:CreateTab(config)
        local tabName = config.Name or "Tab"
        
        local TabButton = CreateElement("TextButton", {
            Name = "TabButton",
            Parent = TabList,
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = Color3.fromRGB(40, 40, 42),
            Text = tabName,
            TextColor3 = Color3.fromRGB(200, 200, 200),
            TextSize = 13,
            Font = Enum.Font.GothamMedium,
            BorderSizePixel = 0
        })
        
        CreateElement("UICorner", {
            Parent = TabButton,
            CornerRadius = UDim.new(0, 6)
        })
        
        local Page = CreateElement("ScrollingFrame", {
            Name = "Page",
            Parent = PageContainer,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Color3.fromRGB(60, 60, 62),
            BorderSizePixel = 0,
            Visible = false,
            CanvasSize = UDim2.new(0, 0, 0, 0)
        })
        
        CreateElement("UIListLayout", {
            Parent = Page,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12)
        })
        
        CreateElement("UIPadding", {
            Parent = Page,
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15),
            PaddingTop = UDim.new(0, 15),
            PaddingBottom = UDim.new(0, 15)
        })
        
        TabButton.MouseButton1Click:Connect(function()
            if Window.CurrentTab then
                Window.CurrentTab.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 42)
                Window.CurrentTab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
                Window.CurrentTab.Page.Visible = false
            end
            
            TabButton.BackgroundColor3 = Color3.fromRGB(75, 75, 77)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            Page.Visible = true
            Window.CurrentTab = {Button = TabButton, Page = Page}
        end)
        
        if not Window.CurrentTab then
            TabButton.BackgroundColor3 = Color3.fromRGB(75, 75, 77)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            Page.Visible = true
            Window.CurrentTab = {Button = TabButton, Page = Page}
        end
        
        local Tab = {
            Page = Page
        }
        
        function Tab:CreateSection(config)
            local sectionName = config.Name or "Section"
            
            local Section = CreateElement("Frame", {
                Name = "Section",
                Parent = Page,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundColor3 = Color3.fromRGB(38, 38, 40),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            CreateElement("UICorner", {
                Parent = Section,
                CornerRadius = UDim.new(0, 8)
            })
            
            local SectionTitle = CreateElement("TextLabel", {
                Name = "SectionTitle",
                Parent = Section,
                Size = UDim2.new(1, -24, 0, 32),
                Position = UDim2.new(0, 12, 0, 8),
                BackgroundTransparency = 1,
                Text = sectionName,
                TextColor3 = Color3.fromRGB(230, 230, 230),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Font = Enum.Font.GothamSemibold
            })
            
            local SectionContent = CreateElement("Frame", {
                Name = "SectionContent",
                Parent = Section,
                Position = UDim2.new(0, 0, 0, 40),
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            
            CreateElement("UIListLayout", {
                Parent = SectionContent,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10)
            })
            
            CreateElement("UIPadding", {
                Parent = SectionContent,
                PaddingLeft = UDim.new(0, 12),
                PaddingRight = UDim.new(0, 12),
                PaddingBottom = UDim.new(0, 12)
            })
            
            local SectionTab = {}
            
            function SectionTab:CreateButton(config)
                local buttonName = config.Name or "Button"
                local callback = config.Callback or function() end
                
                local Button = CreateElement("TextButton", {
                    Name = "Button",
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 36),
                    BackgroundColor3 = Color3.fromRGB(48, 48, 50),
                    Text = buttonName,
                    TextColor3 = Color3.fromRGB(220, 220, 220),
                    TextSize = 13,
                    Font = Enum.Font.GothamMedium,
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = Button,
                    CornerRadius = UDim.new(0, 6)
                })
                
                Button.MouseButton1Click:Connect(callback)
                
                return Button
            end
            
            function SectionTab:CreateToggle(config)
                local toggleName = config.Name or "Toggle"
                local default = config.Default or false
                local callback = config.Callback or function() end
                
                local ToggleFrame = CreateElement("Frame", {
                    Name = "ToggleFrame",
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 36),
                    BackgroundColor3 = Color3.fromRGB(48, 48, 50),
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = ToggleFrame,
                    CornerRadius = UDim.new(0, 6)
                })
                
                local ToggleLabel = CreateElement("TextLabel", {
                    Parent = ToggleFrame,
                    Position = UDim2.new(0, 12, 0, 0),
                    Size = UDim2.new(1, -60, 1, 0),
                    BackgroundTransparency = 1,
                    Text = toggleName,
                    TextColor3 = Color3.fromRGB(220, 220, 220),
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.GothamMedium
                })
                
                local ToggleButton = CreateElement("TextButton", {
                    Parent = ToggleFrame,
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -12, 0.5, 0),
                    Size = UDim2.new(0, 40, 0, 20),
                    BackgroundColor3 = default and Color3.fromRGB(80, 180, 120) or Color3.fromRGB(60, 60, 62),
                    Text = "",
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = ToggleButton,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local ToggleIndicator = CreateElement("Frame", {
                    Parent = ToggleButton,
                    Position = default and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
                    AnchorPoint = Vector2.new(0, 0.5),
                    Size = UDim2.new(0, 16, 0, 16),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = ToggleIndicator,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local toggled = default
                
                ToggleButton.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    ToggleButton.BackgroundColor3 = toggled and Color3.fromRGB(80, 180, 120) or Color3.fromRGB(60, 60, 62)
                    ToggleIndicator.Position = toggled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                    callback(toggled)
                end)
                
                return {
                    Set = function(value)
                        toggled = value
                        ToggleButton.BackgroundColor3 = toggled and Color3.fromRGB(80, 180, 120) or Color3.fromRGB(60, 60, 62)
                        ToggleIndicator.Position = toggled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                    end
                }
            end
            
            function SectionTab:CreateSlider(config)
                local sliderName = config.Name or "Slider"
                local min = config.Min or 0
                local max = config.Max or 100
                local default = config.Default or min
                local increment = config.Increment or 1
                local callback = config.Callback or function() end
                
                local SliderFrame = CreateElement("Frame", {
                    Name = "SliderFrame",
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 52),
                    BackgroundColor3 = Color3.fromRGB(48, 48, 50),
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = SliderFrame,
                    CornerRadius = UDim.new(0, 6)
                })
                
                local SliderLabel = CreateElement("TextLabel", {
                    Parent = SliderFrame,
                    Position = UDim2.new(0, 12, 0, 8),
                    Size = UDim2.new(1, -80, 0, 16),
                    BackgroundTransparency = 1,
                    Text = sliderName,
                    TextColor3 = Color3.fromRGB(220, 220, 220),
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.GothamMedium
                })
                
                local SliderValue = CreateElement("TextLabel", {
                    Parent = SliderFrame,
                    AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, -12, 0, 8),
                    Size = UDim2.new(0, 60, 0, 16),
                    BackgroundTransparency = 1,
                    Text = tostring(default),
                    TextColor3 = Color3.fromRGB(180, 180, 180),
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Font = Enum.Font.GothamMedium
                })
                
                local SliderTrack = CreateElement("Frame", {
                    Parent = SliderFrame,
                    Position = UDim2.new(0, 12, 1, -18),
                    Size = UDim2.new(1, -24, 0, 6),
                    BackgroundColor3 = Color3.fromRGB(60, 60, 62),
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = SliderTrack,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local SliderFill = CreateElement("Frame", {
                    Parent = SliderTrack,
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = Color3.fromRGB(80, 180, 120),
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = SliderFill,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local SliderDrag = CreateElement("Frame", {
                    Parent = SliderTrack,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0),
                    Size = UDim2.new(0, 14, 0, 14),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = SliderDrag,
                    CornerRadius = UDim.new(1, 0)
                })
                
                local currentValue = default
                local dragging = false
                
                local function updateSlider(input)
                    local pos = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
                    local value = min + (max - min) * pos
                    value = math.floor(value / increment + 0.5) * increment
                    value = math.clamp(value, min, max)
                    
                    currentValue = value
                    SliderValue.Text = tostring(value)
                    SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                    SliderDrag.Position = UDim2.new(pos, 0, 0.5, 0)
                    
                    callback(value)
                end
                
                SliderTrack.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        updateSlider(input)
                    end
                end)
                
                SliderTrack.InputEnded:Connect(function(input)
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
                    Set = function(value)
                        value = math.clamp(value, min, max)
                        currentValue = value
                        SliderValue.Text = tostring(value)
                        local pos = (value - min) / (max - min)
                        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                        SliderDrag.Position = UDim2.new(pos, 0, 0.5, 0)
                    end
                }
            end
            
            function SectionTab:CreateInput(config)
                local inputName = config.Name or "Input"
                local placeholder = config.Placeholder or "Enter text..."
                local default = config.Default or ""
                local callback = config.Callback or function() end
                
                local InputFrame = CreateElement("Frame", {
                    Name = "InputFrame",
                    Parent = SectionContent,
                    Size = UDim2.new(1, 0, 0, 68),
                    BackgroundColor3 = Color3.fromRGB(48, 48, 50),
                    BorderSizePixel = 0
                })
                
                CreateElement("UICorner", {
                    Parent = InputFrame,
                    CornerRadius = UDim.new(0, 6)
                })
                
                local InputLabel = CreateElement("TextLabel", {
                    Parent = InputFrame,
                    Position = UDim2.new(0, 12, 0, 8),
                    Size = UDim2.new(1, -24, 0, 16),
                    BackgroundTransparency = 1,
                    Text = inputName,
                    TextColor3 = Color3.fromRGB(220, 220, 220),
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Font = Enum.Font.GothamMedium
                })
                
                local InputBox = CreateElement("TextBox", {
                    Parent = InputFrame,
                    Position = UDim2.new(0, 12, 0, 32),
                    Size = UDim2.new(1, -24, 0, 28),
                    BackgroundColor3 = Color3.fromRGB(38, 38, 40),
                    Text = default,
                    PlaceholderText = placeholder,
                    TextColor3 = Color3.fromRGB(220, 220, 220),
                    PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    BorderSizePixel = 0,
                    ClearTextOnFocus = false
                })
                
                CreateElement("UICorner", {
                    Parent = InputBox,
                    CornerRadius = UDim.new(0, 5)
                })
                
                CreateElement("UIPadding", {
                    Parent = InputBox,
                    PaddingLeft = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 8)
                })
                
                InputBox.FocusLost:Connect(function()
                    callback(InputBox.Text)
                end)
                
                return {
                    Set = function(value)
                        InputBox.Text = value
                    end
                }
            end
            
            return SectionTab
        end
        
        return Tab
    end
    
    TabList.ChildAdded:Connect(function()
        task.wait()
        TabList.CanvasSize = UDim2.new(0, 0, 0, TabList.UIListLayout.AbsoluteContentSize.Y + 10)
    end)
    
    return Window
end

return Library
