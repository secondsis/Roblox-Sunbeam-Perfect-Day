local module = {}

-- format: {{Name: string, Text: {string}, Speed: number, FontType: Enum.Font, Sfx: string}}
-- MUST have name and text

-- Need to rework this
-- Font and sfx of characters (soon colors)
module.characterStyles = {
	["You"] = {
		Sfx = "blip_high",
		Box = "DefaultBox",
	},
	["Maxwell"] = {
		Sfx = "omori",
		Box = "DefaultBox",
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
			"Where are my friends?",
		},
	},
}

module.FoundMaxwell = {
	{
		Name = "You",
		Text = {
			"Hello, kitty!",
		},
	},
	{
		Name = "Maxwell",
		Text = {
			"mreeooow",
		},
	},
}

module.FoundFrog = {
	{
		Name = "You",
		Text = {
			"Ribbit!",
		},
	},
}

module.FoundSquirrel = {
	{
		Name = "You",
		Text = {
			"Hello squirrl!!!!",
		},
	},
}

module.FoundAlready = {
	{
		Name = "You",
		Text = {
			"I found this animal already.",
		},
	},
}

module.FoundAll = {
	{
		Name = "You",
		Text = {
			"I found all the animals!",
		},
	},
}

return module
