local module = {}

-- format: {{Name: string, Text: {string}, Speed: number, FontType: Enum.Font, Sfx: string}}
-- MUST have name and text

-- Need to rework this
-- Font and sfx of characters (soon colors)
module.characterStyles = {
	["You"] = {
		Sfx = "blip",
		Box = "e7Box",
	},
}

module.NewDay = {
	{
		Name = "You",
		Text = {
			"Wow! What a great sleep! I'm ready for a new day!",
			"The birds are chirping, the cats are purring, nothing can ruin this!",
		},
	},
}

module.SomethingRuinedIt = {
	{
		Name = "You",
		Text = {
			"Bruh.",
		},
	},
}

return module
