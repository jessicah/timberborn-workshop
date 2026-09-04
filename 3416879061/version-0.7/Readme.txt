If you're a player, You only need this mod if another mod tells you that it is required.
If you're a content creator, You may want to use the Character Customizer's Custom Beaver By Name function, Details will be below.
The main interest for this mod should be other Modders, wanting to use the tools in this mod in their own mods.

 


Feature Description:


Character Customizer:
The character customizer consists of 6 parts, including 4 that are controlled by new Specification files.
A Character is an entity definition applied to both Beavers and Bots. In the following description, if I use the word Beaver it means Beaver only, if I use the word Bot it means Bot only and if I use the word Character it means both Beavers and Bots.

Character Texture Setter:
The first and key part of the Character Customizer is the Character Texture Setter.
The primary function is to write the current texture of a Character to the save file, and apply the same texture back to the beaver when you load the game again later. It is also the controller that does all the work relating to Character Textures in the following functions.

Character Avatar Setter:
The second part of the Character Customizer is the Character Avatar Setter. First question you probably have is, what is an Avatar? Well, the that's the name of the folder the files are in, and how they're referenced by the FactionSpecification file. They're basically the icons used on the GUI to represent a specific character.
By default, the game will just use the 5 defined in the FactionSpecification file for the current faction. These are the icons for Adult Beaver, Child Beaver, Bot, Contaminated Adult Beaver and Contaminated Child Beaver. The "Avatar" line that specifies Adult Beaver is also used for the Faction Unlock icon in the Wellbeing menu.

Emberpelts has 2 different coloured beavers, and Mixed Beavers includes textures for multiple factions, so using only 1 icon to represent a character (though the beaver icon changes depending on state) isn't always enough. 
So I made this script to change icon based on a Character's Texture, see how to control that below.

Bot Textures:
The FactionSpecification file holds an array to allow you to have more than 1 texture for a Beaver. When a Beaver is created, a texture is chosen at random. Bots just use whatever texture is on the Bot material for their entity.
It turns out that the Texture changing mechanic is done on a Character level, so there's no reason why it can't be used on a bot too.

A BotTexturesSpecification will be read on game load, and the Character Texture Setter will apply them on Bot creation. These files include a Faction filter so they only apply to a specific faction, but they include a list of textures like the Beaver Textures in FactionSpecification, but they apply to Bots. This allows you to include multiple Bot textures chosen at random in the same way Beaver textures are.

To create one yourself, Simply create a JSON file named BotTexturesSpecification.Unique where Unique is a unique identifier for your file (EG: BotTexturesSpecification.Emberpelts), which includes these 2 entries. FactionID of type String to assign a faction, and BotTextures of type String Array to list the textures that should be used.

Example: BotTexturesSpecification.Emberpelts.json
{
    "FactionID": "Emberpelts",
    "BotTextures": [
        "Materials/Bots/Emberpelts/Bot1.Emberpelts",
        "Materials/Bots/Emberpelts/Bot2.Emberpelts",
        "Materials/Bots/Emberpelts/Bot3.Emberpelts",
        "Materials/Bots/Emberpelts/Bot4.Emberpelts",
        "Materials/Bots/Emberpelts/Bot5.Emberpelts",
        "Materials/Bots/Emberpelts/Bot6.Emberpelts",
        "Materials/Bots/Emberpelts/Bot7.Emberpelts",
     ]
}

Beaver Grow Up Texture Map:
Default behaviour of the game is that when a Beaver Child grows into a Beaver Adult, the Adult will be assigned a new random texture from the Textures list on FactionSpecification for the current Faction. However, like in the case of Emberpelts where there's two different coloured beavers, this could break immersion when your Charcoal fur coloured Beaver Child grows up to have Red fur, and vica verca. The same applies when using the Mixed Beavers mod and suddenly your Iron Teeth Beaver Child grows into a Folktails Beaver Adult.

When a Child Beaver grows up the Character Texture Setter will check the Beaver Grow Up Texture Map dictionary to see if the Child texture is listed, and if so pick only a texture listed to apply to the Adult Beaver.

The Beaver Grow Up Texture Map will read any BeaverGrowUpTextureMapSpecification file to build a Library. This is not keyed to a faction, as Beaver Texture files usually include the name of the faction, which allows it to work with mods such as Mixed Beavers. The BeaverGrowUpTextureMapSpecification.Unique (Again, Unique should be a unique identifier for your file, EG: BeaverGrowUpTextureMapSpecification.Emberpelts) file includes only 1 entry, TextureMaps which is an Object Array. Each TextureMaps Object has 2 variables. ChildTextureName of type String sets the name of the Child Texture and AdultTextureNames of type String Array, which sets a list of Textures to use for the Adult Beaver.
All entries on ChildTextureName must exist on the FactionSpecification ChildTextures list, and all entries on the AdultTextureNames list must exist on the FactionSpecification Textures list to function correctly. They also need to only contain the Filename of the texture, not the whole path. See Emberpelts mod for an example.

Example: BeaverGrowUpTextureMapSpecification.Emberpelts.json
{
    "TextureMaps": [
        {
            "ChildTextureName": "BeaverChild1.Emberpelts",
            "AdultTextureNames": ["BeaverAdult5.Emberpelts"]
        },
        {
            "ChildTextureName": "BeaverChild2.Emberpelts",
            "AdultTextureNames": ["BeaverAdult3.Emberpelts"]
        },
        {
            "ChildTextureName": "BeaverChild3.Emberpelts",
            "AdultTextureNames": ["BeaverAdult1.Emberpelts"]
        },
        {
            "ChildTextureName": "BeaverChild4.Emberpelts",
            "AdultTextureNames": ["BeaverAdult4.Emberpelts"]
        },
        {
            "ChildTextureName": "BeaverChild5.Emberpelts",
            "AdultTextureNames": ["BeaverAdult2.Emberpelts"]
        },
        {
            "ChildTextureName": "BeaverChild6.Emberpelts",
            "AdultTextureNames": ["BeaverAdult6.Emberpelts", "BeaverAdult7.Emberpelts", "BeaverAdult8.Emberpelts"]
        },
     ]
}

Character Avatar Map:
The Character Avatar Setter will set an appropriate icon for the Character's Texture... but how does it know what to use?

The Character Avatar Map script will read CharacterAvatarMapSpecification files on load. Again, you need to use CharacterAvatarMapSpecification.Unique where Unique is unique for your file.
A CharacterAvatarMapSpecification file has a single entry, AvatarMaps, which is an Object Array. Each object has 3 entries, TextureName, AvatarPath and ContaminatedAvatarPath, all of type String.
TextureName holds the name of a Texture to be used on a Character, Filename only, not the whole Path, while TextureName and ContaminatedAvatarPath list an Icon's Path, the full file path within the mod, not just the filename. Since Bots, Beaver Child and Beaver Adult all use a different name, it wasn't necessary to filter how the icons are applied. ContaminatedAvatarPath is optional and will be ignored if specified on a Bot. See Emberpelts mod for an example.

Example: CharacterAvatarMapSpecification.Folktails.json
{
    "AvatarMaps":
    [
        {
            "TextureName": "BeaverChild1.Folktails",
            "AvatarPath": "Sprites/Avatars/FolktailsChild",
            "ContaminatedAvatarPath": "Sprites/Avatars/FolktailsContaminatedChild"
        },
        {
            "TextureName": "BeaverChild2.Folktails",
            "AvatarPath": "Sprites/Avatars/FolktailsChild",
            "ContaminatedAvatarPath": "Sprites/Avatars/FolktailsContaminatedChild"
        },
        {
            "TextureName": "BeaverChild3.Folktails",
            "AvatarPath": "Sprites/Avatars/FolktailsChild",
            "ContaminatedAvatarPath": "Sprites/Avatars/FolktailsContaminatedChild"
        },
        {
            "TextureName": "BeaverAdult1.Folktails",
            "AvatarPath": "Sprites/Avatars/FolktailsAdult",
            "ContaminatedAvatarPath": "Sprites/Avatars/FolktailsContaminatedAdult"
        },
        {
            "TextureName": "BeaverAdult2.Folktails",
            "AvatarPath": "Sprites/Avatars/FolktailsAdult",
            "ContaminatedAvatarPath": "Sprites/Avatars/FolktailsContaminatedAdult"
        },
        {
            "TextureName": "BeaverAdult3.Folktails",
            "AvatarPath": "Sprites/Avatars/FolktailsAdult",
            "ContaminatedAvatarPath": "Sprites/Avatars/FolktailsContaminatedAdult"
        },
        {
            "TextureName": "BeaverAdult4.Folktails",
            "AvatarPath": "Sprites/Avatars/FolktailsAdult",
            "ContaminatedAvatarPath": "Sprites/Avatars/FolktailsContaminatedAdult"
        },
        {
            "TextureName": "BeaverAdult5.Folktails",
            "AvatarPath": "Sprites/Avatars/FolktailsAdult",
            "ContaminatedAvatarPath": "Sprites/Avatars/FolktailsContaminatedAdult"
        },
    ]
}

Custom Beaver By Name:
This is the part that content creators might also be interested in.

This script will read CustomBeaverByNameSpecification JSON files. The file format should be CustomBeaverByNameSpecification.Unique, where Unique is the Beaver's name. The file holds 6 entries: Name, Texture, Avatar, ChildAvatar, ContaminatedAvatar and ContaminatedChildAvatar, all of type String.
Name is the name of the Beaver. If any beaver in the game has this name, then Character Texture Setter and Character Avatar Setter will alter the beaver accordingly. The name will be added to the Name's list to be random used during gameplay.
Texture should contain the full Path for a texture to use for this beaver. It will be applied to both Child and Adult beavers. Currently there is no Entry to have a unique texture for the Child. If no Texture is specified, then one will be chosen at random from the list on FactionSpecification.
ChildTexture can contain the full path for a texture to use for this beaver when it's in child form. if not specified, the normal Texture entry will be used for both Child and Adult.
Avatar, ChildAvatar, ContaminatedAvatar and ContaminatedChildAvatar each list the full path for an icon to use in each of the 4 beaver states. If no Child icon is listed, the Adult version will be used. If no Contaminated icon is listed, then the Normal version will be used. If no icons are listed at all, then the script will default to previous behaviour and try to use an appropriate icon, or faction default.
There is now also a ExcludeFromNamePool entry. If this exists, the name isn't added to the name pool.

Example: CustomBeaverByNameSpecification.Jimbo.json
{
    "Name": "Jimbo",
    "ExcludeFromNamePool": "True",
    "Texture": "CustomBeavers/Textures/BeaverAdult.Gold",
    "ChildTexture": "CustomBeavers/Textures/BeaverChild.Gold",
    "Avatar": "CustomBeavers/Avatars/GoldAdult",
    "ChildAvatar": "CustomBeavers/Avatars/GoldChild",
    "ContaminatedAvatar": "CustomBeavers/Avatars/GoldContaminatedAdult",
    "ContaminatedChildAvatar": "CustomBeavers/Avatars/GoldContaminatedChild"
}

There is now also a CustomBeaverByNameListSpecification that lets you specify a list of names to use a graphics set. This is the same as CustomBeaverByNameSpecification except the Name entry is replaced with a Names entry, which takes an Array of strings.

Example: CustomBeaverByNameListSpecification.Gold
{
    "Names": [
        "Larry", "Curly", "Moe",
        "Jimbo", "Dolph", "Kearney",
        "Nelson"
    ],
    "Texture": "CustomBeavers/Textures/BeaverAdult.Brass",
    "ChildTexture": "CustomBeavers/Textures/BeaverChild.Brass",
    "Avatar": "CustomBeavers/Avatars/BrassAdult",
    "ChildAvatar": "CustomBeavers/Avatars/BrassChild",
    "ContaminatedAvatar": "CustomBeavers/Avatars/BrassContaminatedAdult",
    "ContaminatedChildAvatar": "CustomBeavers/Avatars/BrassContaminatedChild"
}

Note: you can add your own Beaver Textures and Icons too. Each should be a Square PNG file with dimensions matching the 2^n size, such as 512x512 for icons, and 1024x1024 or 2048x2048 for textures. Each Icon also needs to be set up with a meta file. The easiest way to get a meta file is to copy an existing one and rename to match your icon. EG: GoldAdult.png icon file has a GoldAdult.png.meta.json file too.

There is also now a CustomBeaverNamesListSpecification option, that lets you just add a list of names.
Setting ReplaceNames to true will delete the names list before adding names, false will leave the existing names on the list.
The Names entry takes an array of strings, one each for each beaver name to add.

Example: CustomBeaverNamesListSpecification.Emberpelts
{
    "ReplaceNames": false,
    "Names": [
        "Tobbert",
        "Battery Smooth",
        "Bobingabout",
        "Lapantouflemagic",
    ],
}



Material Patcher:
The Material Patcher was oringinally written for the Emberpelts mod. Over time I slowly expanded it to make it more customisable. 
There are 4 components to it.

Material Patch:
The first key part. It lets you change Colours and Textures of a material in the game. You want Berry Bushes to look different for a specific faction? replace the texture. Since you can change a lot on each material, Each material has it's own MaterialPatchSpecification file, also filtered by Faction.

Example: MaterialPatchSpecification.Emberpelts.AdvancedBreedingWater.json
{
    "FactionID": "Emberpelts",
    "MaterialName": "AdvancedBreedingWater",
    "TextureEntries": [],
    "ColorEntries": [
        { "Name": "_Color", "Colour": "0.8,0.1,0.1,1.0"},
        { "Name": "_Emission_Map_Color", "Colour": "0.8,0.1,0.3,1.0"},
        { "Name": "_FoamColor", "Colour": "0.8,0.2,0.1,1.0"}
    ],
    "NumberEntries": []
}

Example: MaterialPatchSpecification.Emberpelts.BlueberryBush.json
{
    "FactionID": "Emberpelts",
    "MaterialName": "BlueberryBush",
    "TextureEntries": [
        { "Name": "_MainTex", "Path": "Materials/UberAtlas/Textures/Emberpelts/Blueberry_D.Emberpelts" }
    ],
    "ColorEntries": [],
    "NumberEntries": []
}

Shader Patch:
Modded materials can function incorrectly in the game, and it seems to be a bug with the Shaders. If your material seems to be invisible, try patching the Shader. This is usually the case on Planes, such as those used in Pile Storage. A ShaderPatchSpecification file lets you specify a donor material, and materials to patch, where the Material Patcher will copy the Shader from the Donor to the Patch materials.

Example: ShaderPatchSpecification.Emberpelts.json
{
    "FactionID": "Emberpelts",
    "DonorName": "DirtPile",
    "MaterialNames": [ "ClayPile", "CoalPile" ],
}

Water Shader Patch:
Identical to above, but specifically for Water type planes. For some reason, the Foam layer of liquids, which usually exists at the edge of the plane, don't function correctly even after being patched. The least offensive looking fix I've seen is to set the Foam layer to transparent. Water Shader Patch does the same as Shader Patch, but also deletes the foam.

Example: WaterShaderPatchSpecification.Emberpelts.json
{
    "FactionID": "Emberpelts",
    "DonorName": "Water",
    "MaterialNames": [ "AppleJuice", "TomatoJuice", "RedJuice", "CornJuice" ]
}

Building Prefab Material Patch:
A BuildingPrefabMaterialPatchSpecification file lets you specify a list of materials, and what material to change them to. To catch both Unity assets and Timbermesh files, this is performed on the Start function after all the post-processing is complete. As a result this is a buggy one, as Color tints have no effect. Plus some vanilla Materials seem to be placed on an atlas, which is likely done to save graphics processing power and memory, but means they're not replaced by my script here.

Example: BuildingPrefabMaterialPatchSpecification.Emberpelts.GoodsStation.json
{
    "FactionID": "Emberpelts",
    "PrefabName": "GoodsStation.Folktails",
    "MaterialEntries": [
	    {
	    	"MaterialName": "BaseWood_Brown.Folktails",
	    	"NewMaterialName": "BaseWood_Brown.Emberpelts",
	    },
	    {
	    	"MaterialName": "Details.Folktails",
	    	"NewMaterialName": "Details.Emberpelts",
	    },
    ]
}

Liquid Good Material Patch:
Loaded with LiquidGoodMaterialPatchSpecification, a new version of the Water Shader Patch that fixes visiblity of materials on Goods in the liquid Storage Tank. It creates a duplicate of a Donor material, EG Water, and copies all the entries from the material you want to use for the liquid onto it.

Example: LiquidGoodMaterialPatchSpecification.Emberpelts.json
{
    "FactionID": "Emberpelts",
    "DonorMaterialName": "Water",
    "GoodNames": [ "AppleJuice", "TomatoJuice", "RedJuice", "CornJuice" ]
}

Liquid Good Material Clone:
A hybrid combination of MaterialPatchSpecification and LiquidGoodMaterialPatchSpecification. It can be used to replace or add a material for a liquid good, by cloning an existing material and applying it to a good to display in a Storage Tank.
Example: LiquidGoodMaterialCloneSpecification.Emberpelts.TomatoJuice
{
    "FactionID": "Emberpelts",
    "GoodName": "TomatoJuice",
    "DonorMaterialName": "Coffee",
    "TextureEntries": [
        { "Name": "_MainTex", "Path": "Materials/Goods/Textures/TomatoJuice"}
    ],
    "ColorEntries": [
        { "Name": "_Color", "Colour": "0.7,0.7,0.7,1.0"},
        { "Name": "_Emission_Map_Color", "Colour": "0.1,0.1,0.1,1.0"},
        { "Name": "_FoamColor", "Colour": "0.8,0.2,0.1,1.0"}
    ],
    "NumberEntries": []
}
 

Building Scripts:
Bobingabout.Misc.dll, Bobingabout.StockpileVisualizer.dll and Bobingabout.AutomatedManufactory.dll hold Scripts that can be used in a Unity Project to add functionality to your buildings. You'll need to add them to your project somehow so they can be referenced using the GUID system.

Animation Controller:
Part of Bobingabout.Misc.dll, any building that this is applied to will just unconditionally run it's Animation constantly.

Bobingabout Stockpile Visualizer Good Pile Spec:
Part of Bobingabout.StockpileVisualizer.dll, this functions like the vanilla Stockpile Good Pile Visualizer Spec on Pile Storages for displaying non-plane items in the storage. The Vanilla version uses 1 item per 1 unit in storage. The Stockpile Good Column Visualizer Spec calculates how many boxes will fill the area of the building, and scales the number of boxes per unit in storage accordingly.
My Bobingabout Stockpile Visualizer Good Pile Spec script is a copy of the vanilla Stockpile Good Pile Visualizer Spec, with an extra variable for max height, and performs calculations similar to the The Stockpile Good Column Visualizer Spec so that when the storage is full, it neatly fills the building area.

Automated Manufactory Power Consumption Switch:
Part of Bobingabout.AutomatedManufactory.dll, designed for the Automated Water Pump in Emberpelts, this script allows a building to stop drawing power when the building stops working, without having to have workers in the building. It should be used with the Production Increased script normally used by the Number Cruncher, instead of any Workplace related scripts.

Automated Manufactory Animation Controller:
Part of Bobingabout.AutomatedManufactory.dll, designed for the Automated Water Pump in Emberpelts, this script controls the Animation, and stops the animation running when the recipe cannot progress. It functions similar to the Workshop Animation Controller, but runs on the Manufactory level, rather than the Workshop level.

 