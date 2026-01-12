local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

local Library = {}

function Library:CreateWindow(Config)
    local TitleText = Config.Name or "UI Library"
    local SubTitleText = Config.SubTitle or "V1.0"
    
    local Player = Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")

    if PlayerGui:FindFirstChild("WarmUILib") then
        PlayerGui.WarmUILib:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "WarmUILib"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Size = UDim2.new(0, 550, 0, 350)
    MainFrame.ClipsDescendants = true

    local UISizeConstraint = Instance.new("UISizeConstraint")
    UISizeConstraint.Parent = MainFrame
    UISizeConstraint.MaxSize = Vector2.new(600, 400)
    UISizeConstraint.MinSize = Vector2.new(300, 200)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = MainFrame

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Rotation = 45
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 28, 28)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(40, 36, 36))
    }
    UIGradient.Parent = MainFrame

    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(45, 42, 42)
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 40)

    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 6)
    TopBarCorner.Parent = TopBar

    local BottomCover = Instance.new("Frame")
    BottomCover.Parent = TopBar
    BottomCover.BackgroundColor3 = TopBar.BackgroundColor3
    BottomCover.BorderSizePixel = 0
    BottomCover.Position = UDim2.new(0, 0, 1, -5)
    BottomCover.Size = UDim2.new(1, 0, 0, 5)

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = TopBar
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.Size = UDim2.new(0, 200, 1, 0)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = TitleText .. " <font color=\"rgb(180,180,180)\">" .. SubTitleText .. "</font>"
    TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.RichText = true

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = TopBar
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Position = UDim2.new(1, -35, 0, 0)
    CloseBtn.Size = UDim2.new(0, 35, 1, 0)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    CloseBtn.TextSize = 14

    local MinBtn = Instance.new("TextButton")
    MinBtn.Parent = TopBar
    MinBtn.BackgroundTransparency = 1
    MinBtn.Position = UDim2.new(1, -70, 0, 0)
    MinBtn.Size = UDim2.new(0, 35, 1, 0)
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.Text = "-"
    MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    MinBtn.TextSize = 14

    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundColor3 = Color3.fromRGB(35, 32, 32)
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.Size = UDim2.new(0, 130, 1, -40)

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabContainer
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)

    local TabPadding = Instance.new("UIPadding")
    TabPadding.Parent = TabContainer
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 5)

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Parent = MainFrame
    ContentContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 130, 0, 40)
    ContentContainer.Size = UDim2.new(1, -130, 1, -40)

    local ContentPadding = Instance.new("UIPadding")
    ContentPadding.Parent = ContentContainer
    ContentPadding.PaddingTop = UDim.new(0, 10)
    ContentPadding.PaddingLeft = UDim.new(0, 10)
    ContentPadding.PaddingRight = UDim.new(0, 10)
    ContentPadding.PaddingBottom = UDim.new(0, 10)

    local OpenButton = Instance.new("TextButton")
    OpenButton.Name = "OpenButton"
    OpenButton.Parent = ScreenGui
    OpenButton.BackgroundColor3 = Color3.fromRGB(40, 38, 38)
    OpenButton.Position = UDim2.new(1, -20, 1, -60) 
    OpenButton.AnchorPoint = Vector2.new(1, 1)
    OpenButton.Size = UDim2.new(0, 50, 0, 50)
    OpenButton.Font = Enum.Font.GothamBold
    OpenButton.Text = "UI"
    OpenButton.TextColor3 = Color3.fromRGB(220, 220, 220)
    OpenButton.TextSize = 14
    OpenButton.Visible = false
    
    local OpenBtnCorner = Instance.new("UICorner")
    OpenBtnCorner.CornerRadius = UDim.new(0, 8)
    OpenBtnCorner.Parent = OpenButton
    
    local OpenBtnStroke = Instance.new("UIStroke")
    OpenBtnStroke.Parent = OpenButton
    OpenBtnStroke.Color = Color3.fromRGB(60, 55, 55)
    OpenBtnStroke.Thickness = 1

    local Dragging, DragInput, DragStart, StartPos

    local function Update(Input)
        local Delta = Input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end

    TopBar.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = Input.Position
            StartPos = MainFrame.Position
            
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    TopBar.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            DragInput = Input
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Input == DragInput and Dragging then
            Update(Input)
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    MinBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        OpenButton.Visible = true
    end)

    OpenButton.MouseButton1Click:Connect(function()
        OpenButton.Visible = false
        MainFrame.Visible = true
    end)

    local Tabs = {}
    local FirstTab = true

    local WindowFunctions = {}

    function WindowFunctions:CreateTab(TabName)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = TabName
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundTransparency = 1
        TabButton.Size = UDim2.new(1, -10, 0, 30)
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.Text = TabName
        TabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabButton.TextSize = 12

        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Name = TabName .. "_Page"
        TabPage.Parent = ContentContainer
        TabPage.Active = true
        TabPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabPage.BackgroundTransparency = 1
        TabPage.BorderSizePixel = 0
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.ScrollBarThickness = 2
        TabPage.ScrollBarImageColor3 = Color3.fromRGB(60, 55, 55)
        TabPage.Visible = false

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Parent = TabPage
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 6)

        local PagePadding = Instance.new("UIPadding")
        PagePadding.Parent = TabPage
        PagePadding.PaddingTop = UDim.new(0, 5)
        PagePadding.PaddingRight = UDim.new(0, 5)

        if FirstTab then
            FirstTab = false
            TabPage.Visible = true
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        end

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentContainer:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            for _, v in pairs(TabContainer:GetChildren()) do
                if v:IsA("TextButton") then v.TextColor3 = Color3.fromRGB(150, 150, 150) end
            end
            TabPage.Visible = true
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        local TabFunctions = {}

        function TabFunctions:CreateSection(SectionName)
            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Parent = TabPage
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Size = UDim2.new(1, 0, 0, 25)
            SectionLabel.Font = Enum.Font.GothamBold
            SectionLabel.Text = SectionName
            SectionLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
            SectionLabel.TextSize = 11
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
        end

        function TabFunctions:CreateButton(BtnName, Callback)
            local ButtonFrame = Instance.new("TextButton")
            ButtonFrame.Parent = TabPage
            ButtonFrame.BackgroundColor3 = Color3.fromRGB(45, 42, 42)
            ButtonFrame.Size = UDim2.new(1, 0, 0, 32)
            ButtonFrame.AutoButtonColor = false
            ButtonFrame.Font = Enum.Font.Gotham
            ButtonFrame.Text = BtnName
            ButtonFrame.TextColor3 = Color3.fromRGB(220, 220, 220)
            ButtonFrame.TextSize = 12
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 4)
            BtnCorner.Parent = ButtonFrame
            
            local BtnStroke = Instance.new("UIStroke")
            BtnStroke.Parent = ButtonFrame
            BtnStroke.Color = Color3.fromRGB(60, 55, 55)
            BtnStroke.Thickness = 1

            ButtonFrame.MouseButton1Click:Connect(function()
                pcall(Callback)
            end)
        end

        function TabFunctions:CreateToggle(ToggleName, Default, Callback)
            local Toggled = Default or false
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Parent = TabPage
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(45, 42, 42)
            ToggleFrame.Size = UDim2.new(1, 0, 0, 32)
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 4)
            ToggleCorner.Parent = ToggleFrame
            
            local ToggleStroke = Instance.new("UIStroke")
            ToggleStroke.Parent = ToggleFrame
            ToggleStroke.Color = Color3.fromRGB(60, 55, 55)
            ToggleStroke.Thickness = 1

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundTransparency = 1
            ToggleButton.Size = UDim2.new(1, 0, 1, 0)
            ToggleButton.Font = Enum.Font.Gotham
            ToggleButton.Text = ToggleName
            ToggleButton.TextColor3 = Color3.fromRGB(220, 220, 220)
            ToggleButton.TextSize = 12
            ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
            
            local TogglePadding = Instance.new("UIPadding")
            TogglePadding.Parent = ToggleButton
            TogglePadding.PaddingLeft = UDim.new(0, 10)
            
            local CheckBox = Instance.new("Frame")
            CheckBox.Parent = ToggleFrame
            CheckBox.BackgroundColor3 = Toggled and Color3.fromRGB(210, 180, 140) or Color3.fromRGB(60, 55, 55)
            CheckBox.Position = UDim2.new(1, -26, 0.5, -8)
            CheckBox.Size = UDim2.new(0, 16, 0, 16)
            
            local CheckCorner = Instance.new("UICorner")
            CheckCorner.CornerRadius = UDim.new(0, 3)
            CheckCorner.Parent = CheckBox

            ToggleButton.MouseButton1Click:Connect(function()
                Toggled = not Toggled
                CheckBox.BackgroundColor3 = Toggled and Color3.fromRGB(210, 180, 140) or Color3.fromRGB(60, 55, 55)
                pcall(Callback, Toggled)
            end)
        end

        function TabFunctions:CreateSlider(SliderName, Min, Max, Default, Callback)
            local Value = Default or Min
            local DraggingSlider = false
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Parent = TabPage
            SliderFrame.BackgroundColor3 = Color3.fromRGB(45, 42, 42)
            SliderFrame.Size = UDim2.new(1, 0, 0, 45)
            
            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 4)
            SliderCorner.Parent = SliderFrame
            
            local SliderStroke = Instance.new("UIStroke")
            SliderStroke.Parent = SliderFrame
            SliderStroke.Color = Color3.fromRGB(60, 55, 55)
            SliderStroke.Thickness = 1
            
            local Label = Instance.new("TextLabel")
            Label.Parent = SliderFrame
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 10, 0, 5)
            Label.Size = UDim2.new(1, -20, 0, 15)
            Label.Font = Enum.Font.Gotham
            Label.Text = SliderName
            Label.TextColor3 = Color3.fromRGB(220, 220, 220)
            Label.TextSize = 12
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Parent = SliderFrame
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Position = UDim2.new(0, 10, 0, 5)
            ValueLabel.Size = UDim2.new(1, -20, 0, 15)
            ValueLabel.Font = Enum.Font.Gotham
            ValueLabel.Text = tostring(Value)
            ValueLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
            ValueLabel.TextSize = 12
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

            local SliderBar = Instance.new("Frame")
            SliderBar.Parent = SliderFrame
            SliderBar.BackgroundColor3 = Color3.fromRGB(60, 55, 55)
            SliderBar.Position = UDim2.new(0, 10, 0, 30)
            SliderBar.Size = UDim2.new(1, -20, 0, 4)
            
            local BarCorner = Instance.new("UICorner")
            BarCorner.CornerRadius = UDim.new(1, 0)
            BarCorner.Parent = SliderBar
            
            local FillBar = Instance.new("Frame")
            FillBar.Parent = SliderBar
            FillBar.BackgroundColor3 = Color3.fromRGB(210, 180, 140)
            FillBar.Size = UDim2.new((Value - Min) / (Max - Min), 0, 1, 0)
            
            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(1, 0)
            FillCorner.Parent = FillBar
            
            local TriggerBtn = Instance.new("TextButton")
            TriggerBtn.Parent = SliderBar
            TriggerBtn.BackgroundTransparency = 1
            TriggerBtn.Size = UDim2.new(1, 0, 1, 0)
            TriggerBtn.Text = ""

            local function UpdateSlider(Input)
                local SizeX = SliderBar.AbsoluteSize.X
                local PosX = SliderBar.AbsolutePosition.X
                local InputX = Input.Position.X
                
                local Percent = math.clamp((InputX - PosX) / SizeX, 0, 1)
                Value = math.floor(Min + ((Max - Min) * Percent))
                
                FillBar.Size = UDim2.new(Percent, 0, 1, 0)
                ValueLabel.Text = tostring(Value)
                pcall(Callback, Value)
            end

            TriggerBtn.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    DraggingSlider = true
                    UpdateSlider(Input)
                end
            end)
            
            UserInputService.InputChanged:Connect(function(Input)
                if DraggingSlider and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
                    UpdateSlider(Input)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    DraggingSlider = false
                end
            end)
        end

        function TabFunctions:CreateInput(InputName, Placeholder, Callback)
            local InputFrame = Instance.new("Frame")
            InputFrame.Parent = TabPage
            InputFrame.BackgroundColor3 = Color3.fromRGB(45, 42, 42)
            InputFrame.Size = UDim2.new(1, 0, 0, 32)
            
            local InputCorner = Instance.new("UICorner")
            InputCorner.CornerRadius = UDim.new(0, 4)
            InputCorner.Parent = InputFrame
            
            local InputStroke = Instance.new("UIStroke")
            InputStroke.Parent = InputFrame
            InputStroke.Color = Color3.fromRGB(60, 55, 55)
            InputStroke.Thickness = 1
            
            local TextBox = Instance.new("TextBox")
            TextBox.Parent = InputFrame
            TextBox.BackgroundTransparency = 1
            TextBox.Position = UDim2.new(0, 10, 0, 0)
            TextBox.Size = UDim2.new(1, -20, 1, 0)
            TextBox.Font = Enum.Font.Gotham
            TextBox.Text = ""
            TextBox.PlaceholderText = Placeholder or InputName
            TextBox.TextColor3 = Color3.fromRGB(220, 220, 220)
            TextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            TextBox.TextSize = 12
            TextBox.TextXAlignment = Enum.TextXAlignment.Left
            
            TextBox.FocusLost:Connect(function(EnterPressed)
                if EnterPressed then
                    pcall(Callback, TextBox.Text)
                end
            end)
        end

        return TabFunctions
    end

    return WindowFunctions
end

return Library
