--[[
RobHub V2 Complete
==================
Created by: ban_thid
Version: 2.0
Date: 2024

使い方:
1. このコード全体をコピーする
2. Roblox Executorで実行する
3. GUIが表示されます！

注意:
- 教育目的のみに使用してください
- 他のプレイヤーに迷惑をかけないでください
]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- サーバー通信の準備
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local serverConnection = false
local serverEvents = {}

-- サーバーイベントを作成（存在しない場合）
pcall(function()
    -- サーバーイベントがなければ作る
    if not ReplicatedStorage:FindFirstChild("RobHub_Message") then
        local event = Instance.new("RemoteEvent")
        event.Name = "RobHub_Message"
        event.Parent = ReplicatedStorage
    end
    
    serverEvents.Message = ReplicatedStorage:WaitForChild("RobHub_Message")
    serverConnection = true
end)

-- GUI作成
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RobHubV2"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

-- イントロ画面
local introFrame = Instance.new("Frame")
introFrame.Size = UDim2.new(1, 0, 1, 0)
introFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
introFrame.BorderSizePixel = 0
introFrame.Parent = screenGui

local introTitle = Instance.new("TextLabel")
introTitle.Size = UDim2.new(0, 400, 0, 100)
introTitle.Position = UDim2.new(0.5, -200, 0.5, -50)
introTitle.BackgroundTransparency = 1
introTitle.Text = "RobHub"
introTitle.Font = Enum.Font.GothamBlack
introTitle.TextSize = 70
introTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
introTitle.TextTransparency = 1
introTitle.Parent = introFrame

local introSubtitle = Instance.new("TextLabel")
introSubtitle.Size = UDim2.new(0, 300, 0, 40)
introSubtitle.Position = UDim2.new(0.5, -150, 0.5, 60)
introSubtitle.BackgroundTransparency = 1
introSubtitle.Text = "Made by ban_thid"
introSubtitle.Font = Enum.Font.Gotham
introSubtitle.TextSize = 24
introSubtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
introSubtitle.TextTransparency = 1
introSubtitle.Parent = introFrame

-- イントロアニメーション
local fadeIn = TweenService:Create(introTitle, TweenInfo.new(1.2, Enum.EasingStyle.Quint), {TextTransparency = 0})
local fadeInSub = TweenService:Create(introSubtitle, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In, 0.5), {TextTransparency = 0})
local scaleUp = TweenService:Create(introTitle, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = 80})
local fadeOut = TweenService:Create(introFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 1})

fadeIn:Play()
fadeInSub:Play()
fadeIn.Completed:Wait()
scaleUp:Play()
scaleUp.Completed:Wait()
task.wait(0.5)
fadeOut:Play()
fadeOut.Completed:Wait()
introFrame:Destroy()

-- メインGUI
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 700, 0, 360)
mainFrame.Position = UDim2.new(0.5, -350, 0.5, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Visible = true
mainFrame.Parent = screenGui
local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 44)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.Text = "RobHub V2"
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = mainFrame
local titleCorner = Instance.new("UICorner", title)
titleCorner.CornerRadius = UDim.new(0, 8)

local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 44, 1, 0)
closeBtn.Position = UDim2.new(1, -44, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.Parent = title
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0, 6)

local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 20, 1, -70)
openBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
openBtn.Text = "Hub"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 18
openBtn.Visible = false
openBtn.Parent = screenGui
local openCorner = Instance.new("UICorner", openBtn)
openCorner.CornerRadius = UDim.new(1, 0)

-- ボタンホバー効果
openBtn.MouseEnter:Connect(function() openBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) end)
openBtn.MouseLeave:Connect(function() openBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) end)
closeBtn.MouseEnter:Connect(function() closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50) end)
closeBtn.MouseLeave:Connect(function() closeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45) end)

-- ボタン機能
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	openBtn.Visible = false
end)

-- タブシステム
local tabs = {"Executor", "Scripts", "Server", "Settings"}
local tabButtons = {}

for i, name in ipairs(tabs) do
	local tab = Instance.new("TextButton")
	tab.Size = UDim2.new(0, 120, 0, 30)
	tab.Position = UDim2.new(0.05 + (i-1) * 0.22, 0, 0, 50)
	tab.Text = name
	tab.BackgroundColor3 = (i == 1) and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(45, 45, 45)
	tab.TextColor3 = Color3.fromRGB(255, 255, 255)
	tab.Font = Enum.Font.Gotham
	tab.TextSize = 14
	tab.Parent = mainFrame
	local tabCorner = Instance.new("UICorner", tab)
	tabCorner.CornerRadius = UDim.new(0, 6)
	tabButtons[i] = tab
end

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(0.98, 0, 0.74, 0)
contentFrame.Position = UDim2.new(0.01, 0, 0.25, 0)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Executorタブ
local executorContainer = Instance.new("Frame")
executorContainer.Size = UDim2.new(1, 0, 1, 0)
executorContainer.BackgroundTransparency = 1
executorContainer.Parent = contentFrame
executorContainer.Visible = true

local leftArea = Instance.new("Frame")
leftArea.Size = UDim2.new(0.68, -10, 1, 0)
leftArea.Position = UDim2.new(0, 0, 0, 0)
leftArea.BackgroundTransparency = 1
leftArea.Parent = executorContainer

local leftBG = Instance.new("Frame")
leftBG.Size = UDim2.new(1, 0, 1, 0)
leftBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
leftBG.Parent = leftArea
local leftCorner = Instance.new("UICorner", leftBG)
leftCorner.CornerRadius = UDim.new(0, 6)

local scriptScroll = Instance.new("ScrollingFrame")
scriptScroll.Size = UDim2.new(1, -10, 1, -50)
scriptScroll.Position = UDim2.new(0, 5, 0, 5)
scriptScroll.BackgroundTransparency = 1
scriptScroll.ScrollBarThickness = 6
scriptScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scriptScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scriptScroll.Parent = leftBG

local executorBox = Instance.new("TextBox")
executorBox.Size = UDim2.new(1, 0, 0, 180)
executorBox.Position = UDim2.new(0, 0, 0, 0)
executorBox.MultiLine = true
executorBox.ClearTextOnFocus = false
executorBox.PlaceholderText = "-- スクリプトを貼り付けてください"
executorBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
executorBox.Text = ""
executorBox.TextColor3 = Color3.fromRGB(255, 255, 255)
executorBox.TextXAlignment = Enum.TextXAlignment.Left
executorBox.TextYAlignment = Enum.TextYAlignment.Top
executorBox.BackgroundTransparency = 1
executorBox.Font = Enum.Font.Code
executorBox.TextSize = 14
executorBox.Parent = scriptScroll

executorBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
	local y = executorBox.TextBounds.Y + 16
	if y < 180 then y = 180 end
	executorBox.Size = UDim2.new(1, 0, 0, y)
	scriptScroll.CanvasSize = UDim2.new(0, 0, 0, y + 6)
end)

local executeBtn = Instance.new("TextButton")
executeBtn.Text = "▶ 実行"
executeBtn.Size = UDim2.new(0, 110, 0, 36)
executeBtn.Position = UDim2.new(0.15, 0, 0.86, 0)
executeBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
executeBtn.TextColor3 = Color3.fromRGB(250, 250, 250)
executeBtn.Font = Enum.Font.GothamBold
executeBtn.TextSize = 16
executeBtn.Parent = executorContainer
local execCorner = Instance.new("UICorner", executeBtn)
execCorner.CornerRadius = UDim.new(0,6)

local clearBtn = Instance.new("TextButton")
clearBtn.Text = "🗑️ 消去"
clearBtn.Size = UDim2.new(0, 110, 0, 36)
clearBtn.Position = UDim2.new(0.45, 0, 0.86, 0)
clearBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
clearBtn.TextColor3 = Color3.fromRGB(250,250,250)
clearBtn.Font = Enum.Font.GothamBold
clearBtn.TextSize = 16
clearBtn.Parent = executorContainer
local clearCorner = Instance.new("UICorner", clearBtn)
clearCorner.CornerRadius = UDim.new(0,6)

clearBtn.MouseButton1Click:Connect(function()
	executorBox.Text = ""
end)

executeBtn.MouseButton1Click:Connect(function()
	local code = executorBox.Text
	if code and code ~= "" then
		-- サーバーに実行ログを送信
		if serverConnection then
			serverEvents.Message:FireServer("SCRIPT_EXECUTED", {
				player = player.Name,
				length = #code,
				time = os.time()
			})
		end
		
		-- スクリプトを実行
		local func, err = loadstring(code)
		if func then
			local ok, e = pcall(func)
			if not ok then
				warn("実行エラー: "..tostring(e))
			else
				print("スクリプトが正常に実行されました")
			end
		else
			warn("読み込みエラー: "..tostring(err))
		end
	end
end)

local rightPanel = Instance.new("Frame")
rightPanel.Size = UDim2.new(0.30, 0, 1, 0)
rightPanel.Position = UDim2.new(0.69, 0, 0, 0)
rightPanel.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
rightPanel.Parent = executorContainer
local rightCorner = Instance.new("UICorner", rightPanel)
rightCorner.CornerRadius = UDim.new(0,6)

local rightTitle = Instance.new("TextLabel")
rightTitle.Size = UDim2.new(1, 0, 0, 32)
rightTitle.Position = UDim2.new(0, 0, 0, 6)
rightTitle.BackgroundTransparency = 1
rightTitle.Text = "スクリプト一覧"
rightTitle.Font = Enum.Font.GothamBold
rightTitle.TextSize = 16
rightTitle.TextColor3 = Color3.fromRGB(255,255,255)
rightTitle.Parent = rightPanel

local scriptsScroll = Instance.new("ScrollingFrame")
scriptsScroll.Size = UDim2.new(1, -10, 1, -48)
scriptsScroll.Position = UDim2.new(0, 5, 0, 40)
scriptsScroll.BackgroundTransparency = 1
scriptsScroll.ScrollBarThickness = 6
scriptsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scriptsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scriptsScroll.Parent = rightPanel

-- スクリプトライブラリ
local Scripts = {
	{"無限収穫", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()'},
	{"飛行スクリプト", 'local plr = game.Players.LocalPlayer\nlocal mouse = plr:GetMouse()\nlocal flying = true\nlocal speed = 50\nmouse.KeyDown:connect(function(key)\n    if key == "e" then\n        flying = not flying\n    end\nend)\ngame:GetService("RunService").RenderStepped:connect(function()\n    if flying then\n        local char = plr.Character\n        if char then\n            char.HumanoidRootPart.Velocity = Vector3.new(0,0,0)\n            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + (mouse.Hit.lookVector * speed)\n        end\n    end\nend)'},
	{"スピードハック", 'game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100'},
	{"ジャンプパワー", 'game.Players.LocalPlayer.Character.Humanoid.JumpPower = 200'},
	{"ノックバック無効", 'game.Players.LocalPlayer.Character.Humanoid.AutoRotate = false'},
	{"透明化", 'game.Players.LocalPlayer.Character.Head.Transparency = 1\nfor _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do\n    if v:IsA("BasePart") then\n        v.Transparency = 0.5\n    end\nend'},
	{"昼/夜切り替え", 'if game.Lighting.ClockTime > 12 then\n    game.Lighting.ClockTime = 6\nelse\n    game.Lighting.ClockTime = 18\nend'},
	{"重力変更", 'workspace.Gravity = 50'},
}

local yOff = 0
for _, entry in ipairs(Scripts) do
	local name, code = entry[1], entry[2]
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 28)
	btn.Position = UDim2.new(0, 5, 0, yOff)
	btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 12
	btn.Text = name
	btn.AutoButtonColor = true
	btn.Parent = scriptsScroll
	local bCorner = Instance.new("UICorner", btn)
	bCorner.CornerRadius = UDim.new(0,4)
	
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	end)
	
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	end)
	
	btn.MouseButton1Click:Connect(function()
		executorBox.Text = code
		print("スクリプトを読み込み: " .. name)
	end)
	
	yOff = yOff + 34
end
scriptsScroll.CanvasSize = UDim2.new(0, 0, 0, yOff + 6)

-- Scriptsタブ（元のRobScripts）
local scriptsContainer = Instance.new("Frame")
scriptsContainer.Size = UDim2.new(1, 0, 1, 0)
scriptsContainer.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
scriptsContainer.Parent = contentFrame
scriptsContainer.Visible = false
local scriptsCorner = Instance.new("UICorner", scriptsContainer)
scriptsCorner.CornerRadius = UDim.new(0, 6)

local scriptsTitle = Instance.new("TextLabel")
scriptsTitle.Size = UDim2.new(1, 0, 0, 32)
scriptsTitle.Position = UDim2.new(0, 0, 0, 6)
scriptsTitle.BackgroundTransparency = 1
scriptsTitle.Text = "詳細スクリプト"
scriptsTitle.Font = Enum.Font.GothamBold
scriptsTitle.TextSize = 16
scriptsTitle.TextColor3 = Color3.fromRGB(255,255,255)
scriptsTitle.Parent = scriptsContainer

local scriptsListScroll = Instance.new("ScrollingFrame")
scriptsListScroll.Size = UDim2.new(1, -10, 1, -48)
scriptsListScroll.Position = UDim2.new(0, 5, 0, 40)
scriptsListScroll.BackgroundTransparency = 1
scriptsListScroll.ScrollBarThickness = 6
scriptsListScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scriptsListScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scriptsListScroll.Parent = scriptsContainer

local MoreScripts = {
	{"キーボード表示", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt"))()'},
	{"リモートスパイ", 'loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()'},
	{"デバッグツール", 'loadstring(game:HttpGet("https://scriptblox.com/raw/Universal-Script-Keyless-mobile-dex-17888"))()'},
	{"FPSブースター", 'settings().Rendering.QualityLevel = 1\ngame:GetService("Lighting").GlobalShadows = false'},
	{"画面録画", 'print("録画機能は現在実装中です")'},
}

local syOff = 0
for _, entry in ipairs(MoreScripts) do
	local name, code = entry[1], entry[2]
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 28)
	btn.Position = UDim2.new(0, 5, 0, syOff)
	btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 12
	btn.Text = name
	btn.AutoButtonColor = true
	btn.Parent = scriptsListScroll
	local bCorner = Instance.new("UICorner", btn)
	bCorner.CornerRadius = UDim.new(0,4)
	
	btn.MouseButton1Click:Connect(function()
		local func, err = loadstring(code)
		if func then
			local ok, e = pcall(func)
			if not ok then
				warn("実行エラー: "..tostring(e))
			else
				print("スクリプトが正常に実行されました: " .. name)
			end
		else
			warn("読み込みエラー: "..tostring(err))
		end
	end)
	
	syOff = syOff + 34
end
scriptsListScroll.CanvasSize = UDim2.new(0, 0, 0, syOff + 6)

-- Serverタブ
local serverContainer = Instance.new("Frame")
serverContainer.Size = UDim2.new(1, 0, 1, 0)
serverContainer.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
serverContainer.Parent = contentFrame
serverContainer.Visible = false
local serverCorner = Instance.new("UICorner", serverContainer)
serverCorner.CornerRadius = UDim.new(0, 6)

local serverTitle = Instance.new("TextLabel")
serverTitle.Size = UDim2.new(1, 0, 0, 32)
serverTitle.Position = UDim2.new(0, 0, 0, 6)
serverTitle.BackgroundTransparency = 1
serverTitle.Text = "サーバー通信"
serverTitle.Font = Enum.Font.GothamBold
serverTitle.TextSize = 16
serverTitle.TextColor3 = Color3.fromRGB(255,255,255)
serverTitle.Parent = serverContainer

local serverScroll = Instance.new("ScrollingFrame")
serverScroll.Size = UDim2.new(1, -20, 1, -48)
serverScroll.Position = UDim2.new(0, 10, 0, 40)
serverScroll.BackgroundTransparency = 1
serverScroll.ScrollBarThickness = 6
serverScroll.CanvasSize = UDim2.new(0, 0, 0, 300)
serverScroll.Parent = serverContainer

-- サーバー情報表示
local statusPanel = Instance.new("Frame")
statusPanel.Size = UDim2.new(1, 0, 0, 80)
statusPanel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
statusPanel.Parent = serverScroll
local statusPanelCorner = Instance.new("UICorner", statusPanel)
statusPanelCorner.CornerRadius = UDim.new(0, 6)

local statusLight = Instance.new("Frame")
statusLight.Size = UDim2.new(0, 20, 0, 20)
statusLight.Position = UDim2.new(0.05, 0, 0.3, 0)
statusLight.BackgroundColor3 = serverConnection and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
statusLight.Parent = statusPanel
local statusLightCorner = Instance.new("UICorner", statusLight)
statusLightCorner.CornerRadius = UDim.new(1, 0)

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(0.7, 0, 0, 40)
statusText.Position = UDim2.new(0.15, 0, 0.2, 0)
statusText.BackgroundTransparency = 1
statusText.Text = serverConnection and "サーバー接続: オンライン" or "サーバー接続: オフライン"
statusText.TextColor3 = Color3.fromRGB(200, 200, 200)
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Font = Enum.Font.Gotham
statusText.TextSize = 14
statusText.Parent = statusPanel

-- チャット送信
local chatPanel = Instance.new("Frame")
chatPanel.Size = UDim2.new(1, 0, 0, 120)
chatPanel.Position = UDim2.new(0, 0, 0, 90)
chatPanel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
chatPanel.Parent = serverScroll
local chatPanelCorner = Instance.new("UICorner", chatPanel)
chatPanelCorner.CornerRadius = UDim.new(0, 6)

local chatLabel = Instance.new("TextLabel")
chatLabel.Size = UDim2.new(1, 0, 0, 30)
chatLabel.Position = UDim2.new(0, 0, 0, 0)
chatLabel.BackgroundTransparency = 1
chatLabel.Text = "サーバーにメッセージ送信"
chatLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
chatLabel.Font = Enum.Font.Gotham
chatLabel.TextSize = 14
chatLabel.Parent = chatPanel

local chatInput = Instance.new("TextBox")
chatInput.Size = UDim2.new(0.8, 0, 0, 30)
chatInput.Position = UDim2.new(0.05, 0, 0.4, 0)
chatInput.PlaceholderText = "メッセージを入力..."
chatInput.Text = ""
chatInput.Font = Enum.Font.Gotham
chatInput.TextSize = 12
chatInput.Parent = chatPanel

local sendChatBtn = Instance.new("TextButton")
sendChatBtn.Size = UDim2.new(0.8, 0, 0, 30)
sendChatBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
sendChatBtn.Text = "送信"
sendChatBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
sendChatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
sendChatBtn.Font = Enum.Font.GothamBold
sendChatBtn.TextSize = 14
sendChatBtn.Parent = chatPanel
local sendChatCorner = Instance.new("UICorner", sendChatBtn)
sendChatCorner.CornerRadius = UDim.new(0, 6)

sendChatBtn.MouseButton1Click:Connect(function()
	local message = chatInput.Text
	if message ~= "" and serverConnection then
		serverEvents.Message:FireServer("CHAT_MESSAGE", {
			player = player.Name,
			message = message,
			time = os.time()
		})
		chatInput.Text = ""
		print("メッセージを送信しました: " .. message)
	else
		print("サーバーに接続されていません")
	end
end)

-- Settingsタブ
local settingsContainer = Instance.new("Frame")
settingsContainer.Size = UDim2.new(1, 0, 1, 0)
settingsContainer.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
settingsContainer.Parent = contentFrame
settingsContainer.Visible = false
local settingsCorner = Instance.new("UICorner", settingsContainer)
settingsCorner.CornerRadius = UDim.new(0, 6)

local settingsTitle = Instance.new("TextLabel")
settingsTitle.Size = UDim2.new(1, 0, 0, 32)
settingsTitle.Position = UDim2.new(0, 0, 0, 6)
settingsTitle.BackgroundTransparency = 1
settingsTitle.Text = "設定"
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.TextSize = 16
settingsTitle.TextColor3 = Color3.fromRGB(255,255,255)
settingsTitle.Parent = settingsContainer

local settingsScroll = Instance.new("ScrollingFrame")
settingsScroll.Size = UDim2.new(1, -20, 1, -48)
settingsScroll.Position = UDim2.new(0, 10, 0, 40)
settingsScroll.BackgroundTransparency = 1
settingsScroll.ScrollBarThickness = 6
settingsScroll.CanvasSize = UDim2.new(0, 0, 0, 400)
settingsScroll.Parent = settingsContainer

-- テーマ設定
local themePanel = Instance.new("Frame")
themePanel.Size = UDim2.new(1, 0, 0, 100)
themePanel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
themePanel.Parent = settingsScroll
local themePanelCorner = Instance.new("UICorner", themePanel)
themePanelCorner.CornerRadius = UDim.new(0, 6)

local themeLabel = Instance.new("TextLabel")
themeLabel.Size = UDim2.new(1, 0, 0, 30)
themeLabel.Position = UDim2.new(0, 0, 0, 0)
themeLabel.BackgroundTransparency = 1
themeLabel.Text = "テーマ設定"
themeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
themeLabel.Font = Enum.Font.Gotham
themeLabel.TextSize = 14
themeLabel.Parent = themePanel

local darkThemeBtn = Instance.new("TextButton")
darkThemeBtn.Size = UDim2.new(0.4, 0, 0, 30)
darkThemeBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
darkThemeBtn.Text = "ダークモード"
darkThemeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
darkThemeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
darkThemeBtn.Font = Enum.Font.Gotham
darkThemeBtn.TextSize = 12
darkThemeBtn.Parent = themePanel

local lightThemeBtn = Instance.new("TextButton")
lightThemeBtn.Size = UDim2.new(0.4, 0, 0, 30)
lightThemeBtn.Position = UDim2.new(0.55, 0, 0.4, 0)
lightThemeBtn.Text = "ライトモード"
lightThemeBtn.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
lightThemeBtn.TextColor3 = Color3.fromRGB(30, 30, 30)
lightThemeBtn.Font = Enum.Font.Gotham
lightThemeBtn.TextSize = 12
lightThemeBtn.Parent = themePanel

darkThemeBtn.MouseButton1Click:Connect(function()
	mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	print("ダークモードに変更しました")
end)

lightThemeBtn.MouseButton1Click:Connect(function()
	mainFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
	title.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
	title.TextColor3 = Color3.fromRGB(30, 30, 30)
	print("ライトモードに変更しました")
end)

-- その他設定
local otherPanel = Instance.new("Frame")
otherPanel.Size = UDim2.new(1, 0, 0, 150)
otherPanel.Position = UDim2.new(0, 0, 0, 110)
otherPanel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
otherPanel.Parent = settingsScroll
local otherPanelCorner = Instance.new("UICorner", otherPanel)
otherPanelCorner.CornerRadius = UDim.new(0, 6)

local otherLabel = Instance.new("TextLabel")
otherLabel.Size = UDim2.new(1, 0, 0, 30)
otherLabel.Position = UDim2.new(0, 0, 0, 0)
otherLabel.BackgroundTransparency = 1
otherLabel.Text = "その他設定"
otherLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
otherLabel.Font = Enum.Font.Gotham
otherLabel.TextSize = 14
otherLabel.Parent = otherPanel

-- 自動更新チェック
local autoUpdateCheck = Instance.new("TextButton")
autoUpdateCheck.Size = UDim2.new(0.9, 0, 0, 30)
autoUpdateCheck.Position = UDim2.new(0.05, 0, 0.3, 0)
autoUpdateCheck.Text = "📡 自動更新チェック: ON"
autoUpdateCheck.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
autoUpdateCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
autoUpdateCheck.Font = Enum.Font.Gotham
autoUpdateCheck.TextSize = 12
autoUpdateCheck.Parent = otherPanel
local updateCorner = Instance.new("UICorner", autoUpdateCheck)
updateCorner.CornerRadius = UDim.new(0, 6)

local autoUpdate = true
autoUpdateCheck.MouseButton1Click:Connect(function()
	autoUpdate = not autoUpdate
	if autoUpdate then
		autoUpdateCheck.Text = "📡 自動更新チェック: ON"
		autoUpdateCheck.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	else
		autoUpdateCheck.Text = "📡 自動更新チェック: OFF"
		autoUpdateCheck.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
	end
end)

-- 効果音設定
local soundCheck = Instance.new("TextButton")
soundCheck.Size = UDim2.new(0.9, 0, 0, 30)
soundCheck.Position = UDim2.new(0.05, 0, 0.6, 0)
soundCheck.Text = "🔊 効果音: ON"
soundCheck.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
soundCheck.TextColor3 = Color3.fromRGB(255, 255, 255)
soundCheck.Font = Enum.Font.Gotham
soundCheck.TextSize = 12
soundCheck.Parent = otherPanel
local soundCorner = Instance.new("UICorner", soundCheck)
soundCorner.CornerRadius = UDim.new(0, 6)

local soundEnabled = true
soundCheck.MouseButton1Click:Connect(function()
	soundEnabled = not soundEnabled
	if soundEnabled then
		soundCheck.Text = "🔊 効果音: ON"
		soundCheck.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	else
		soundCheck.Text = "🔊 効果音: OFF"
		soundCheck.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
	end
end)

-- タブ切り替え機能
local function showTab(index)
	executorContainer.Visible = (index == 1)
	scriptsContainer.Visible = (index == 2)
	serverContainer.Visible = (index == 3)
	settingsContainer.Visible = (index == 4)
	
	for i, btn in ipairs(tabButtons) do
		btn.BackgroundColor3 = (i == index) and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(45, 45, 45)
	end
end

for i, btn in ipairs(tabButtons) do
	btn.MouseButton1Click:Connect(function()
		showTab(i)
	end)
end

showTab(1)

-- ドラッグ機能
local dragging, dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and mainFrame.Visible then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

mainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- サーバーからのメッセージ受信
if serverConnection then
	serverEvents.Message.OnClientEvent:Connect(function(messageType, data)
		if messageType == "CHAT_BROADCAST" then
			print("[サーバー] " .. data.player .. ": " .. data.message)
		elseif messageType == "SYSTEM_MESSAGE" then
			print("[システム] " .. data.message)
		end
	end)
end

-- キーボードショートカット
UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.RightControl then
		mainFrame.Visible = not mainFrame.Visible
		openBtn.Visible = not mainFrame.Visible
	end
end)

print("RobHub V2 が正常に読み込まれました！")
print("右CtrlキーでGUIを表示/非表示")