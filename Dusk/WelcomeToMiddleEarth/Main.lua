import "Turbine"
import "Turbine.UI"
import "Turbine.UI.Lotro"
import "Turbine.Gameplay"
import "Thardariel.WelcomeToMiddleEarth.Progression"
import "Thardariel.WelcomeToMiddleEarth.Strings"

local model = Thardariel.WelcomeToMiddleEarth.Progression
local translations = Thardariel.WelcomeToMiddleEarth.Strings
local language = Turbine.Engine.GetLanguage()
local locale = language == Turbine.Language.French and "fr" or
    (language == Turbine.Language.German and "de" or "en")
local text = translations[locale]
local player = Turbine.Gameplay.LocalPlayer.GetInstance()
local mainWindow
local levelWindow
local sceneWindows = {}
local bindings = {}
local settingsKey = "WelcomeToMiddleEarth"
local ok, saved = pcall(Turbine.PluginData.Load, Turbine.DataScope.Character, settingsKey)
local settings = ok and type(saved) == "table" and saved or {}
for _, key in ipairs({"auto", "scenes", "traits"}) do
    if type(settings[key]) ~= "boolean" then settings[key] = true end
end
local saveFailureReported = false
local function save()
    local saveOk = pcall(Turbine.PluginData.Save, Turbine.DataScope.Character, settingsKey, settings)
    if not saveOk and not saveFailureReported then
        saveFailureReported = true
        pcall(Turbine.Shell.WriteLine, text.saveFailed or "WelcomeToMiddleEarth: unable to save settings for this character.")
    end
    return saveOk
end

-- LocalPlayer:GetName() has historically caused the original level-up popup to
-- abort on some clients/classes when the method was unexpectedly unavailable.
-- Keep the player's real name when LOTRO exposes it, but never let a cosmetic
-- greeting prevent the rest of the window from opening.
local function safePlayerName()
    local nameOk, name = pcall(function() return player:GetName() end)
    if nameOk and type(name) == "string" and name ~= "" then return name end
    return text.playerFallback or "Adventurer"
end
local function bind(object, event, callback)
    model.AddCallback(object, event, callback)
    bindings[#bindings+1] = {object, event, callback}
end
local function closeScenes()
    for _, window in ipairs(sceneWindows) do window:SetVisible(false) end
    sceneWindows = {}
end
local function position(window, x, y)
    local width, height = Turbine.UI.Display:GetWidth(), Turbine.UI.Display:GetHeight()
    local function finite(n) return type(n) == "number" and n == n and math.abs(n) < math.huge end
    if not finite(x) then x = (width-window:GetWidth())/2 end
    if not finite(y) then y = (height-window:GetHeight())/4 end
    window:SetPosition(math.floor(math.max(0,math.min(x,width-window:GetWidth()))),
        math.floor(math.max(0,math.min(y,height-window:GetHeight()))))
end
local function visibleReturnWindow()
    if levelWindow and levelWindow:IsVisible() then return levelWindow end
    if mainWindow and mainWindow:IsVisible() then return mainWindow end
    return nil
end
function MainFunction_Moria()
		
		
		local file_path_moria = "Thardariel/WelcomeToMiddleEarth/images/MinesOfMoria.jpg";
			
		local mainWindow_Moria = Turbine.UI.Lotro.GoldWindow()
        sceneWindows[#sceneWindows+1] = mainWindow_Moria
		mainWindow_Moria:SetSize(600,396);
		position(mainWindow_Moria)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_Moria:SetText("The mines of Moria!");
		elseif l == Turbine.Language.German then
			mainWindow_Moria:SetText("Die Minen von Moria!");
		elseif l == Turbine.Language.French then
			mainWindow_Moria:SetText("Les mines de la Moria!");
		end
		mainWindow_Moria.Image=Turbine.UI.Label(); 
		mainWindow_Moria.Image:SetParent(mainWindow_Moria);
		mainWindow_Moria.Image:SetSize(550,229);
		mainWindow_Moria.Image:SetPosition(25, 140)
		mainWindow_Moria.Image:SetBackground(file_path_moria);
		mainWindow_Moria.Message=Turbine.UI.Label(); 
		mainWindow_Moria.Message:SetParent(mainWindow_Moria);
		mainWindow_Moria.Message:SetSize(550,229);
		mainWindow_Moria.Message:SetFont(Turbine.UI.Lotro.Font.TrajanPro14)
		mainWindow_Moria.Message:SetPosition(25, 50)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_Moria.Message:SetText("Moria. You are afraid of these mines. The dwarves have mined too greedily and too deeply. You know what they have awakened in the darkness of Kazad-dûm: shadows and flames. ~ Saruman\n\nMeet Ráthwald in Echad Dúnann (Eregion) to take the path into the mines of Moria!")
		elseif l == Turbine.Language.German then
			mainWindow_Moria.Message:SetText("Moria. Du fürchtest dich vor diesen Minen. Die Zwerge haben zu gierig und zu tief geschürft. Du weißt, was sie aufgeweckt haben in der Dunkelheit von Kazad-dûm: Schatten und Flammen. ~ Saruman\n\nTreffe Ráthwald in Echad Dúnann (Eregion) um den Pfad in die Minen von Moria zu bestreiten!")
		elseif l == Turbine.Language.French then
			mainWindow_Moria.Message:SetText("La Moria. Tu as peur de ces mines. Les nains ont creusé trop avidement et trop profondément. Tu sais ce qu'ils ont réveillé dans les ténèbres de Kazad-dûm : des ombres et des flammes. ~ Saruman\n\nRencontre Ráthwald à Echad Dúnann (Eregion) pour prendre le chemin des mines de la Moria !")
		end
		mainWindow_Moria.Message:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter)

		mainWindow_Moria:SetVisible(true)
		
		local returnWindow = visibleReturnWindow()
		if returnWindow then returnWindow:SetVisible(false) end
		function mainWindow_Moria:Closed(sender, args)
			if returnWindow then returnWindow:SetVisible(true) end
		end
	
end

function MainFunction_Bree()
		
		
		local file_path_bree = "Thardariel/WelcomeToMiddleEarth/images/Bree.jpg";
			
		local mainWindow_Bree = Turbine.UI.Lotro.GoldWindow()
        sceneWindows[#sceneWindows+1] = mainWindow_Bree
		mainWindow_Bree:SetSize(600,396);
		position(mainWindow_Bree)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_Bree:SetText("The prancing pony!")
		elseif l == Turbine.Language.German then
			mainWindow_Bree:SetText("Gasthaus zum tänzelnden Pony!")
		elseif l == Turbine.Language.French then
			mainWindow_Bree:SetText("Auberge du poney dansant!")
		end
		mainWindow_Bree.Image=Turbine.UI.Label(); 
		mainWindow_Bree.Image:SetParent(mainWindow_Bree);
		mainWindow_Bree.Image:SetSize(550,218);
		mainWindow_Bree.Image:SetPosition(25, 140)
		mainWindow_Bree.Image:SetBackground(file_path_bree);
		mainWindow_Bree.Message=Turbine.UI.Label(); 
		mainWindow_Bree.Message:SetParent(mainWindow_Bree);
		mainWindow_Bree.Message:SetSize(550,229);
		mainWindow_Bree.Message:SetPosition(25, 50)
		mainWindow_Bree.Message:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_Bree.Message:SetText("You are drawing far too much attention to yourself, Mr. Unterberg! ~ Your path takes you to the Breeland. Meet Barliman Butterbur at the Prancing Pony Inn.")
		elseif l == Turbine.Language.German then
			mainWindow_Bree.Message:SetText("Ihr zieht bei weitem zu viel Aufmerksamkeit auf Euch, Herr Unterberg! ~ Grand-Pas\n\nEuer Weg verschlägt euch ins Breeland. Trefft Gerstenmann Butterblume im Gasthaus zum tänzelnden Pony.")
		elseif l == Turbine.Language.French then
			mainWindow_Bree.Message:SetText("Vous attirez beaucoup trop l'attention sur vous, Monsieur Unterberg ! ~ Grand-Pas\n\nVotre chemin vous mènera dans le Breeland. Rencontrez Bouton d'orge à l'auberge du Poney dansant.")
		end
		mainWindow_Bree.Message:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter)

		mainWindow_Bree:SetVisible(true)
		
		local returnWindow = visibleReturnWindow()
		if returnWindow then returnWindow:SetVisible(false) end
		function mainWindow_Bree:Closed(sender, args)
			if returnWindow then returnWindow:SetVisible(true) end
		end
	
end

function MainFunction_EinsameLande()
		
		
		local file_path_einsamelande = "Thardariel/WelcomeToMiddleEarth/images/Wetterspitze.jpg";
			
		local mainWindow_EinsameLande = Turbine.UI.Lotro.GoldWindow()
        sceneWindows[#sceneWindows+1] = mainWindow_EinsameLande
		mainWindow_EinsameLande:SetSize(600,396);
		position(mainWindow_EinsameLande)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_EinsameLande:SetText("The weather top!")
		elseif l == Turbine.Language.German then
			mainWindow_EinsameLande:SetText("Die Wetterspitze!")
		elseif l == Turbine.Language.French then
			mainWindow_EinsameLande:SetText("La pointe météo!")
		end
		mainWindow_EinsameLande.Image=Turbine.UI.Label(); 
		mainWindow_EinsameLande.Image:SetParent(mainWindow_EinsameLande);
		mainWindow_EinsameLande.Image:SetSize(550,218);
		mainWindow_EinsameLande.Image:SetPosition(25, 140)
		mainWindow_EinsameLande.Image:SetBackground(file_path_einsamelande);
		mainWindow_EinsameLande.Message=Turbine.UI.Label(); 
		mainWindow_EinsameLande.Message:SetParent(mainWindow_EinsameLande);
		mainWindow_EinsameLande.Message:SetSize(550,229);
		mainWindow_EinsameLande.Message:SetPosition(25, 50)
		mainWindow_EinsameLande.Message:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_EinsameLande.Message:SetText("The Witch-King has wounded Frodo on Weathertop with a Morgul Blade, but Strider was able to drive the Nazgûl away. All is not well with him, he must join Lord Elrond in Rivendell. Quickly!\n\nSpeak with Candaith on the slope of the weathertop.")
		elseif l == Turbine.Language.German then
			mainWindow_EinsameLande.Message:SetText("Der Hexenkönig hat Frodo auf der Wetterspitze mit einer Morgulklinge verwundet, doch Grand-Pas konnte die Nazgûl vertreiben. Es steht nicht gut um ihn, er muss zu Herrn Elrond nach Bruchtall. Schnell!\n\nSprecht mit Candaith am Hang der Wetterspitze.")
		elseif l == Turbine.Language.French then
			mainWindow_EinsameLande.Message:SetText("Le Roi-Sorcier a blessé Frodon avec une lame de Morgul sur le Mont Venteux, mais Grand-Pas a réussi à repousser les Nazgûl. Les choses ne vont pas bien pour lui, il doit rejoindre le Seigneur Elrond à Fondcombe. Vite!\nParle avec Candaith sur le versant du Mont Venteux.")
		end	
		mainWindow_EinsameLande.Message:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter)

		mainWindow_EinsameLande:SetVisible(true)
		
		local returnWindow = visibleReturnWindow()
		if returnWindow then returnWindow:SetVisible(false) end
		function mainWindow_EinsameLande:Closed(sender, args)
			if returnWindow then returnWindow:SetVisible(true) end
		end
	
end

function MainFunction_Bruchtal()
		
		
		local file_path_bruchtal = "Thardariel/WelcomeToMiddleEarth/images/Bruchtal.jpg";
			
		local mainWindow_Bruchtal = Turbine.UI.Lotro.GoldWindow()
        sceneWindows[#sceneWindows+1] = mainWindow_Bruchtal
		mainWindow_Bruchtal:SetSize(600,431);
		position(mainWindow_Bruchtal)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_Bruchtal:SetText("Rivendell!")
		elseif l == Turbine.Language.German then
			mainWindow_Bruchtal:SetText("Bruchtal!")
		elseif l == Turbine.Language.French then
			mainWindow_Bruchtal:SetText("Fondcombe !")
		end
		mainWindow_Bruchtal.Image=Turbine.UI.Label(); 
		mainWindow_Bruchtal.Image:SetParent(mainWindow_Bruchtal);
		mainWindow_Bruchtal.Image:SetSize(550,218);
		mainWindow_Bruchtal.Image:SetPosition(25, 175)
		mainWindow_Bruchtal.Image:SetBackground(file_path_bruchtal);
		mainWindow_Bruchtal.Message=Turbine.UI.Label(); 
		mainWindow_Bruchtal.Message:SetParent(mainWindow_Bruchtal);
		mainWindow_Bruchtal.Message:SetSize(550,229);
		mainWindow_Bruchtal.Message:SetPosition(25, 50)
		mainWindow_Bruchtal.Message:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_Bruchtal.Message:SetText("The ring cannot be destroyed, Gimli, Gloin's son. At least, not by any power we possess here. Created in the fires of Mount Doom, it can only be destroyed there! He must be taken deep into Mordor and cast back into the fiery embers from whence he came. One of you must do this! \nSo be it! Nine Companions. So you form the Fellowship of the Ring! ~ Elrond")
		elseif l == Turbine.Language.German then
			mainWindow_Bruchtal.Message:SetText("Der Ring kann nicht zerstört werden, Gimli, Gloins Sohn. Jedenfalls von keiner Kraft, die wir hier besitzen. In den Feuern des Schicksalsberges erschaffen, kann er nur dort zerstört werden! Man muss ihn tief nach Mordor hineinbringen und ihn in die feurige Glut zurückwerfen, aus der er stammt. Einer von euch muss das tun! \n\nSo sei es! Neun Gefährten. Ihr bildet also die Gemeinschaft des Ringes! ~ Elrond")
		elseif l == Turbine.Language.French then
			mainWindow_Bruchtal.Message:SetText("L'Anneau ne peut pas être détruit, Gimli, fils de Gloin. En tout cas, par aucun des pouvoirs que nous possédons ici. Créé dans les flammes de la Montagne du Destin, il ne peut être détruit que là! Il faut l'emmener au plus profond du Mordor et le rejeter dans les braises ardentes d'où il est issu. L'un d'entre vous doit le faire! \n\nSo soit! Neuf compagnons. Vous formez donc la communauté de l'Anneau! ~ Elrond")
		end
		mainWindow_Bruchtal.Message:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter)

		mainWindow_Bruchtal:SetVisible(true)
		
		local returnWindow = visibleReturnWindow()
		if returnWindow then returnWindow:SetVisible(false) end
		function mainWindow_Bruchtal:Closed(sender, args)
			if returnWindow then returnWindow:SetVisible(true) end
		end
	
end

function MainFunction_Lothlorien()
		
		
		local file_path_lothlorien = "Thardariel/WelcomeToMiddleEarth/images/Lothlorien.jpg";
			
		local mainWindow_Lothlorien = Turbine.UI.Lotro.GoldWindow()
        sceneWindows[#sceneWindows+1] = mainWindow_Lothlorien
		mainWindow_Lothlorien:SetSize(600,436);
		position(mainWindow_Lothlorien)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_Lothlorien:SetText("Lothlorien!");
		elseif l == Turbine.Language.German then
			mainWindow_Lothlorien:SetText("Lothlorien!");
		elseif l == Turbine.Language.French then
			mainWindow_Lothlorien:SetText("Lothlorien!");
		end
		mainWindow_Lothlorien.Image=Turbine.UI.Label(); 
		mainWindow_Lothlorien.Image:SetParent(mainWindow_Lothlorien);
		mainWindow_Lothlorien.Image:SetSize(550,218);
		mainWindow_Lothlorien.Image:SetPosition(25, 180)
		mainWindow_Lothlorien.Image:SetBackground(file_path_lothlorien);
		mainWindow_Lothlorien.Message=Turbine.UI.Label(); 
		mainWindow_Lothlorien.Message:SetParent(mainWindow_Lothlorien);
		mainWindow_Lothlorien.Message:SetSize(550,229);
		mainWindow_Lothlorien.Message:SetPosition(25, 50)
		mainWindow_Lothlorien.Message:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
        if locale == "fr" then
            mainWindow_Lothlorien.Message:SetText("La Communauté atteint la Lothlórien, mais Gandalf manque à l'appel après les événements de la Moria. Au cœur du royaume de Galadriel et Celeborn, ses compagnons trouvent un refuge avant de poursuivre leur voyage.")
        elseif locale == "en" then
            mainWindow_Lothlorien.Message:SetText("The Fellowship reaches Lothlorien without Gandalf after the events in Moria. In the realm of Galadriel and Celeborn, the companions find shelter before continuing their journey.")
        else
		mainWindow_Lothlorien.Message:SetText("Der Feind weiß, dass ihr hier eingetroffen seid. Eure Hoffnung unerkannt zu bleiben, sie ist nun zunichte.Hier sind acht, doch neun sind von Bruchtal aus aufgebrochen. Sagt mir, wo ist Gandalf, denn es verlangt mich sehr mit ihm zu sprechen. Ich kann ihn aus weiter Ferne nicht sehen. ~ Celeborn\n\nGandalf der Graue hat die Grenzen dieses Landes nicht überschritten. Er ist in den Schatten gestürzt. ~ Galadriel")
        end
		mainWindow_Lothlorien.Message:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter)

		mainWindow_Lothlorien:SetVisible(true)
		
		local returnWindow = visibleReturnWindow()
		if returnWindow then returnWindow:SetVisible(false) end
		function mainWindow_Lothlorien:Closed(sender, args)
			if returnWindow then returnWindow:SetVisible(true) end
		end
	
end

function MainFunction_Isengart()
		
		
		local file_path_isengart = "Thardariel/WelcomeToMiddleEarth/images/Isengart.jpg";
			
		local mainWindow_Isengart = Turbine.UI.Lotro.GoldWindow()
        sceneWindows[#sceneWindows+1] = mainWindow_Isengart
		mainWindow_Isengart:SetSize(600,406);
		position(mainWindow_Isengart)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_Isengart:SetText("Isengart!");
		elseif l == Turbine.Language.German then
			mainWindow_Isengart:SetText("Isengart!");
		elseif l == Turbine.Language.French then
			mainWindow_Isengart:SetText("Isengart!");
		end
		mainWindow_Isengart.Image=Turbine.UI.Label(); 
		mainWindow_Isengart.Image:SetParent(mainWindow_Isengart);
		mainWindow_Isengart.Image:SetSize(550,218);
		mainWindow_Isengart.Image:SetPosition(25, 150)
		mainWindow_Isengart.Image:SetBackground(file_path_isengart);
		mainWindow_Isengart.Message=Turbine.UI.Label(); 
		mainWindow_Isengart.Message:SetParent(mainWindow_Isengart);
		mainWindow_Isengart.Message:SetSize(550,229);
		mainWindow_Isengart.Message:SetPosition(25, 50)
		mainWindow_Isengart.Message:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_Isengart.Message:SetText("If the wall is breached, Helm's Deep will fall. ~ Even if it were breached, an unimaginable number would be needed. Thousands to storm the fortress! ~ Gríma\nTen thousand. ~ Saruman\nBut my lord, there is no such force. ~ Gríma\nA new power is rising and its victory is near. ~Saruman")
		elseif l == Turbine.Language.German then
			mainWindow_Isengart.Message:SetText("Wird der Wall durchbrochen, fällt Helms Klamm. ~ Saruman\nSelbst wenn man ihn durchbräche, eine unvorstellbare Anzahl wäre von Nöten. Tausende um die Festung zu stürmen! ~ Gríma\nZehntausende. ~ Saruman\nAber mein Gebieter, eine solche Streitmacht gibt es nicht. ~ Gríma\nEine neue Macht erhebt sich und ihr Sieg ist nah. ~Saruman")
		elseif l == Turbine.Language.French then
			mainWindow_Isengart.Message:SetText("Si le mur est franchi, le Gouffre de Helm tombe. ~ Saruman\nMême si on le franchissait, il faudrait un nombre inimaginable de personnes. Des milliers pour prendre la forteresse d'assaut! ~ Gríma\nDix mille personnes. ~ Saruman\nMais mon maître, une telle force n'existe pas. ~ Gríma\nUne nouvelle force se lève et sa victoire est proche. ~Saruman")
		end
		mainWindow_Isengart.Message:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter)

		mainWindow_Isengart:SetVisible(true)
		
		local returnWindow = visibleReturnWindow()
		if returnWindow then returnWindow:SetVisible(false) end
		function mainWindow_Isengart:Closed(sender, args)
			if returnWindow then returnWindow:SetVisible(true) end
		end
	
end

function MainFunction_AmonHen()
		
		
		local file_path_amonhen = "Thardariel/WelcomeToMiddleEarth/images/AmonHen.jpg";
			
		local mainWindow_AmonHen = Turbine.UI.Lotro.GoldWindow()
        sceneWindows[#sceneWindows+1] = mainWindow_AmonHen
		mainWindow_AmonHen:SetSize(600,421);
		position(mainWindow_AmonHen)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_AmonHen:SetText("Amon Hen!");
		elseif l == Turbine.Language.German then
			mainWindow_AmonHen:SetText("Amon Hen!");
		elseif l == Turbine.Language.French then
			mainWindow_AmonHen:SetText("Amon Hen!");
		end
		mainWindow_AmonHen.Image=Turbine.UI.Label(); 
		mainWindow_AmonHen.Image:SetParent(mainWindow_AmonHen);
		mainWindow_AmonHen.Image:SetSize(550,218);
		mainWindow_AmonHen.Image:SetPosition(25, 165)
		mainWindow_AmonHen.Image:SetBackground(file_path_amonhen);
		mainWindow_AmonHen.Message=Turbine.UI.Label(); 
		mainWindow_AmonHen.Message:SetParent(mainWindow_AmonHen);
		mainWindow_AmonHen.Message:SetSize(550,229);
		mainWindow_AmonHen.Message:SetPosition(25, 50)
		mainWindow_AmonHen.Message:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_AmonHen.Message:SetText("I would have followed you my brother, my captain, my king! ~ Boromir\n\nPeace be with you, son of Gondor. ~ Aragorn\n\nAt this point the Fellowship of the Ring separates. Aragorn, Legolas and Gimli follow the trail of the Uruk-Hai to rescue Merry and Pippin. Frodo and Sam are now on their own, for now.")
		elseif l == Turbine.Language.German then
			mainWindow_AmonHen.Message:SetText("Ich wäre dir gefolgt mein Bruder, mein Hauptmann, mein König! ~ Boromir\n\nFriede sei mit dir, Sohn Gondors. ~ Aragorn\n\nAn diesem Punkt trennt sich die Gemeinschaft des Ringes. Aragorn, Legolas und Gimli verfolgen die Spur der Uruk-Hai, um Merry und Pippin zu retten. Frodo und Sam sind nun auf sich allein gestellt, vorerst.")
		elseif l == Turbine.Language.French then
			mainWindow_AmonHen.Message:SetText("Je t'aurais suivi mon frère, mon capitaine, mon roi ! ~ Boromir\n\nLa paix soit avec toi, fils du Gondor. ~ Aragorn\n\nA ce stade, la communauté de l'Anneau se sépare. Aragorn, Legolas et Gimli suivent la piste des Uruk-Hai pour sauver Merry et Pippin. Frodon et Sam sont désormais livrés à eux-mêmes, pour le moment.")
		end
		mainWindow_AmonHen.Message:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter)

		mainWindow_AmonHen:SetVisible(true)
		
		local returnWindow = visibleReturnWindow()
		if returnWindow then returnWindow:SetVisible(false) end
		function mainWindow_AmonHen:Closed(sender, args)
			if returnWindow then returnWindow:SetVisible(true) end
		end
	
end

function MainFunction_Edoras()
		
		
		local file_path_edoras = "Thardariel/WelcomeToMiddleEarth/images/Edoras.jpg";
			
		local mainWindow_Edoras = Turbine.UI.Lotro.GoldWindow()
        sceneWindows[#sceneWindows+1] = mainWindow_Edoras
		mainWindow_Edoras:SetSize(600,396);
		position(mainWindow_Edoras)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_Edoras:SetText("Edoras!");
		elseif l == Turbine.Language.German then
			mainWindow_Edoras:SetText("Edoras!");
		elseif l == Turbine.Language.French then
			mainWindow_Edoras:SetText("Edoras!");
		end
		mainWindow_Edoras.Image=Turbine.UI.Label(); 
		mainWindow_Edoras.Image:SetParent(mainWindow_Edoras);
		mainWindow_Edoras.Image:SetSize(550,218);
		mainWindow_Edoras.Image:SetPosition(25, 140)
		mainWindow_Edoras.Image:SetBackground(file_path_edoras);
		mainWindow_Edoras.Message=Turbine.UI.Label(); 
		mainWindow_Edoras.Message:SetParent(mainWindow_Edoras);
		mainWindow_Edoras.Message:SetSize(550,229);
		mainWindow_Edoras.Message:SetPosition(25, 50)
		mainWindow_Edoras.Message:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_Edoras.Message:SetText("I am Gandalf the White, and I return to you. At the turning point of the tides. One stage of your journey is over. Now comes the next. War has come upon Rohan. We must ride to Edoras as swiftly as we can. ~ Gandalf")
		elseif l == Turbine.Language.German then
			mainWindow_Edoras.Message:SetText("Ich bin Gandalf der Weiße und ich kehre zurück zu euch. Am Wendepunkt der Gezeiten. Eine Etappe eurer Reise ist vorüber. Nun folgt die nächste. Krieg ist über Rohan bgekommen. Wir müssen nach Edoras reiten, so geschwind wir können. ~ Gandalf")
		elseif l == Turbine.Language.French then
			mainWindow_Edoras.Message:SetText("Je suis Gandalf le Blanc et je reviens vers vous. Au point d'inflexion des marées. Une étape de votre voyage est terminée. Voici la prochaine. La guerre est arrivée au Rohan. Nous devons nous rendre à Edoras aussi vite que possible. ~ Gandalf")
		end
		mainWindow_Edoras.Message:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter)

		mainWindow_Edoras:SetVisible(true)
		
		local returnWindow = visibleReturnWindow()
		if returnWindow then returnWindow:SetVisible(false) end
		function mainWindow_Edoras:Closed(sender, args)
			if returnWindow then returnWindow:SetVisible(true) end
		end
	
end

function MainFunction_HelmsKlamm()
		
		
		local file_path_helmsklamm = "Thardariel/WelcomeToMiddleEarth/images/HelmsKlamm.jpg";
			
		local mainWindow_HelmsKlamm = Turbine.UI.Lotro.GoldWindow()
        sceneWindows[#sceneWindows+1] = mainWindow_HelmsKlamm
		mainWindow_HelmsKlamm:SetSize(600,436);
		position(mainWindow_HelmsKlamm)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_HelmsKlamm:SetText("Helm's Deep!");
		elseif l == Turbine.Language.German then
			mainWindow_HelmsKlamm:SetText("Helms Klamm!");
		elseif l == Turbine.Language.French then
			mainWindow_HelmsKlamm:SetText("Le gouffre de Helm!");
		end
		mainWindow_HelmsKlamm.Image=Turbine.UI.Label(); 
		mainWindow_HelmsKlamm.Image:SetParent(mainWindow_HelmsKlamm);
		mainWindow_HelmsKlamm.Image:SetSize(550,218);
		mainWindow_HelmsKlamm.Image:SetPosition(25, 180)
		mainWindow_HelmsKlamm.Image:SetBackground(file_path_helmsklamm);
		mainWindow_HelmsKlamm.Message=Turbine.UI.Label(); 
		mainWindow_HelmsKlamm.Message:SetParent(mainWindow_HelmsKlamm);
		mainWindow_HelmsKlamm.Message:SetSize(550,229);
		mainWindow_HelmsKlamm.Message:SetPosition(25, 50)
		mainWindow_HelmsKlamm.Message:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_HelmsKlamm.Message:SetText("Await my coming, at the first light of the fifth day. At sunrise, look to the east. ~ Gandalf\n\nAn enemy had never entered the gorge before the Uruk-hai attack. It is also said that when men defended this fortification, the enemy had never been able to take a step inside the inner ring of the Hornburg. But Saruman's army was strong enough to take this fortress.")
		elseif l == Turbine.Language.German then
			mainWindow_HelmsKlamm.Message:SetText("Erwartet mein Kommen, beim ersten Licht des fünften Tages. Bei Sonnenaufgang, schaut nach Osten. ~ Gandalf\n\nIn die Klamm war vor dem Angriff der Uruk-hai noch nie ein Feind eingedrungen. Es heißt ausserdem, dass, wenn Menschen diese Befestigung verteidigten, der Feind noch nie einen Schritt in den Innenring der Hornburg setzen konnte. Doch Sarumans Heer war stark genug diese Festung einzunehmen.")
		elseif l == Turbine.Language.French then
			mainWindow_HelmsKlamm.Message:SetText("Attendez-vous à ma venue, aux premières lueurs du cinquième jour. Au lever du soleil, regardez vers l'est. ~ Gandalf\n\nAucun ennemi n'avait jamais pénétré dans la gorge avant l'attaque des Uruk-hai. On dit en outre que si des hommes défendaient cette fortification, l'ennemi n'avait jamais pu faire un pas dans l'anneau intérieur du château de Horn. Mais l'armée de Saroumane était suffisamment puissante pour prendre cette forteresse.")
		end
		mainWindow_HelmsKlamm.Message:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter)

		mainWindow_HelmsKlamm:SetVisible(true)
		
		local returnWindow = visibleReturnWindow()
		if returnWindow then returnWindow:SetVisible(false) end
		function mainWindow_HelmsKlamm:Closed(sender, args)
			if returnWindow then returnWindow:SetVisible(true) end
		end
	
end

function MainFunction_MinasTirith()
		
		
		local file_path_minastirith = "Thardariel/WelcomeToMiddleEarth/images/MinasTirith.jpg";
			
		local mainWindow_MinasTirith = Turbine.UI.Lotro.GoldWindow()
        sceneWindows[#sceneWindows+1] = mainWindow_MinasTirith
		mainWindow_MinasTirith:SetSize(600,416);
		position(mainWindow_MinasTirith)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_MinasTirith:SetText("Minas Tirith!");
		elseif l == Turbine.Language.German then
			mainWindow_MinasTirith:SetText("Minas Tirith!");
		elseif l == Turbine.Language.French then
			mainWindow_MinasTirith:SetText("Minas Tirith!");
		end
		mainWindow_MinasTirith.Image=Turbine.UI.Label(); 
		mainWindow_MinasTirith.Image:SetParent(mainWindow_MinasTirith);
		mainWindow_MinasTirith.Image:SetSize(550,218);
		mainWindow_MinasTirith.Image:SetPosition(25, 160)
		mainWindow_MinasTirith.Image:SetBackground(file_path_minastirith);
		mainWindow_MinasTirith.Message=Turbine.UI.Label(); 
		mainWindow_MinasTirith.Message:SetParent(mainWindow_MinasTirith);
		mainWindow_MinasTirith.Message:SetSize(550,229);
		mainWindow_MinasTirith.Message:SetPosition(25, 50)
		mainWindow_MinasTirith.Message:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_MinasTirith.Message:SetText("The beacons of Minas Tirith, the beacons burn! Gondor calls for help!\nAnd Rohan will answer! Let the show of arms begin! \nSpear shall shatter, shield shall shatter, a sword-day, a blood-day, before the sun rises. Ride, ride now, Ride to destruction and the end of the world. DEATH! ~ Theoden")
		elseif l == Turbine.Language.German then
			mainWindow_MinasTirith.Message:SetText("Die Leuchtfeuer von Minas Tirith, die Leuchtfeuer brennen! Gondor ruft um Hilfe!\nUnd Rohan wird antworten! Die Heerschau soll beginnen! \n\nSpeer wird zerschellen, Schild zersplittern, ein Schwerttag, ein Bluttag, ehe die Sonne steigt. Reitet, Reitet nun, Reitet zur Vernichtung und zum Ende der Welt. TOD! ~ Theoden")
		elseif l == Turbine.Language.French then
			mainWindow_MinasTirith.Message:SetText("Les feux de Minas Tirith, les feux sont allumés ! Le Gondor appelle à l'aide!\nEt le Rohan répondra ! Que le spectacle de l'armée commence ! \n\nLa lance se brisera, le bouclier volera en éclats, un jour d'épée, un jour de sang, avant que le soleil ne se lève. Chevauchez, chevauchez maintenant, chevauchez vers la destruction et la fin du monde. MORT ! ~ Théoden")
		end
		mainWindow_MinasTirith.Message:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter)

		mainWindow_MinasTirith:SetVisible(true)
		
		local returnWindow = visibleReturnWindow()
		if returnWindow then returnWindow:SetVisible(false) end
		function mainWindow_MinasTirith:Closed(sender, args)
			if returnWindow then returnWindow:SetVisible(true) end
		end
	
end

function MainFunction_Mordor()
		
		
		local file_path_mordor = "Thardariel/WelcomeToMiddleEarth/images/Mordor.jpg";
			
		local mainWindow_Mordor = Turbine.UI.Lotro.GoldWindow()
        sceneWindows[#sceneWindows+1] = mainWindow_Mordor
		mainWindow_Mordor:SetSize(600,426);
		position(mainWindow_Mordor)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_Mordor:SetText("Mordor!");
		elseif l == Turbine.Language.German then
			mainWindow_Mordor:SetText("Mordor!");
		elseif l == Turbine.Language.French then
			mainWindow_Mordor:SetText("Mordor!");
		end
		mainWindow_Mordor.Image=Turbine.UI.Label(); 
		mainWindow_Mordor.Image:SetParent(mainWindow_Mordor);
		mainWindow_Mordor.Image:SetSize(550,197);
		mainWindow_Mordor.Image:SetPosition(25, 205)
		mainWindow_Mordor.Image:SetBackground(file_path_mordor);
		mainWindow_Mordor.Message=Turbine.UI.Label(); 
		mainWindow_Mordor.Message:SetParent(mainWindow_Mordor);
		mainWindow_Mordor.Message:SetSize(550,229);
		mainWindow_Mordor.Message:SetPosition(25, 50)
		mainWindow_Mordor.Message:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_Mordor.Message:SetText("Hold your ground! Hold your ground! Sons of Gondor and Rohan, my brothers! I see in your eyes the same fear that would make me despondent. The day may come when the courage of men is extinguished, when we forsake our companions, and all bonds of friendship are broken. But this day is still far away. The hour of the wolves and shattered shields, when the age of men thunders down, but this day is still far away! For today we fight! By all that you hold dear on this earth, I say: Stand fast, Men of the West!\n\nFor Frodo! ~ Aragorn")
		elseif l == Turbine.Language.German then
			mainWindow_Mordor.Message:SetText("Haltet eure Stellung! Haltet eure Stellung! Söhne Gondors und Rohans, meine Brüder! In euren Augen sehe ich dieselbe Furcht, die auch mich verzagen ließe. Der Tag mag kommen, da der Mut der Menschen erlischt, da wir unsere Gefährten im Stich lassen und aller Freundschaft Bande bricht. Doch dieser Tag ist noch fern. Die Stunde der Wölfe und zerschmetterter Schilde, da das Zeitalter der Menschen tosend untergeht, doch dieser Tag ist noch fern! Denn heute kämpfen wir! Bei allem, was euch teuer ist auf dieser Erde, sage ich: Haltet stand, Menschen des Westens!\n\nFür Frodo! ~ Aragorn")
		elseif l == Turbine.Language.French then
			mainWindow_Mordor.Message:SetText("Tenez votre position ! Tenez votre position ! Fils du Gondor et du Rohan, mes frères ! Je vois dans vos yeux la même peur qui m'a fait perdre espoir. Le jour viendra peut-être où le courage des hommes s'éteindra, où nous abandonnerons nos compagnons et où les liens de l'amitié seront rompus. Mais ce jour est encore loin. L'heure des loups et des boucliers brisés, où l'ère des hommes s'éteint avec fracas, mais ce jour est encore loin ! Car aujourd'hui, nous nous battons ! Par tout ce qui vous est cher sur cette terre, je vous le dis : tenez bon, peuple de l'Ouest!\nPour Frodo ! ~ Aragorn")
		end
		mainWindow_Mordor.Message:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter)

		mainWindow_Mordor:SetVisible(true)
		
		local returnWindow = visibleReturnWindow()
		if returnWindow then returnWindow:SetVisible(false) end
		function mainWindow_Mordor:Closed(sender, args)
			if returnWindow then returnWindow:SetVisible(true) end
		end
	
end

function MainFunction_GraueAnfurten()
		
		local file_path_graueanfurten = "Thardariel/WelcomeToMiddleEarth/images/GraueAnfurten.jpg";
			
		local mainWindow_GraueAnfurten = Turbine.UI.Lotro.GoldWindow()
        sceneWindows[#sceneWindows+1] = mainWindow_GraueAnfurten
		mainWindow_GraueAnfurten:SetSize(600,416);
		position(mainWindow_GraueAnfurten)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_GraueAnfurten:SetText("The gray havens!");
		elseif l == Turbine.Language.German then
			mainWindow_GraueAnfurten:SetText("Die grauen Anfurten!");
		elseif l == Turbine.Language.French then
			mainWindow_GraueAnfurten:SetText("Les Havres Gris !");
		end
		mainWindow_GraueAnfurten.Image=Turbine.UI.Label(); 
		mainWindow_GraueAnfurten.Image:SetParent(mainWindow_GraueAnfurten);
		mainWindow_GraueAnfurten.Image:SetSize(550,218);
		mainWindow_GraueAnfurten.Image:SetPosition(25, 160)
		mainWindow_GraueAnfurten.Image:SetBackground(file_path_graueanfurten);
		mainWindow_GraueAnfurten.Message=Turbine.UI.Label(); 
		mainWindow_GraueAnfurten.Message:SetParent(mainWindow_GraueAnfurten);
		mainWindow_GraueAnfurten.Message:SetSize(550,229);
		mainWindow_GraueAnfurten.Message:SetPosition(25, 50)
		mainWindow_GraueAnfurten.Message:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
		
		local l = Turbine.Engine.GetLanguage()
		if l == Turbine.Language.English or l == Turbine.Language.EnglishGB then
			mainWindow_GraueAnfurten.Message:SetText("And so it happened that the Fourth Age dawned on Middle Earth. And the Fellowship of the Ring, though eternally united in love and friendship, disintegrated. Exactly 13 months ago, Gandalf had sent us on our long journey. Now we were confronted with a strange sight. We were home! \n\n ~ Frodo")
		elseif l == Turbine.Language.German then
			mainWindow_GraueAnfurten.Message:SetText("Und so geschah es, dass das Vierte Zeitalter in Mittelerde anbrach. Und die Gemeinschaft des Ringes, obgleich ewig verbunden in Liebe und Freundschaft, löste sich auf. Genau vor 13 Monaten hatte uns Gandalf auf unsere lange Reise geschickt. Nun bot sich uns ein vertauter Anblick. Wir waren zu Hause! \n\n ~ Frodo")
		elseif l == Turbine.Language.French then
			mainWindow_GraueAnfurten.Message:SetText("Et c'est ainsi que le Quatrième Âge arriva sur la Terre du Milieu. Et la communauté de l'Anneau, bien qu'éternellement unie par l'amour et l'amitié, s'est dissoute. Il y a treize mois exactement, Gandalf nous avait envoyés dans notre long voyage. Maintenant, nous avions une vue imprenable. Nous étions à la maison ! \n\n ~ Frodo")
		end
		mainWindow_GraueAnfurten.Message:SetTextAlignment(Turbine.UI.ContentAlignment.TopCenter)

		mainWindow_GraueAnfurten:SetVisible(true)
		
		local returnWindow = visibleReturnWindow()
		if returnWindow then returnWindow:SetVisible(false) end
		function mainWindow_GraueAnfurten:Closed(sender, args)
			if returnWindow then returnWindow:SetVisible(true) end
		end
	
end


local guideWindow
local function showText(title, content)
    if guideWindow then guideWindow:SetVisible(false) end
    guideWindow = Turbine.UI.Lotro.GoldWindow()
    guideWindow:SetText(title)
    guideWindow:SetSize(math.min(620,Turbine.UI.Display:GetWidth()),math.min(550,Turbine.UI.Display:GetHeight()))
    position(guideWindow)
    local label = Turbine.UI.Label()
    label:SetParent(guideWindow)
    label:SetPosition(25,50)
    label:SetSize(guideWindow:GetWidth()-65,guideWindow:GetHeight()-80)
    label:SetFont(Turbine.UI.Lotro.Font.Verdana14)
    label:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft)
    label:SetMultiline(true)
    label:SetText(content)
    local scroll = Turbine.UI.Lotro.ScrollBar()
    scroll:SetParent(guideWindow)
    scroll:SetOrientation(Turbine.UI.Orientation.Vertical)
    scroll:SetPosition(guideWindow:GetWidth()-32,50)
    scroll:SetSize(12,guideWindow:GetHeight()-80)
    label:SetVerticalScrollBar(scroll)
    guideWindow:SetVisible(true)
end

local function label(parent, x, y, w, h, value)
    local control = Turbine.UI.Label()
    control:SetParent(parent)
    control:SetPosition(x,y)
    control:SetSize(w,h)
    control:SetFont(Turbine.UI.Lotro.Font.Verdana14)
    control:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft)
    control:SetMultiline(true)
    control:SetText(value or "")
    return control
end
local function button(parent, x,y,w,value,action)
    local control = Turbine.UI.Lotro.Button()
    control:SetParent(parent)
    control:SetPosition(x,y)
    control:SetSize(w,24)
    control:SetText(value)
    control.Click = action
    return control
end

mainWindow = Turbine.UI.Lotro.GoldWindow()
mainWindow:SetText(text.title.." — 1.4.16-community")
local windowWidth = math.min(640,Turbine.UI.Display:GetWidth())
local windowHeight = math.min(590,Turbine.UI.Display:GetHeight())
mainWindow:SetSize(windowWidth,windowHeight)
position(mainWindow,settings.x,settings.y)
local heading = label(mainWindow,25,42,windowWidth-50,30)
local subtitle = label(mainWindow,25,76,windowWidth-50,28,text.next)
local footerY = windowHeight-155
local rowsPerPage = math.max(1, math.floor((footerY-115)/58))
local rows = {}
local page = 1
local data = {skills={},skipped=0,filtered=0,unavailable=false}
local hint = label(mainWindow,25,footerY,windowWidth-50,44)
local traitHint = label(mainWindow,25,footerY+44,windowWidth-50,38)
local pageLabel = label(mainWindow,windowWidth-235,footerY+84,64,24)
pageLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
local message = label(mainWindow,25,115,windowWidth-50,110)
local controls = {}
local viewOpen = false
local render

local function draw()
    for _, control in ipairs(rows) do control:SetParent(nil); control:SetVisible(false) end
    rows = {}
    local level = player:GetLevel()
    heading:SetText(string.format(text.level,safePlayerName(),level))
    local pages = math.max(1,math.ceil(#data.skills/rowsPerPage))
    page = math.max(1,math.min(page,pages))
    pageLabel:SetText(string.format(text.page,page,pages))
    controls.previous:SetEnabled(page>1)
    controls.following:SetEnabled(page<pages)
    message:SetVisible(#data.skills==0)
    message:SetText(data.unavailable and text.error or text.empty)
    local warning = data.unavailable and text.error or (data.skipped>0 and text.skipped or (data.filtered>0 and text.filtered or text.note))
    if level == 140 then warning = text.umbar
    elseif level == 150 then warning = text.harad
    elseif level == 160 then warning = text.cap end
    -- Never conceal an actual read failure behind a milestone hint.
    if data.unavailable then warning = text.error end
    hint:SetText(warning)
    local nextTrait = model.NextTrait(level)
    traitHint:SetText(settings.traits and (nextTrait and string.format(text.trait,nextTrait) or text.traitEnd) or "")
    for i=(page-1)*rowsPerPage+1,math.min(page*rowsPerPage,#data.skills) do
        local entry = data.skills[i]
        local y = 115+(i-1-(page-1)*rowsPerPage)*58
        local icon = Turbine.UI.Control()
        icon:SetParent(mainWindow)
        icon:SetPosition(25,y+5)
        icon:SetSize(32,32)
        if entry.icon ~= nil then pcall(function() icon:SetBackground(entry.icon) end) end
        rows[#rows+1] = icon
        local rowFormat
        if entry.mounted then
            rowFormat = entry.level<=level and text.mountedReady or text.mountedRow
        else
            rowFormat = entry.level<=level and text.ready or text.row
        end
        local skillLabel = label(mainWindow,70,y,windowWidth-95,50,
            string.format(rowFormat,entry.level,entry.name))
        skillLabel.MouseClick = function()
            showText(text.details, entry.name.."\n\n"..entry.description.."\n\n"..text.note)
        end
        rows[#rows+1] = skillLabel
    end
end

local pendingOpen = false
local pendingLevel = false
local deadline
local timer = Turbine.UI.Control()
local watched = {}
local pendingGainedEntries = nil
local pendingGainFromLevel = nil
local pendingGainToLevel = nil
local levelSnapshot = nil
local previousLevelSnapshot = nil
local lastLevel = player:GetLevel()
local observeLevelChange

local function snapshotOf(result)
    local snapshot = { skills = {} }
    if result and type(result.skills) == "table" then
        for _, entry in ipairs(result.skills) do
            snapshot.skills[#snapshot.skills+1] = {
                name = entry.name, level = entry.level, icon = entry.icon,
                description = entry.description, source = entry.source,
                mounted = entry.mounted
            }
        end
    end
    return snapshot
end

local function schedule(open, leveled)
    pendingOpen = pendingOpen or open
    pendingLevel = pendingLevel or leveled
    -- One short batch after events; never run a permanent polling loop.
    if not deadline then deadline = Turbine.Engine.GetGameTime()+0.35 end
    timer:SetWantsUpdates(true)
end
local function watch(list)
    if list == nil or watched[list] then return end
    watched[list] = true
    local changed = function()
        -- A skill-list change can arrive just before LevelChanged. Check the
        -- actual player level first so the pre-level snapshot cannot be lost.
        if observeLevelChange then observeLevelChange() end
        schedule(false,false)
    end
    bind(list,"SkillAdded",changed)
    bind(list,"SkillRemoved",changed)
end
render = function(updateSnapshot)
    data = model.Read(player)
    for _, list in ipairs(data.lists) do watch(list) end
    draw()
    -- Explicit Refresh is also a synchronization point for the level-up
    -- detector. Keep one previous snapshot as a short race-safe fallback.
    if updateSnapshot then
        previousLevelSnapshot = levelSnapshot
        levelSnapshot = snapshotOf(data)
    end
end
local function openWindow()
    closeScenes()
    if levelWindow then levelWindow:SetVisible(false) end
    page = 1
    viewOpen = true
    render(false)
    mainWindow:SetVisible(true)
end

-- Original 1.3-style level-up notification, extended for 1.4.9:
-- show everything gained across the whole level jump (including multi-level
-- jumps), then keep the look-ahead section for the next REAL skill/trait
-- milestones. The trait-point image ID is the exact resource used by 1.3.
local TRAIT_POINT_ICON = 0x41142C2E

local function traitEntry(level)
    return { name = text.traitPointName, level = level, traitPoint = true }
end

local function rewardKey(entry)
    if entry.traitPoint then return "trait\031"..tostring(entry.level) end
    return "skill\031"..tostring(entry.level).."\031"..tostring(entry.name).."\031"..tostring(entry.icon)
end

local function sortRewards(entries)
    table.sort(entries, function(a,b)
        if a.level ~= b.level then return a.level < b.level end
        if (a.traitPoint == true) ~= (b.traitPoint == true) then return a.traitPoint ~= true end
        return tostring(a.name) < tostring(b.name)
    end)
end

local function mergeRewards(target, source)
    local seen = {}
    for _, entry in ipairs(target) do seen[rewardKey(entry)] = true end
    for _, entry in ipairs(source or {}) do
        local key = rewardKey(entry)
        if not seen[key] then
            seen[key] = true
            target[#target+1] = entry
        end
    end
    sortRewards(target)
    return target
end

-- Keep the last detected level-up in Character PluginData so /wtme levelup
-- can reopen the same notification after /reload or a reconnect. Only plain
-- serializable values are stored; live API objects/descriptions stay out.
local function copyRewardForSave(entry)
    if type(entry) ~= "table" or type(entry.name) ~= "string" then return nil end
    local level = tonumber(entry.level)
    if not level then return nil end
    local savedEntry = {
        name = entry.name,
        level = level,
        traitPoint = entry.traitPoint == true,
        mounted = entry.mounted == true
    }
    if type(entry.icon) == "number" or type(entry.icon) == "string" then
        savedEntry.icon = entry.icon
    end
    return savedEntry
end

local function copyRewardsForSave(entries)
    local copies = {}
    for _, entry in ipairs(entries or {}) do
        local copy = copyRewardForSave(entry)
        if copy then copies[#copies+1] = copy end
    end
    sortRewards(copies)
    return copies
end

local function buildUpcoming(result, baseLevel)
    local upcoming = {}
    for _, entry in ipairs(model.NextSkills(result and result.skills or {}, baseLevel)) do
        upcoming[#upcoming+1] = entry
    end
    if settings.traits then
        local nextTrait = model.NextTrait(baseLevel)
        if nextTrait then upcoming[#upcoming+1] = traitEntry(nextTrait) end
    end
    sortRewards(upcoming)
    return upcoming, result and result.unavailable == true
end

local function normalizeSavedLevelUp(value)
    if type(value) ~= "table" then return nil end
    local fromLevel = tonumber(value.fromLevel)
    local toLevel = tonumber(value.toLevel)
    if not fromLevel or not toLevel or fromLevel > toLevel then return nil end
    if type(value.entries) ~= "table" then return nil end
    local normalized = {
        fromLevel = fromLevel,
        toLevel = toLevel,
        entries = copyRewardsForSave(value.entries)
    }
    -- 1.4.13 stores the forecast that was visible at the moment of the ding as
    -- well. Older PluginData has no `upcoming` field; keep that distinguishable
    -- from an intentionally empty forecast so legacy saves can still fall back
    -- to a best-effort live reconstruction.
    if type(value.upcoming) == "table" then
        normalized.upcoming = copyRewardsForSave(value.upcoming)
        normalized.upcomingUnavailable = value.upcomingUnavailable == true
    end
    return normalized
end

local lastLevelUp = normalizeSavedLevelUp(settings.lastLevelUp)
settings.lastLevelUp = lastLevelUp

local function rememberLevelUp(entries, fromLevel, toLevel)
    local currentLevel = player:GetLevel()
    fromLevel = tonumber(fromLevel) or currentLevel
    toLevel = tonumber(toLevel) or currentLevel
    local result = model.Read(player)
    local upcoming, unavailable = buildUpcoming(result, toLevel)
    local value = {
        fromLevel = fromLevel,
        toLevel = toLevel,
        entries = copyRewardsForSave(entries),
        upcoming = copyRewardsForSave(upcoming),
        upcomingUnavailable = unavailable == true
    }
    lastLevelUp = value
    settings.lastLevelUp = value
    save()
    return value
end

-- If the plugin is unloaded while the 0.35 s debounce is still pending, the
-- freshly detected level-up has not reached timer.Update yet. Persist it here
-- so an immediate /reload, logout or game exit cannot leave /wtme levelup on
-- the previous notification.
local function persistPendingLevelUp()
    if not pendingLevel then return false end
    local currentLevel = player:GetLevel()
    rememberLevelUp(
        pendingGainedEntries or {},
        pendingGainFromLevel or currentLevel,
        pendingGainToLevel or currentLevel
    )
    return true
end

local function obtainedBetween(snapshots, oldLevel, newLevel)
    local entries = {}
    local seen = {}
    if newLevel <= oldLevel then return entries end
    for level = oldLevel + 1, newLevel do
        for _, snapshot in ipairs(snapshots or {}) do
            if snapshot and type(snapshot.skills) == "table" then
                for _, entry in ipairs(model.SkillsAtLevel(snapshot.skills, level)) do
                    local key = rewardKey(entry)
                    if not seen[key] then
                        seen[key] = true
                        entries[#entries+1] = entry
                    end
                end
            end
        end
        if settings.traits and model.IsTraitLevel(level) then
            local entry = traitEntry(level)
            local key = rewardKey(entry)
            if not seen[key] then
                seen[key] = true
                entries[#entries+1] = entry
            end
        end
    end
    sortRewards(entries)
    return entries
end

local LEVEL_SECTION_HEIGHT = 27
local LEVEL_MESSAGE_HEIGHT = 42
local LEVEL_REWARD_HEIGHT = 70

local function rewardIcon(parent, entry, x, y)
    local icon = Turbine.UI.Control()
    icon:SetParent(parent)
    icon:SetSize(32, 32)
    icon:SetPosition(x, y)
    -- Match the original 1.3 order: assign the image first, then enable
    -- StretchMode(2). Reversing those calls can tile some LOTRO resources
    -- instead of drawing one centered 32x32 icon.
    if entry.traitPoint then
        pcall(function() icon:SetBackground(TRAIT_POINT_ICON) end)
    elseif entry.icon ~= nil then
        pcall(function() icon:SetBackground(entry.icon) end)
    end
    icon:SetStretchMode(2)
    return icon
end

local function listItem(list, height)
    local item = Turbine.UI.Control()
    item:SetSize(list:GetWidth(), height)
    list:AddItem(item)
    return item
end

local function addSectionTitle(list, value)
    local item = listItem(list, LEVEL_SECTION_HEIGHT)
    local title = Turbine.UI.Label()
    title:SetParent(item)
    title:SetPosition(0, 0)
    title:SetSize(item:GetWidth(), 25)
    title:SetFont(Turbine.UI.Lotro.Font.TrajanPro15)
    title:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
    title:SetText(value)
    return LEVEL_SECTION_HEIGHT
end

local function addMessageItem(list, value)
    local item = listItem(list, LEVEL_MESSAGE_HEIGHT)
    local message = Turbine.UI.Label()
    message:SetParent(item)
    message:SetPosition(0, 0)
    message:SetSize(item:GetWidth(), 40)
    message:SetFont(Turbine.UI.Lotro.Font.TrajanPro14)
    message:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
    message:SetMultiline(true)
    message:SetText(value)
    return LEVEL_MESSAGE_HEIGHT
end

local function addSpacer(list, height)
    listItem(list, height)
    return height
end

local function addRewardItem(list, entry, format, showLevel)
    local item = listItem(list, LEVEL_REWARD_HEIGHT)
    -- The 1.3 popup centered the reward icon, with the caption centered below
    -- it. Keep that visual language while retaining the new sectioned list.
    rewardIcon(item, entry, math.floor((item:GetWidth()-32)/2), 1)
    local row = Turbine.UI.Label()
    row:SetParent(item)
    row:SetPosition(0, 36)
    row:SetSize(item:GetWidth(), 30)
    row:SetFont(Turbine.UI.Lotro.Font.TrajanPro14)
    row:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
    row:SetMultiline(true)
    if format == text.levelUpGainedRow then
        if showLevel then row:SetText(string.format(text.row, entry.level, entry.name))
        else row:SetText(string.format(format, entry.name)) end
    else
        row:SetText(string.format(format, entry.name, entry.level))
    end
    return LEVEL_REWARD_HEIGHT
end

local function openLevelWindow(gainedEntries, gainedFromLevel, gainedToLevel, savedUpcoming, savedUpcomingUnavailable)
    closeScenes()
    mainWindow:SetVisible(false)
    viewOpen = false
    if levelWindow then levelWindow:SetVisible(false) end

    local currentLevel = player:GetLevel()
    gainedEntries = gainedEntries or {}
    gainedFromLevel = tonumber(gainedFromLevel) or currentLevel
    gainedToLevel = tonumber(gainedToLevel) or currentLevel
    -- The replay command must describe the level-up that was actually saved,
    -- not whatever level the character happens to be now.
    local popupLevel = gainedToLevel

    local result = model.Read(player)
    local upcoming
    local upcomingUnavailable
    if type(savedUpcoming) == "table" then
        -- New saves keep the exact forecast shown at the ding, so /wtme levelup
        -- can reproduce the same window even after the character gains more levels.
        upcoming = copyRewardsForSave(savedUpcoming)
        upcomingUnavailable = savedUpcomingUnavailable == true
    else
        -- Compatibility with 1.4.9-1.4.12 PluginData, which only stored the
        -- gained rewards. The level itself is still replayed faithfully; the
        -- forecast is reconstructed as well as the current client data allows.
        upcoming, upcomingUnavailable = buildUpcoming(result, popupLevel)
    end
    local showGainedLevels = gainedFromLevel ~= gainedToLevel
    local obtainedHeight = (#gainedEntries == 0)
        and LEVEL_MESSAGE_HEIGHT or (#gainedEntries * LEVEL_REWARD_HEIGHT)
    local upcomingHeight = (upcomingUnavailable or #upcoming == 0)
        and LEVEL_MESSAGE_HEIGHT or (#upcoming * LEVEL_REWARD_HEIGHT)

    local width = math.min(600, Turbine.UI.Display:GetWidth())
    local contentHeight = LEVEL_SECTION_HEIGHT + obtainedHeight + 10
        + LEVEL_SECTION_HEIGHT + upcomingHeight
    local listY = 92
    local bottomMargin = 18
    local desiredHeight = listY + contentHeight + bottomMargin
    local maxHeight = math.max(180, Turbine.UI.Display:GetHeight()-20)
    local needsScroll = desiredHeight > maxHeight
    -- Prefer showing the whole notification at once: the GoldWindow grows with
    -- its contents. Scrolling only exists as a last-resort safety net when the
    -- complete popup physically cannot fit on the current display.
    local height = needsScroll and maxHeight or desiredHeight

    levelWindow = Turbine.UI.Lotro.GoldWindow()
    levelWindow:SetSize(width, height)
    levelWindow:SetText(text.levelUpTitle)
    position(levelWindow)

    local intro = Turbine.UI.Label()
    intro:SetParent(levelWindow)
    intro:SetPosition(15, 35)
    intro:SetSize(width-30, 52)
    intro:SetFont(Turbine.UI.Lotro.Font.TrajanPro16)
    intro:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
    intro:SetMultiline(true)
    intro:SetText(string.format(text.levelUpMessage, safePlayerName(), popupLevel))

    local listHeight = needsScroll and math.max(60, height-listY-bottomMargin) or contentHeight
    local rewardList = Turbine.UI.ListBox()
    rewardList:SetParent(levelWindow)
    -- Keep the content itself centered even when the overflow scrollbar is
    -- present: 24 px margins normally, 29 px when 10 px are reserved at right.
    rewardList:SetPosition(needsScroll and 29 or 24, listY)
    -- When everything fits, use the full inner width and do not even create a
    -- scrollbar. This avoids the empty gutter left by a hidden ScrollBar.
    rewardList:SetSize(width-(needsScroll and 58 or 48), listHeight)
    -- Since LOTRO Update 21.2, a one-column vertical ListBox should use the
    -- native Vertical orientation. SetMaxItemsPerLine is deprecated and is
    -- intentionally not used here.
    rewardList:SetOrientation(Turbine.UI.Orientation.Vertical)

    if needsScroll then
        local scroll = Turbine.UI.Lotro.ScrollBar()
        scroll:SetParent(levelWindow)
        scroll:SetOrientation(Turbine.UI.Orientation.Vertical)
        scroll:SetPosition(width-28, listY)
        scroll:SetSize(12, listHeight)
        rewardList:SetVerticalScrollBar(scroll)
        scroll:SetVisible(true)
    end

    if showGainedLevels then
        addSectionTitle(rewardList, string.format(text.levelUpObtainedRangeTitle, gainedFromLevel, gainedToLevel))
    else
        addSectionTitle(rewardList, string.format(text.levelUpObtainedTitle, gainedToLevel))
    end
    if #gainedEntries == 0 then
        addMessageItem(rewardList, text.levelUpObtainedEmpty)
    else
        for _, entry in ipairs(gainedEntries) do
            addRewardItem(rewardList, entry, text.levelUpGainedRow, showGainedLevels)
        end
    end

    addSpacer(rewardList, 10)
    addSectionTitle(rewardList, text.levelUpUpcomingTitle)
    if upcomingUnavailable then
        addMessageItem(rewardList, text.error)
    elseif #upcoming == 0 then
        addMessageItem(rewardList, text.levelUpUpcomingEmpty)
    else
        for _, entry in ipairs(upcoming) do
            addRewardItem(rewardList, entry, text.levelUpRow, false)
        end
    end

    levelWindow:SetVisible(true)
    return result
end

controls.previous = button(mainWindow,windowWidth-350,footerY+84,110,text.previous,function() page=page-1; draw() end)
controls.following = button(mainWindow,windowWidth-165,footerY+84,110,text.following,function() page=page+1; draw() end)
button(mainWindow,25,footerY+84,135,text.refresh,function() render(true) end)
button(mainWindow,25,windowHeight-38,190,text.guide,function() showText(text.intro,text.guideText) end)
button(mainWindow,windowWidth-120,windowHeight-38,95,text.close,function() mainWindow:SetVisible(false); viewOpen=false end)

-- Options use their own small window so translations fit at every supported size.
local optionsWindow
button(mainWindow,windowWidth-280,windowHeight-38,140,text.options,function()
    if optionsWindow then optionsWindow:SetVisible(false) end
    optionsWindow = Turbine.UI.Lotro.GoldWindow()
    optionsWindow:SetText(text.optionsTitle)
    optionsWindow:SetSize(390,205)
    position(optionsWindow)
    for i,key in ipairs({"auto","scenes","traits"}) do
        local optionKey = key
        local box = Turbine.UI.Lotro.CheckBox()
        box:SetParent(optionsWindow)
        box:SetPosition(25,45+(i-1)*40)
        box:SetSize(345,30)
        box:SetText(text[key])
        box:SetChecked(settings[key])
        box.CheckedChanged = function()
            settings[optionKey] = box:IsChecked()
            save()
            if viewOpen then draw() end
        end
    end
    optionsWindow:SetVisible(true)
end)
mainWindow.PositionChanged = function()
    settings.x,settings.y = mainWindow:GetPosition()
end
mainWindow.Closed = function() viewOpen=false; save() end

local milestones = {
    [12]=MainFunction_Bree, [20]=MainFunction_EinsameLande,
    [32]=MainFunction_Bruchtal, [45]=MainFunction_Moria,
    [60]=MainFunction_Lothlorien, [70]=MainFunction_Isengart,
    [75]=MainFunction_AmonHen, [85]=MainFunction_Edoras,
    [95]=MainFunction_HelmsKlamm, [105]=MainFunction_MinasTirith,
    [106]=MainFunction_Mordor, [160]=MainFunction_GraueAnfurten
}

-- A level jump can cross an illustrated milestone without landing exactly on
-- it (for example 44 -> 46 crosses Moria at 45). Queue every crossed scene
-- in ascending level order and only open the next one after the current scene
-- closes, avoiding overlapping GoldWindows on larger jumps.
local function openCrossedMilestoneScenes(fromLevel, toLevel)
    fromLevel = tonumber(fromLevel)
    toLevel = tonumber(toLevel)
    if not fromLevel or not toLevel or toLevel < fromLevel then return end

    local queue = {}
    for level = fromLevel, toLevel do
        local openScene = milestones[level]
        if openScene then queue[#queue+1] = openScene end
    end
    if #queue == 0 then return end

    local function openNext(index)
        local openScene = queue[index]
        if not openScene then return end
        local before = #sceneWindows
        openScene()
        local window = sceneWindows[#sceneWindows]
        if #sceneWindows > before and window then
            local previousClosed = window.Closed
            window.Closed = function(sender, args)
                if previousClosed then previousClosed(sender, args) end
                openNext(index + 1)
            end
        else
            openNext(index + 1)
        end
    end

    openNext(1)
end
levelSnapshot = snapshotOf(model.Read(player))

timer.Update = function()
    if not deadline or Turbine.Engine.GetGameTime()<deadline then return end
    -- Re-check the real level immediately before refreshing snapshots. This
    -- closes the event-order race where SkillRemoved can precede LevelChanged.
    if observeLevelChange then observeLevelChange() end

    local shouldOpen,leveled = pendingOpen,pendingLevel
    local gainedEntries = pendingGainedEntries
    local gainedFromLevel,gainedToLevel = pendingGainFromLevel,pendingGainToLevel
    deadline=nil; pendingOpen=false; pendingLevel=false; pendingGainedEntries=nil
    pendingGainFromLevel=nil; pendingGainToLevel=nil
    timer:SetWantsUpdates(false)

    local postLevelResult = nil
    local remembered = nil
    if leveled then
        -- Remember every detected level-up even when the automatic popup is
        -- disabled. Along with the gains, preserve the forecast visible at that
        -- exact level so /wtme levelup can replay the same notification later.
        remembered = rememberLevelUp(gainedEntries or {}, gainedFromLevel or player:GetLevel(), gainedToLevel or player:GetLevel())
    end
    if shouldOpen and leveled then
        postLevelResult = openLevelWindow(
            gainedEntries,
            gainedFromLevel,
            gainedToLevel,
            remembered and remembered.upcoming or nil,
            remembered and remembered.upcomingUnavailable or nil
        )
    elseif shouldOpen then openWindow()
    elseif viewOpen then render(false) end

    if leveled and settings.scenes then
        openCrossedMilestoneScenes(
            gainedFromLevel or player:GetLevel(),
            gainedToLevel or player:GetLevel()
        )
    end

    if leveled then
        -- A completed level transition establishes the new clean baseline.
        levelSnapshot = snapshotOf(postLevelResult or model.Read(player))
        previousLevelSnapshot = nil
    else
        -- Normal skill-list changes refresh the baseline, but retain exactly
        -- one previous snapshot. If LevelChanged is late, obtainedBetween()
        -- can still recover a just-removed auto-learned skill from that copy.
        previousLevelSnapshot = levelSnapshot
        levelSnapshot = snapshotOf(model.Read(player))
    end
end

observeLevelChange = function()
    local level = player:GetLevel()
    if level == lastLevel then return false end
    if level > lastLevel then
        local oldLevel = lastLevel
        local snapshots = { levelSnapshot }
        if previousLevelSnapshot then snapshots[#snapshots+1] = previousLevelSnapshot end
        local gained = obtainedBetween(snapshots, oldLevel, level)
        if pendingGainedEntries == nil then pendingGainedEntries = {} end
        mergeRewards(pendingGainedEntries, gained)
        if pendingGainFromLevel == nil then pendingGainFromLevel = oldLevel + 1 end
        pendingGainToLevel = level
        lastLevel = level
        schedule(settings.auto,true)
    else
        -- Defensive handling for an unexpected effective-level decrease.
        lastLevel = level
        pendingGainedEntries=nil
        pendingGainFromLevel=nil
        pendingGainToLevel=nil
        previousLevelSnapshot=nil
        levelSnapshot = snapshotOf(model.Read(player))
        schedule(false,false)
    end
    return true
end

bind(player,"LevelChanged",function()
    observeLevelChange()
end)
watch(model.Call(player,"GetUntrainedSkills"))
local attributes = model.Call(player,"GetClassAttributes")
watch(model.Call(attributes,"GetUntrainedGambits"))

local command = Turbine.ShellCommand()
command.Execute = function(sender,name,args)
    args=string.lower((args or ""):match("^%s*(.-)%s*$"))
    if args=="help" then showText(text.intro,text.guideText)
    elseif args=="levelup" then
        if lastLevelUp then
            openLevelWindow(
                lastLevelUp.entries,
                lastLevelUp.fromLevel,
                lastLevelUp.toLevel,
                lastLevelUp.upcoming,
                lastLevelUp.upcomingUnavailable
            )
        else
            Turbine.Shell.WriteLine(text.levelUpNoneSaved)
        end
    elseif args=="diagnostic" then
        local result = model.Read(player)
        Turbine.Shell.WriteLine(string.format(text.diagnostic,#result.skills,result.filtered or 0,result.skipped,tostring(result.unavailable)))
    elseif args=="" then openWindow()
    else Turbine.Shell.WriteLine(text.help) end
end
command.GetHelp = function() return text.help end
command.GetShortHelp = function() return text.title end
Turbine.Shell.AddCommand("wtme",command)
local function unload()
    -- Catch a level transition even if its event/debounce has not completed,
    -- then persist the pending notification before the plugin disappears.
    if observeLevelChange then observeLevelChange() end
    if not persistPendingLevelUp() then save() end
    timer:SetWantsUpdates(false)
    for _,binding in ipairs(bindings) do model.RemoveCallback(binding[1],binding[2],binding[3]) end
    Turbine.Shell.RemoveCommand(command)
    closeScenes()
    mainWindow:SetVisible(false)
    if levelWindow then levelWindow:SetVisible(false) end
    if guideWindow then guideWindow:SetVisible(false) end
    if optionsWindow then optionsWindow:SetVisible(false) end
end
local plugin = Plugins and Plugins["WelcomeToMiddleEarth"]
if plugin then bind(plugin,"Unload",unload) end
Turbine.Shell.WriteLine(text.loaded)
