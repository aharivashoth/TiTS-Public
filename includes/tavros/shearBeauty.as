﻿import classes.Creature;
//AUTHOR - COUCH!

//Room Descriptions
//Added to room on Tavros outside the salon


//output("\n\nA neon sign displaying a pair of scissors sits next to a small store entrance with its doors propped open, allowing you a glimpse of the salon inside. The sign above the door labels it as Shear Beauty.");

public function showCeria(nude:Boolean = false):void
{
	showName("\nCERIA");
	if(nude) showBust("CERIA_NUDE");
	else showBust("CERIA");
}

public function fuckedCeria(setItUp:Boolean = false):Boolean
{
	if(setItUp) IncrementFlag("FUCKED_CERIA");
	return (flags["FUCKED_CERIA"] != undefined);
}

// Price conversion
public function ceriaServicePrice(price:Number = 0):Number
{
	if(pc.hasKeyItem("Coupon - Shear Beauty")) price = Math.round(price * pc.keyItemv1("Coupon - Shear Beauty"));
	return price;
}

//Salon
public function shearBeautyBonusFunc():Boolean
{
	author("Couch");
	output("Shear Beauty is a nicely kept hair salon, with white tile flooring and darker gray walls lined with shelves of hair care products and pictures of various fashion models. Currently the waiting lounge is empty, allowing you to go straight to the front counter if you please. Beyond it you can see three sets of salon chairs along the right wall, while along the left is what looks like a massage table with a privacy screen currently open. In the back you can see the entrance to what must be the employee break room.");
	output("\n\n");
	if(flags["MET_CERIA"] == undefined)
	{
		showBust("CERIA");
		output("A well-tanned girl with sparkling pink hair accentuated by a pair of long, pointed ears is leaning at the counter, chewing bubblegum. Her ears hang a little low of horizontal, but twitch upward as she notices you.");
		//[Counter Girl] Go to Ceria Intro, replace this button with Ceria
		addButton(0,"Counter Girl",approachCeria);
	}
	else
	{
		showBust("CERIA");
		output("Ceria is leaning at the counter, idly blowing and popping her bubblegum. Her ears twitch upward as she sees you, the elf girl pausing in her chewing to grin at you.");
		//[Ceria] Go to Ceria Main
		addButton(0,"Ceria",approachCeria);
	}
	return false;
}

//Meeting the Stylist
public function approachCeria():void
{
	clearOutput();
	showCeria();
	author("Couch");
	//Ceria Intro
	if(flags["MET_CERIA"] == undefined)
	{
		flags["MET_CERIA"] = 1;
		output("<i>“Welcome to Shear Beauty! I’m Ceria, I’ll be your stylist today. Here for a haircut, " + pc.mfn("Mister","Miss","") + "...?”</i>");
		if(pc.isBimbo()) output("\n\n<i>“It’s like, [pc.name]. This place is super cute!”</i>");
		else if(pc.isBro()) output("\n\n<i>“[pc.name]. I’m jus’ lookin’”</i>");
		else output("\n\n<i>“It’s [pc.name]. And maybe, just looking around right now.”</i>");

		output("\n\n<i>“Well, [pc.name], we do trimming, lengthening, coloring and styling here. We’ve also got products you can take home over here on the left.”</i> Ceria gestures towards the rows of bottles, conditioners, and medipens on display. <i>“Just let me know what you want, ‘kay?”</i>");

		//[Next] Go to Ceria Main
		processTime(2);
	}
	//Ceria Main
	else
	{
		output("<i>“Hey, [pc.name]. Here for some styling, or buying some hair care products to take home?”</i>");
		//PC has unlocked sex:
		if(fuckedCeria()) output(" Ceria leans forward with a playful grin to show a little bit more cleavage. <i>“Maybe something more fun?”</i>");
		processTime(1);
	}
	ceriaMenu();
}

public function ceriaMenu():void
{
	showCeria();
	clearMenu();
	addButton(0,"Shop",buyFromCeria,undefined,"Shop","Buy some beautication products or gene-mods.");
	addButton(1,"Styling",hairworkFromCeria,undefined,"Styling","Get your hair lengthened, cut, or dyed!");
	addButton(2,"Talk",ceriaTalk,undefined,"Talk","Talk to Ceria.");
	addButton(3,"Appearance",ceriaAppearance,undefined,"Appearance","Take a good look a the elfin proprietor.");
	if(fuckedCeria() && pc.lust() >= 33) addButton(4,"Sex",ceriseSexApproach,undefined,"Sex","She seems like she’d be into it...");
	else if(fuckedCeria()) addDisabledButton(4,"Sex","Sex","You aren’t aroused enough for sex right now.");
	else addDisabledButton(4,"Sex","Sex","You’ll need to get to know her first!");
	addButton(14,"Leave",mainGameMenu);
}
/*
[Shop] Go to Ceria Shop
[Styling] Go to Hairwork
[Talk] Go to Ceria Talk
[Appearance] Go to Ceria Appearance
[Sex] Go to Sex Menu, gray out until Ceria Ears has been run
[Back] Exit dialogue
*/

//Buying Things For Later
//Ceria Shop
/* set up shop shit
output("\n\nCeria gestures to the shelf of hair care products on your left. <i>“Alright, grab whatever you want off the shelf and I’ll ring it up for you.”</i>");

output("\n\nYou let your eyes roam across the various shampoos and conditioners on sale. You also see a rack with several teardrop-shaped medipens in a variety of colors.");

output("\n\n{First time viewing: <i>“What are those?”</i> you ask, pointing towards the medipens.");

output("\n\n<i>“Oh, those are our Sylvanol-brand transformatives. I’ve gotten pretty into them myself. If you’re jealous of these-”</i> She gives you a wink as she twitches her lengthy ears. <i>“-you should give them a try. They’re an adjustable medipen, you just twist that dial near the top and they cycle between a few different settings.”</i>}");

output("\n\n{No items exist to be sold: Honestly nothing here looks all that appealing. Maybe they’ll restock with something worth the credits later on.}");

output("\n\n[Back] Go to Ceria Main");
*/

public function buyFromCeria():void
{
	shopkeep = chars["CERIA"];
	chars["CERIA"].keeperBuy = "Ceria gestures to the shelf of hair care products on your left. <i>“Alright, grab whatever you want off the shelf and I’ll ring it up for you.”</i>\n\nYou let your eyes roam across the various shampoos and conditioners on sale. You also see a rack with several teardrop-shaped medipens in a variety of colors.";
	if(flags["CERIA_BOUGHT"] == undefined)
	{
		chars["CERIA"].keeperBuy += "\n\n<i>“What are those?”</i> you ask, pointing towards the medipens.\n\n<i>“Oh, those are our Sylvanol-brand transformatives. I’ve gotten pretty into them myself. If you’re jealous of these-”</i> She gives you a wink as she twitches her lengthy ears. <i>“-you should give them a try. They’re an adjustable medipen, you just twist that dial near the top and they cycle between a few different settings.”</i>";
		
		flags["CERIA_BOUGHT"] = 0;
	}
	else
	{
		if(flags["UNLOCKED_JUNKYARD_PLANET"] != undefined)
		{
			chars["CERIA"].keeperBuy += " Off to the side, there is a clear jar that contains a number of white gumball-like pills.";
			if(!chars["CERIA"].hasItemByClass(Hornitol)) chars["CERIA"].inventory.push(new Hornitol());
			if(!chars["CERIA"].hasItemByClass(Hornucopia)) chars["CERIA"].inventory.push(new Hornucopia());
		}
		else
		{
			chars["CERIA"].destroyItemByClass(Hornitol, -1);
			chars["CERIA"].destroyItemByClass(Hornucopia, -1);
		}
		if(flags["PLANET_3_UNLOCKED"] != undefined || CodexManager.entryViewed("Rubber-Made"))
		{
			chars["CERIA"].keeperBuy += " Another rack holds what seem to be various tubes of skin";
			if(flags["PLANET_3_UNLOCKED"] != undefined)
			{
				if(!chars["CERIA"].hasItemByClass(DoveBalm)) chars["CERIA"].inventory.push(new DoveBalm());
				chars["CERIA"].keeperBuy += " balms";
			}
			else chars["CERIA"].destroyItemByClass(DoveBalm, -1);
			if(flags["PLANET_3_UNLOCKED"] != undefined && CodexManager.entryViewed("Rubber-Made")) chars["CERIA"].keeperBuy += " and";
			if(CodexManager.entryViewed("Rubber-Made"))
			{
				if(!chars["CERIA"].hasItemByClass(SkinClear)) chars["CERIA"].inventory.push(new SkinClear());
				chars["CERIA"].keeperBuy += " lotions";
			}
			else chars["CERIA"].destroyItemByClass(SkinClear, -1);
			chars["CERIA"].keeperBuy += ".";
		}
		else
		{
			chars["CERIA"].destroyItemByClass(DoveBalm, -1);
			chars["CERIA"].destroyItemByClass(SkinClear, -1);
		}
		
		// 9999 - Temporary placement until Aislinn is implemented!
		if(9999 == 9999)
		{
			chars["CERIA"].keeperBuy += " Next to a small holo-mirror is a display holding an array of lip balms.";
			if(!chars["CERIA"].hasItemByClass(LipTease)) chars["CERIA"].inventory.push(new LipTease());
		}
		else chars["CERIA"].destroyItemByClass(LipTease, -1);
	}
	chars["CERIA"].keeperBuy += "\n";
	//List prices and whatnot. Back should go back to CERIA's main menu.
	//Sell Menu
	chars["CERIA"].keeperGreeting = "RUH ROH! SOMETHING WENT WRONG.";
	itemScreen = mainGameMenu;
	lootScreen = mainGameMenu;
	useItemFunction = mainGameMenu;
	buyItem();
}

//Doing The Thing You’re Probably Here For
//Main Menu
//Hairwork
public function hairworkFromCeria():void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("As soon as you tell her that you want your hair done, Ceria takes the bubblegum out of her mouth and tosses it out, putting on a professional air. Even her ears tilt backwards to emphasize themselves less.");
	output("\n\n<i>“Lengthening, cutting, coloring or styling?");
	if(!pc.hasHair()) output(" I mean, not that you have anything to work with, but I can fix that easy enough if you want.");
	if(pc.hasPartFur() || pc.hasPartFeathers()) output(" I can also do a color job on that fur of yours.");
	output("”</i>");

	processTime(1);
	//[Lengthen] Go to Lengthen Options
	//[Cut] Go to Cut Options
	//[Hair Color] Go to Hair Color Options
	//[Style] Go to Style Options
	//[Fur Color] Go to Fur Color Options
	//[Back] Go to Ceria Main
	clearMenu();
	if(pc.hairLength <= 0) addButton(0,"Lengthen",lengthenHairChoices,undefined,"Lengthen Hair","Grow some hair.");
	else addButton(0,"Lengthen",lengthenHairChoices,undefined,"Lengthen Hair","Get your hair lengthened.");
	if(pc.hairLength > 0) addButton(1,"Cut",getHairCut,undefined,"Cut Hair","Get your hair cut down to size.");
	else addDisabledButton(1,"Cut","Cut Hair","You need hair in order to get it cut.");
	if(pc.hairLength > 0) addButton(2,"Color",hairColorMainMenu,undefined,"Color Hair","Try out a new color!");
	else addDisabledButton(2,"Color","Color Hair","You need something on your head to dye!");
	if(pc.hairLength <= 0) addDisabledButton(3,"Style","Style Hair","You need some hair in order to style it!");
	else if(InCollection(pc.hairType, GLOBAL.HAIR_TYPE_REGULAR, GLOBAL.HAIR_TYPE_QUILLS)) addButton(3,"Style",ceriaHairStyleChoices,undefined,"Style Hair","Get your hair styled into something fashionable.");
	else addDisabledButton(3,"Style","Style Hair","You can only get traditional hair styled here.");
	if(pc.hasFur() && pc.perkv1("Wooly") >= 1) addButton(6,"Fur Shear",furShearMenu,undefined,"Shear Fur","Get your wooly fur sheared!");
	else addDisabledButton(6,"Fur Shear","Shear Fur","You don’t have any wooly fur to shear!");
	if(pc.hasPartFur() || pc.hasPartFeathers()) addButton(7,"Fur Color",furColorMenu,undefined,"Color Fur","Get your fur dyed too!");
	else addDisabledButton(7,"Fur Color","Color Fur","You don’t have fur to dye!");
	addButton(14,"Back",approachCeria);
}
public function serviceFromCeriaFinish(removeCoupon:Boolean = true):void
{
	flags["CERIA_BOUGHT"] = 1;
	if(removeCoupon && pc.hasKeyItem("Coupon - Shear Beauty")) pc.removeKeyItem("Coupon - Shear Beauty");
	approachCeria();
}

//Ceria Lengthens Your Hair
//Lengthen Options
public function lengthenHairChoices():void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("<i>“Alright, what kind of length are you looking for? Remember I’ll have to redo your hairstyle after this if you’re not gonna just wear it loose. We charge by the inch, and it’s pretty expensive. The nano-gel doesn’t come cheap! I’ll give you your total when you tell me what you want.”</i>");

	//[All below options go to Lengthen Confirmation, gray out options PC already exceeds or can’t afford]
	//[Short] 2
	//[Shoulders] 8
	//[Long] 13
	//[Back Length] tallness/2.6! if (hairLength < tallness / 2.5)
	//[Ass Length] tallness/2 if (hairLength < tallness / 1.7)
	//[Knee Length] tallness / 1.4
	//[Ankle Length] tallness - 1
	//[Back] Go to Hairwork
	processTime(1);
	clearMenu();
	var btn:int = 0;
	if(pc.hairLength < 2) addButton(btn++,"Short",lengthenHairConfirmation,2);
	else addDisabledButton(btn++,"Short","Short","Your hair is already longer than that!");
	if(pc.hairLength < 4) addButton(btn++,"Ear Length",lengthenHairConfirmation,4);
	else addDisabledButton(btn++,"Ear Length","Ear Length","Your hair is already longer than that!");
	if(pc.hairLength < 6) addButton(btn++,"Neck Length",lengthenHairConfirmation,6);
	else addDisabledButton(btn++,"Neck Length","Neck Length","Your hair is already longer than that!");
	if(pc.hairLength < 8) addButton(btn++,"Shoulders",lengthenHairConfirmation,8);
	else addDisabledButton(btn++,"Shoulders","Shoulders","Your hair is already longer than that!");
	if(pc.hairLength < 13) addButton(btn++,"Long",lengthenHairConfirmation,13);
	else addDisabledButton(btn++,"Long","Long","Your hair is already longer than that!");
	if(pc.hairLength < (pc.tallness/2.6)) addButton(btn++,"Back Length",lengthenHairConfirmation,(pc.tallness/2.6));
	else addDisabledButton(btn++,"Back Length","Back Length","Your hair is already longer than that!");
	if(pc.hairLength < (pc.tallness/2)) addButton(btn++,"Ass Length",lengthenHairConfirmation,(pc.tallness/2));
	else addDisabledButton(btn++,"Ass Length","Ass Length","Your hair is already longer than that!");
	if(pc.hairLength < (pc.tallness/1.6)) addButton(btn++,"Thigh Length",lengthenHairConfirmation,(pc.tallness/1.6));
	else addDisabledButton(btn++,"Thigh Length","Thigh Length","Your hair is already longer than that!");
	if(pc.hairLength < (pc.tallness/1.4)) addButton(btn++,"Knee Length",lengthenHairConfirmation,(pc.tallness/1.4));
	else addDisabledButton(btn++,"Knee Length","Knee Length","Your hair is already longer than that!");
	if(pc.hairLength < (pc.tallness/1.2)) addButton(btn++,"Calf Length",lengthenHairConfirmation,(pc.tallness/1.2));
	else addDisabledButton(btn++,"Calf Length","Calf Length","Your hair is already longer than that!");
	if(pc.hairLength < (pc.tallness - 1)) addButton(btn++,"Ankle Length",lengthenHairConfirmation,(pc.tallness - 1));
	else addDisabledButton(btn++,"Ankle Length","Ankle Length","Your hair is already longer than that!");
	if(pc.hairLength < pc.tallness) addButton(btn++,"Floor Length",lengthenHairConfirmation,pc.tallness);
	else addDisabledButton(btn++,"Floor Length","Floor Length","Your hair is already longer than that!");
	addButton(13,"Extend",lengthenHairConfirmation,(pc.hairLength + 1));
	addButton(14,"Back",hairworkFromCeria);
}

//Lengthen Confirmation
public function lengthenHairConfirmation(hairInches:Number = 0):void
{
	clearOutput();
	showCeria();
	author("Couch");
	
	hairInches = Math.round(hairInches);
	
	output("<i>“");
	if(hairInches <= 1) output("Wanna go super short?");
	else if(hairInches <= 2) output("Short and simple, huh?");
	else if(hairInches <= 4) output("Okay, ear-length.");
	else if(hairInches <= 6) output("Ah, neck-length it is.");
	else if(hairInches <= 8) output("Shoulder-length, my kind of " + pc.mf("guy","girl") + ".");
	else if(hairInches <= 13) output("Alright, long it is.");
	else if(hairInches <= pc.tallness/2.6) output("Well, back length is certainly doable.");
	else if(hairInches <= pc.tallness/2) output("You really do love it long, don’t you?");
	else output("Shit, really, that long? Alright, you’re the customer.");
	output("”</i> Ceria pulls out a piece of measuring tape, checking out your existing hair");
	if(!pc.hasHair()) output(", or lack thereof");
	output(". <i>“With how much you’ve already got, it’ll be ");
	var cost:Number = Math.round((hairInches - pc.hairLength) * 150);
	output(ceriaServicePrice(cost) + " credits. That good with you?”</i>");
	
	processTime(2);
	
	clearMenu();
	if(pc.credits >= ceriaServicePrice(cost)) addButton(0,"Okay",payTheLadyForLongHair,hairInches);
	else addDisabledButton(0,"Okay","Okay","You can’t pay for that!");
	//[OK] Go to Lengthen Treatment
	//[Nevermind] Go to Ceria Main
	addButton(1,"Nevermind",lengthenHairChoices);
}

//Lengthen Treatment
public function payTheLadyForLongHair(hairInches:Number):void
{
	clearOutput();
	showCeria();
	author("Couch");
	
	var cost:Number = Math.round((hairInches - pc.hairLength) * 150);
	
	if(!fuckedCeria())
	{
		output("Ceria double-checks the length on her tape and taps her tablet a few times before plugging it into a dispenser which soon spits out a small container of a dull gray hair gel. The elven girl sits you down in one of the salon chairs and sets to work rubbing the gel into your scalp, not stopping until she’s used up the entire container’s worth. As she does, you can feel inch after inch of new hair spilling forth, growing out with every motion of Ceria’s fingers until finally it winds down to a stop. The stylist steps aside to wash her gloved hands clean of any lingering gel, allowing you time to admire your new look in the mirror. <b>Your hair is now " + num2Text(hairInches) + " inches long!</b>");
	}
	else
	{
		output("Ceria double-checks the length on her tape and taps her tablet a few times before plugging it into a dispenser which soon spits out a small container of a dull gray hair gel. The elven girl sits you down in one of the salon chairs and sets to work rubbing the gel into your scalp. Her flawlessly smooth fingers are heavenly on your [pc.skinFurScalesNoun], and she teases them in slow circles as inch after inch of new hair spills forth around them.");
		output("\n\n<i>“Look at all that, [pc.name]. You look so much hotter with your hair grown out, " + pc.mf("so wild and manly","so cute and girly") + " . Let it all spill out, let me tease out every - last - inch.”</i> The last three words are spoken as breaths blown across your ear from behind, feeling as if they’re accompanied by your new length jumping out in response. Finally the flowing feeling in your scalp draws to a close as your hair ceases its growth, and Ceria draws back, the salon mirror giving you a glimpse of her licking her lips at the view of your face framed by your new hair. The stylist steps aside to wash her gloved hands clean of any lingering gel, allowing you time to admire your new look in the mirror. <b>Your hair is now " + num2Text(hairInches) + " inches long!</b>");
	}
	//[Next] Set [pc.hairstyle] to null and go to Ceria Main
	processTime(33);
	
	pc.hairLength = hairInches;
	pc.hairStyle = "null";
	pc.credits -= ceriaServicePrice(cost);
	
	clearMenu();
	addButton(0,"Next",serviceFromCeriaFinish);
}

//Ceria Does Your Haircut
//Cut Options
public function getHairCut():void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("<i>“It’ll be " + ceriaServicePrice(200) + " credits a haircut and " + ceriaServicePrice(100) + " for a minor trim, how short do you want it? Remember, I’ll have to restyle your hair after you cut it unless you just want it hanging loose.”</i>");
	processTime(1);
	//[All below options go to Cut Treatment, gray out options PC is already shorter than or can’t afford]
	//[Short]
	//[Shoulders]
	//[Long]
	//[Ass-Length]
	//[Ankle-Length]
	//[Back] Go to Ceria Hairwork
	var btn:int = 0;
	if (pc.credits >= ceriaServicePrice(200) && pc.hairLength > 0) addButton(btn++, "Shave", cutHair, 0);
	else if(pc.hairLength > 0) addDisabledButton(btn++, "Shave", "Shave", "You can’t afford that!");
	else addDisabledButton(btn++, "Shave", "Shave", "You need hair in order to get it cut!");
	if(pc.credits >= ceriaServicePrice(200) && pc.hairLength > 2) addButton(btn++,"Short",cutHair,2);
	else if(pc.hairLength > 2) addDisabledButton(btn++,"Short","Short","You can’t afford that!");
	else addDisabledButton(btn++,"Short","Short","Your hair is already shorter than that!");
	if(pc.credits >= ceriaServicePrice(200) && pc.hairLength > 4) addButton(btn++,"Ear Length",cutHair,4);
	else if(pc.hairLength > 4) addDisabledButton(btn++,"Ear Length","Ear Length","You can’t afford that!");
	else addDisabledButton(btn++,"Ear Length","Ear Length","Your hair is already shorter than that!");
	if(pc.credits >= ceriaServicePrice(200) && pc.hairLength > 6) addButton(btn++,"Neck Length",cutHair,6);
	else if(pc.hairLength > 6) addDisabledButton(btn++,"Neck Length","Neck Length","You can’t afford that!");
	else addDisabledButton(btn++,"Neck Length","Neck Length","Your hair is already shorter than that!");
	if(pc.credits >= ceriaServicePrice(200) && pc.hairLength > 8) addButton(btn++,"Shoulders",cutHair,8);
	else if(pc.hairLength > 8) addDisabledButton(btn++,"Shoulders","Shoulders","You can’t afford that!");
	else addDisabledButton(btn++,"Shoulders","Shoulders","Your hair is already shorter than that!");
	if(pc.credits >= ceriaServicePrice(200) && pc.hairLength > 13) addButton(btn++,"Long",cutHair,13);
	else if(pc.hairLength > 13) addDisabledButton(btn++,"Long","Long","You can’t afford that!");
	else addDisabledButton(btn++,"Long","Long","Your hair is already shorter than that!");
	if(pc.credits >= ceriaServicePrice(200) && pc.hairLength > pc.tallness/2.6) addButton(btn++,"Back Length",cutHair,pc.tallness/2.6);
	else if(pc.hairLength > pc.tallness/2.6) addDisabledButton(btn++,"Back Length","Back Length","You can’t afford that!");
	else addDisabledButton(btn++,"Back Length","Back Length","Your hair is already shorter than that!");
	if(pc.credits >= ceriaServicePrice(200) && pc.hairLength > pc.tallness/2) addButton(btn++,"Ass Length",cutHair,pc.tallness/2);
	else if(pc.hairLength > pc.tallness/2) addDisabledButton(btn++,"Ass Length","Ass Length","You can’t afford that!");
	else addDisabledButton(btn++,"Ass Length","Ass Length","Your hair is already shorter than that!");
	if(pc.credits >= ceriaServicePrice(200) && pc.hairLength > pc.tallness/1.6) addButton(btn++,"Thigh Length",cutHair,pc.tallness/1.6);
	else if(pc.hairLength > pc.tallness/1.6) addDisabledButton(btn++,"Thigh Length","Thigh Length","You can’t afford that!");
	else addDisabledButton(btn++,"Thigh Length","Thigh Length","Your hair is already shorter than that!");
	if(pc.credits >= ceriaServicePrice(200) && pc.hairLength > pc.tallness/1.4) addButton(btn++,"Knee Length",cutHair,pc.tallness/1.4);
	else if(pc.hairLength > pc.tallness/1.4) addDisabledButton(btn++,"Knee Length","Knee Length","You can’t afford that!");
	else addDisabledButton(btn++,"Knee Length","Knee Length","Your hair is already shorter than that!");
	if(pc.credits >= ceriaServicePrice(200) && pc.hairLength > pc.tallness/1.2) addButton(btn++,"Calf Length",cutHair,pc.tallness/1.2);
	else if(pc.hairLength > pc.tallness/1.2) addDisabledButton(btn++,"Calf Length","Calf Length","You can’t afford that!");
	else addDisabledButton(btn++,"Calf Length","Calf Length","Your hair is already shorter than that!");
	if(pc.credits >= ceriaServicePrice(200) && pc.hairLength > pc.tallness - 1) addButton(btn++,"Ankle Length",cutHair,(pc.tallness - 1));
	else if(pc.hairLength > pc.tallness - 1) addDisabledButton(btn++,"Ankle Length","Ankle Length","You can’t afford that!");
	else addDisabledButton(btn++,"Ankle Length","Ankle Length","Your hair is already shorter than that!");
	if(pc.credits >= ceriaServicePrice(100) && pc.hairLength > 1) addButton(13,"Trim",cutHair,(pc.hairLength - 1));
	else if(pc.hairLength > 1) addDisabledButton(13,"Trim","Trim","You can’t afford that!");
	else addDisabledButton(13,"Trim","Trim","Your hair is already shorter than that!");
	addButton(14,"Back",hairworkFromCeria);

}

//Cut Treatment
public function cutHair(hairInches:Number):void
{
	clearOutput();
	showCeria();
	author("Couch");
	
	hairInches = Math.round(hairInches);
	
	if(!fuckedCeria())
	{
		if(pc.hasLivingHair())
		{
			output("Ceria sits you down in one of the salon chairs, eyeing your living [pc.hair].");
			output("\n\n<i>“Okay, scissors aren’t going to work here, but fortunately...”</i> The elf reaches into the drawers at her station and pulls out a bottle of some pale yellow gel. <i>“You’re not the only one who comes in here with hair that’s alive.”</i>");
			output("\n\nCeria carefully measures out the gel and sets to working it into your hair, providing you with a gentle tingle and the sensation of your exotic tresses shortening bit by bit to the length you requested. Her work is impeccable, making sure no part gets too much or too little gel");
		}
		else
		{
			output("Ceria sits you down in one of the salon chairs, pulling out a simple razor and pair of scissors before setting to work cutting, shearing and trimming away at your hair. Her work is impeccable");
		}
		output(", and by the time she’s finished you’re left with a fresh, clean look.");
		if (hairInches > 0) output(" <b>Your hair is now " + num2Text(hairInches) + " inches long!</b>");
		else if(pc.hasFur()) output(" <b>You have nothing but fur on your head!</b>");
		else output(" <b>You are totally bald!</b>");
	}
	else
	{
		if(pc.hasLivingHair())
		{
			output("Ceria sits you down in one of the salon chairs, looking over your living [pc.hair].");
			output("\n\n<i>“Normally living hair’s a big pain to deal with. You can’t use scissors on it, so you have to use this stuff instead.”</i> The elf turns to get something out of the drawers at her station, giving you a good look at the way her ass almost peeks out of those jeans she wears.");
			output("\n\nJust as you’re contemplating reaching for a feel Ceria turns back around, now holding a bottle of pale yellow gel. You watch as she carefully measures out the right amount of gel and puts it on her hands, showcasing the utility of her natural fairy gloves. Once her palms and fingers are evenly coated she leans forward and reaches into your hair, starting to caress each of the living strands.");
			output("\n\n<i>“Hold real still, [pc.name]. I need to get each and every one.”</i>");
			output("\n\nYou do your best to obey, but stars if the sight of those tanned elven tits hanging right in front of your eyes, teasing you with the swirls of tribal marks disappearing under her shirt and into her cleavage, doesn’t make it a challenge. Not to mention her hands, smooth as silk and cool as a breeze, working each and every one of your living, sensitive strands of hair. You feel like you could cum right here in the salon chair if she kept it up for long enough, cum from your exotic hair and her exotic hands alone.");
			output("\n\nSadly she doesn’t take nearly long enough, the gel soon running dry and with it leaving your hair feeling distinctly shorter. Ceria gives you a kiss on the cheek before stepping behind you and drawing your attention to the mirror.");
		}
		else
		{
			output("Ceria sits you down in one of the salon chairs, pulling out a simple razor and a pair of scissors.");
			output("\n\n<i>“The simplest tools are the best ones. You really need to be able to feel the customer’s hair... get close.”</i> Ceria leans forward a bit as she says this, in the midst of trimming the front of your hair and making sure you get a good, deep look down the front of her cleavage. You’re tempted to reach out and touch if not for the delicacy with which she’s working the scissors, making sure no strand is left out of place. When she’s done Ceria gives you a kiss on the cheek before stepping behind you and drawing your attention to the mirror.");
		}
		output("\n\n<i>“There you go, [pc.name], nice and neat. You look " + pc.mf("a lot more rugged","pretty cute") + " with shorter hair if you ask me.”</i>");
		output("\n\nCeria pulls away to deposit her tools, giving you some time to admire your new look.");
		if (hairInches > 0) output(" <b>Your hair is now " + num2Text(hairInches) + " inches long!</b>");
		else if(pc.hasFur()) output(" <b>You have nothing but fur on your head!</b>");
		else output(" <b>You are totally bald!</b>");
		pc.lust(5);
	}
	//[Next] Set [pc.hairstyle] to null and go to Ceria Main
	processTime(7);
	
	
	var cost:Number = 0;
	if(pc.hairLength - hairInches <= 0) { /* No cost! */ }
	else if(pc.hairLength - hairInches <= 1) cost = 100;
	else cost = 200;
	
	pc.hairLength = hairInches;
	pc.hairStyle = "null";
	pc.credits -= ceriaServicePrice(cost);
	
	clearMenu();
	addButton(0,"Next",serviceFromCeriaFinish);
}

//Ceria Does Your Hair Color
//Hair Color Options
public function hairColorMainMenu():void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("<i>“Right, so are you looking for a vanilla color, something metallic? If you’re looking for something really exotic, we’ve got these new treatments that actually make your hair glow. Personally, I like metallics.”</i> Ceria reaches up to rub one of her own glittering pink locks between her fingers for emphasis. <i>“" + ceriaServicePrice(500) + " credits for a vanilla or metallic, " + ceriaServicePrice(600) + " for one of the glowing ones.”</i>");
	//[Gray out options the PC can’t afford.]
	clearMenu();
	//[Standard] Go to Standard Hair Color
	if(pc.credits >= ceriaServicePrice(500)) addButton(0,"Standard",ceriaHairColorMenu,"standard","Standard","Get dyed a traditional color.");
	else addDisabledButton(0,"Standard","Standard","You can’t afford that!");
	//[Metallic] Go to Metallic Hair Color
	if(pc.credits >= ceriaServicePrice(500)) addButton(1,"Metallic",ceriaHairColorMenu,"metallic","Metallic","Get dyed a metallic color.");
	else addDisabledButton(1,"Metallic","Metallic","You can’t afford that!");
	//[Glowing] Go to Glowing Hair Color
	if(pc.credits >= ceriaServicePrice(600)) addButton(2,"Glowing",ceriaHairColorMenu,"glowing","Glowing","Get dyed a color that’ll glow in the dark.");
	else addDisabledButton(2,"Glowing","Glowing","You can’t afford that!");
	//[Back] Go To Hairwork
	addButton(14,"Back",hairworkFromCeria);
	processTime(1);
}

public function ceriaHairDyeColors(colorType:String = "none", dyePart:String = "none"):Array
{
	var colorList:Array = [];
	
	switch(colorType)
	{
		//Standard Color
		case "standard":
			colorList.push(["black", "Black"]);
			colorList.push(["chocolate", "Chocolate"]);
			colorList.push(["brown", "Brown"]);
			colorList.push(["dirty blonde", "Dirty Blonde"]);
			colorList.push(["blonde", "Blonde"]);
			colorList.push(["platinum blonde", "P.Blonde"]);
			colorList.push(["strawberry blonde", "S.B.Blonde"]);
			colorList.push(["auburn", "Auburn"]);
			colorList.push(["red", "Red"]);
			colorList.push(["crimson", "Crimson"]);
			colorList.push(["red-orange", "R.Orange"]);
			colorList.push(["orange", "Orange"]);
			colorList.push(["yellow-orange", "Y.Orange"]);
			colorList.push(["yellow", "Yellow"]);
			colorList.push(["yellow-green", "Y.Green"]);
			colorList.push(["green", "Green"]);
			colorList.push(["dark green", "D.Green"]);
			colorList.push(["turquoise", "Turquoise"]);
			colorList.push(["cerulean", "Cerulean"]);
			colorList.push(["blue", "Blue"]);
			colorList.push(["violet", "Violet"]);
			colorList.push(["indigo", "Indigo"]);
			colorList.push(["purple", "Purple"]);
			colorList.push(["lavender", "Lavender"]);
			colorList.push(["pink", "Pink"]);
			colorList.push(["white", "White"]);
			colorList.push(["ivory", "Ivory"]);
			colorList.push(["gray", "Gray"]);
			break;
		//Metallic Color
		case "metallic":
			colorList.push(["chrome", "Chrome", ("Dye your " + dyePart + " chrome for a retro-futuristic look.")]);
			colorList.push(["bronze", "Bronze"]);
			colorList.push(["gold", "Gold", ("Dye your " + dyePart + " gold. King Midas will have nothing on you!")]);
			colorList.push(["copper", "Copper"]);
			colorList.push(["cobalt", "Cobalt"]);
			colorList.push(["silver", "Silver", ("Dye your " + dyePart + " silver" + (dyePart == "hair" ? " like some kind of anime character" : "") + ".")]);
			colorList.push(["rusty", "Rusty", ("Dye your " + dyePart + " rusty. The name of the dye is “Rusty Venture”.")]);
			colorList.push(["steel", "Steel", ("Dye your " + dyePart + " steel. Really live up to your namesake.")]);
			colorList.push(["sable", "Sable"]);
			colorList.push(["metallic black", "M.Black", ("Dye your " + dyePart + " metallic black" + (silly ? " if you want to twinkle in the night sky" : "") + ".")]);
			colorList.push(["pearl", "Pearl"]);
			colorList.push(["rose gold", "Rose Gold"]);
			colorList.push(["amethyst", "Amethyst"]);
			colorList.push(["emerald", "Emerald"]);
			break;
		//Glowing Color
		case "glowing":
			colorList.push(["glowing red", "G.Red", ("Dye your " + dyePart + " to glow like the warning lights on a super-critical reactor.")]);
			colorList.push(["glowing orange", "G.Orange", ("Dye your " + dyePart + " glowing orange. You’ll always be the center of attention" + (dyePart == "hair" ? " - and probably the first to get a multipass to boot!" : "."))]);
			colorList.push(["glowing gold", "G.Gold", ("Dye your " + dyePart + " to glow like some kind of golden god.")]);
			colorList.push(["glowing green", "G.Green", ("Dye your " + dyePart + " glowing green. You’ll be the envy of comic book monsters everywhere.")]);
			colorList.push(["glowing blue", "G.Blue", ("Dye your " + dyePart + " glowing blue" + (dyePart == "hair" ? " for a bit of a cyber-punk look" : "") + ".")]);
			colorList.push(["glowing purple", "G.Purple"]);
			colorList.push(["glowing pink", "G.Pink"]);
			colorList.push(["glowing silver", "G.Silver"]);
			colorList.push(["glowing white", "G.White"]);
			colorList.push(["iridescent", "Iridescent", ("Can’t decide on one color? Dye your " + dyePart + " iridescent for a more multi-colored look.")]);
			if(pc.level >= 6 || pc.hasItemByClass(Foxfire)) colorList.push(["glowing ember", "Foxfire", ("Dye your " + dyePart + " glowing ember to appear as if it’s emitting hot fire.")]);
			if(pc.level >= 6 || pc.hasItemByClass(Frostfire)) colorList.push(["fiery blue", "Frostfire", ("Dye your " + dyePart + " fiery blue to appear as if it’s covered in cool flames.")]);
			break;
	}
	
	return colorList;
}
public function ceriaHairColorMenu(colorType:String = "none"):void
{
	clearOutput();
	showCeria();
	author("Couch");
	
	var colorList:Array = ceriaHairDyeColors(colorType, "hair");
	var i:int = 0;
	var btnSlot:int = 0;
	
	//[Buttons for Colors] Go to Hair Treatment
	clearMenu();
	for(i = 0; i < colorList.length; i++)
	{
		if(btnSlot >= 14 && (btnSlot + 1) % 15 == 0)
		{
			addButton(btnSlot, "Back", hairColorMainMenu);
			btnSlot++;
		}
		
		if(pc.hairColor != colorList[i][0]) addButton(btnSlot, colorList[i][1], hairColorizing, colorList[i][0], StringUtil.toDisplayCase(colorList[i][0]), (colorList[i].length > 2 ? colorList[i][2] : "Dye your hair " + colorList[i][0] + "."));
		else addDisabledButton(btnSlot, colorList[i][1], StringUtil.toDisplayCase(colorList[i][0]), ("Your hair is already " + colorList[i][0] + "."));
		btnSlot++;
		
		if(colorList.length > 14 && (i + 1) == colorList.length)
		{
			while((btnSlot + 1) % 15 != 0) { btnSlot++; }
			addButton(btnSlot, "Back", hairColorMainMenu);
		}
	}
	//[Back] Go to Hairwork
	addButton(14, "Back", hairColorMainMenu);
	
	output("Ceria pulls out a small tablet showing a color wheel and presents it to you. <i>“Alright, pick what looks good.”</i>");
	if(colorList.length > 14) output("\n\n(This is a multipage menu - the buttons in the lower right can be used to page through it.)");
	processTime(1);
}

//Hair Treatment
public function hairColorizing(newColor:String = "black"):void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("Once you’ve made your selection Ceria takes back the tablet, plugging it into a dispenser that soon spits out a small container of what looks like " + newColor + " hair gel.");
	if(!fuckedCeria()) output("\n\n<i>“Alright, sit down and hold still while I work this in.”</i> After getting you into the salon chair, Ceria takes out a thick glob of the gel and starts rubbing it into your scalp. As she does, you can see your former hair color being overtaken by a new shade. Ceria doesn’t stop until she’s used up all of the gel, by which time your hair color has been completely replaced and your roots are left tingling, altered by the gel to make " + newColor + " your new natural hair color. <b>Your hair is now " + newColor + "!</b>");
	else
	{
		output(" Ceria escorts you to one of the salon chairs, only to sit down in your lap facing you.");
		output("\n\n<i>“Alright, [pc.name], let’s get you ready. Make sure to hold still, and no ear play. I don’t want to spill any of this.”</i> The stylist takes out some of the gel and begins rubbing it into your scalp one dollop at a time, watching the new color start to flow up from your roots as she does. She starts in the front and gradually works her way backward, leaning forward further until her breasts squish firmly against ");
		if(pc.biggestTitSize() >= 1) output("your own");
		else output("your chest");
		output(" while she runs her hands through the back of your hair.");
		output("\n\nWell, she said no ear play, but she didn’t say anything about copping a feel. You reach up to give Ceria’s breasts a few squeezes through her top, each one earning a soft coo from the stylist. She gives you a lascivious smile, glancing downwards invitingly. You take the hint and bring one of your hands down to grope her ass instead, the other staying up top to keep caressing her breasts while she caresses your slowly-changing hair.");
		output("\n\n<i>“Mmm, that’s it, " + pc.mf("hunk","cutie") + ", almost done. You’re gonna look great in " + newColor + ".”</i> Ceria’s hands remain occupied with your hair, but she puts a little bit of rocking motion into her hips as she nears the end, just enough to tease you with the thought of her pussy being so close. Judging by the slight droop to her ears, ");
		if(pc.hasCock()) output("and the way she’s grinding ever-so-slightly against your bulge, ");
		output("she’s teasing herself just as much.");
		output("\n\nFinally you’re treated to a short but sweet kiss as the last of the gel is used up, and by the time Ceria pulls her lips away and gets off your lap the last vestiges of [pc.hairColor] have vanished from the tips of your hair, leaving you with a pleasant tingle in your roots as the gel finishes ensuring its work is permanent. <b>Your hair is now " + newColor + "!</b>");
		pc.lust(10);
	}
	pc.hairColor = newColor;
	pc.credits -= ceriaServicePrice(500);
	if(newColor.indexOf("glowing") != -1 || newColor.indexOf("luminous") != -1 || newColor == "iridescent") pc.credits -= ceriaServicePrice(100);
	processTime(20);
	clearMenu();
	addButton(0,"Next",serviceFromCeriaFinish);
}

//Ceria Does Your Hairstyle
//Style Options
public function ceriaHairStyleChoices():void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("<i>“Okay, let me show you some of our styles.”</i> Ceria pulls out a small tablet and shows you several different pictures modeling various hairstyles. <i>“Just let me know what you’re interested in.”</i>");
	//[All options go to Style Confirmation]
	clearMenu();
	var options:Array = [];
	
	options.push(["Straight", "straight", "a plain, straight do", "straight hair", 1, 0]);
	options.push(["Ponytail", "ponytail", "a ponytail", "a ponytail", 5, 0]);
	options.push(["Pigtails", "pigtails", "pigtails", "pigtails", 5, 0]);
	options.push(["Curls", "curls", "curls", "your hair curled", 0, 0]);
	options.push(["Braided", "braided", "a braid", "your hair braided", 5, 0]);
	options.push(["Afro", "afro", "an afro", "an afro", 0, 12]);
	options.push(["Mohawk", "mohawk", "a mohawk", "a mohawk", 0, 12]);
	
	options.push(["Spikes", "spikes", "spikes", "spikes", 0, 12]);
	options.push(["Messy Curls", "mess of curls", "messy curls", "messy curls", 0, 0]);
	options.push(["Front Wave", "front wave", "a front wave", "a front wave", 0, 0]);
	options.push(["Back Slick", "backwards slick", "a backwards slick", "a backwards slick", 0, 0]);
	options.push(["Ruff.Layers", "ruffled layers", "ruffled layers", "your hair in ruffled layers", 0, 0]);
	options.push(["Simple Part", "simple part", "a simple part", "simple parted hair", 5, 0]);
	options.push(["Side Part", "side part", "a side part", "side parted hair", 5, 0]);
	options.push(["Bob", "bob cut", "a bob cut", "a bob cut", 5, 12]);
	options.push(["Hime", "hime cut", "a hime cut", "a hime cut", 5, 0]);
	options.push(["M.Chignon", "messy chignon", "a messy chignon", "a messy chignon", 5, 24]);
	options.push(["T.Chignon", "tight chignon", "a tight chignon", "a tight chignon", 5, 24]);
	options.push(["Side Plait", "side plait", "a side plait", "a side plait", 5, 0]);
	options.push(["Single Braid", "single braid", "a single braid", "a single braid", 5, 0]);
	options.push(["Crown Braid", "crown braid", "a crown braid", "a crown braid", 5, 0]);
	options.push(["Pigtail Buns", "pigtail buns", "pigtail buns", "pigtail buns", 5, 24]);
	options.push(["Twintails", "twintails", "a set of twintails", "a set of twintails", 5, 0]);
	
	var btnSlot:int = 0;
	for(var i:int = 0; i < options.length; i++)
	{
		var hairBtn:String = options[i][0];
		var hairStyle:String = options[i][1];
		var hairTitle:String = StringUtil.toDisplayCase(options[i][1]);
		var hairDescA:String = options[i][2];
		var hairDescB:String = options[i][3];
		var lengthMin:Number = options[i][4];
		var lengthMax:Number = options[i][5];
		
		if(btnSlot >= 14 && (btnSlot + 1) % 15 == 0)
		{
			addButton(btnSlot, "Back", hairworkFromCeria);
			btnSlot++;
		}
		
		if(pc.hairStyle != hairStyle) {
			if(lengthMax != 0 && pc.hairLength > lengthMax) addDisabledButton(btnSlot, hairBtn, hairTitle, "Your hair is too long to be styled into " + hairDescA + ".");
			else if(lengthMin != 0 && pc.hairLength < lengthMin) addDisabledButton(btnSlot, hairBtn, hairTitle, "Your hair isn’t long enough to get put into " + hairDescA + ".");
			else addButton(btnSlot, hairBtn, styleConfirmation, hairStyle, hairTitle, "Get your hair styled into " + hairDescA + ".");
		}
		else addDisabledButton(btnSlot, hairBtn, hairTitle, "You already have " + hairDescB + ".");
		btnSlot++;
		
		if(options.length > 14 && (i + 1) == options.length)
		{
			while((btnSlot + 1) % 15 != 0) { btnSlot++; }
			addButton(btnSlot, "Back", hairworkFromCeria);
		}
	}
	
	//[Back] Go To Hairwork
	processTime(1);
	addButton(14,"Back",hairworkFromCeria);

}

//Style Confirmation
public function styleConfirmation(hStyle:String = ""):void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("<i>“Okay, so you want your hair");
	if(hStyle == "ponytail") output(" in a ");
	else if(hStyle == "pigtails") output(" in ");
	else if(hStyle == "curls") output(" in ");
	else if(hStyle == "braided") output(" ");
	else if(hStyle == "afro") output(" worn as an ");
	else if(hStyle == "mohawk") output(" done up as a ");
	else output(" ");
	output(hStyle + "? That’ll be " + ceriaServicePrice(1200) + " credits.”</i>");
	processTime(1);
	//[OK] Go to Styling
	//[Nevermind] Go To Hairwork
	clearMenu();
	if(pc.credits >= ceriaServicePrice(1200)) addButton(0,"Okay",styleDatHairGo,hStyle);
	else addDisabledButton(0,"Okay","Okay","You can’t afford that.");
	addButton(1,"Nevermind",hairworkFromCeria);
}
	
//Styling
public function styleDatHairGo(hStyle:String):void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("Ceria sits you down in one of the salon chairs and gets out her tools, setting to work on styling your hair. By the time she’s done, you’re the proud bearer of a brand-new look.");
	processTime(1);
	pc.credits -= ceriaServicePrice(1200);
	pc.hairStyle = hStyle;
	//[Next] Go To Ceria Main
	clearMenu();
	addButton(0,"Next",serviceFromCeriaFinish);
}

//Fur Shear Options
public function furShearMenu():void
{
	clearOutput();
	showCeria();
	author("Jacques00");
	
	output("<i>“Ah, is your wool making you all stuffy and hot or do you just want to keep it under control? In any case, a full body cut like that will cost a bit more than a normal haircut would, but since I can make a profit off the fleece, you get a store discount. It’ll be " + ceriaServicePrice(500) + " credits for a trim with 50% off on the next service or purchase, and " + ceriaServicePrice(900) + " credits for a full shearing with the next service or purchase on-the-house--how’s that sound?”</i>");
	
	processTime(1);
	clearMenu();
	if(pc.credits >= ceriaServicePrice(500)) addButton(0,"Trim",furShearWool,"trim","Trim","Trim your wool until you have shorter fur.");
	else addDisabledButton(0,"Trim","Trim","You can’t afford this.");
	if(pc.credits >= ceriaServicePrice(900)) addButton(1,"Shear",furShearWool,"shear","Shear","Shear off your fleece completely.");
	else addDisabledButton(1,"Shear","Shear","You can’t afford this.");
	addButton(14,"Back",hairworkFromCeria);
}
public function furShearWool(cutType:String = "none"):void
{
	clearOutput();
	showCeria();
	author("Jacques00");
	
	var cost:Number = 0;
	
	output("<i>“Okay, a " + cutType + " it is! Right this way....”</i>");
	output("\n\nThe fairy-morph guides you to room with a harness chair fit for your body type. You " + (!pc.isNude() ? "remove your clothing" : "set aside your gear") + ", settle in - the padded straps making things a little more comfortable - and wait for Ceria to gather her tools. When she returns, she has a pair of classic shears and an electric razor. Pressing a button on a nearby wall, the chair lifts and you are raised to an upright position where Ceria can access your body freely.");
	output("\n\n<i>“Now be patient, " + (pc.sheepScore() >= 5 ? "my [pc.raceBoyGirlSimple]" : "cutie") + ", and don’t wriggle too much--it’ll be just a moment.”</i>");
	output("\n\nWith great expertise, Ceria takes her shears and gets to work trimming the fleece on your body, especially on your chest and back.");
	
	switch(cutType)
	{
		case "trim":
			output(" Patch after patch is cut and sliced until your fur is whittled to a much shorter and less curly length, making you appear thinner than you were when you came in. She neatly crops and sculpts a few areas with her clippers and finishes you off with a quick full-body brush down, making sure you’re as clean as possible.");
			cost = 500;
			break;
		case "shear":
			output(" The scissors are cut very close to your [pc.skinNoun], but the shearer is careful enough to not pierce you. She goes at a rapid pace, snipping away at the base of each wooly follicle until she is creating a large net of your fleece below you. After she completes shearing the major portions of your wool, she takes her clippers and shaves the harder to reach areas, revealing your nude skin underneath. She then brushes you off a few times, making sure you’re as clean as possible, and proceeds to douse and rub your naked body with some kind of skin conditioning lotion, most likely to prevent any itching side effects.");
			var hasSmooth:Boolean = pc.hasSkinFlag(GLOBAL.FLAG_SMOOTH);
			var hasFluff:Boolean = pc.hasSkinFlag(GLOBAL.FLAG_FLUFFY);
			if(hasFluff) output(" She flicks the fluff ball on your chest and giggles. She obviously left that there because she thought it was cute.");
			pc.skinType = GLOBAL.SKIN_TYPE_SKIN;
			pc.clearSkinFlags();
			if(hasSmooth) pc.addSkinFlag(GLOBAL.FLAG_SMOOTH);
			if(hasFluff) pc.addSkinFlag(GLOBAL.FLAG_FLUFFY);
			cost = 900;
			break;
	}
	output("\n\nWhen another button on the wall is pressed, the harness gently descends and releases you to your [pc.feet].");
	output("\n\n<i>“Whew. My guess is your wool will grow back in a week or so, so be sure to come back if you want me to " + cutType + " it again.”</i> Ceria wipes her forehead and grabs a data slate near the cash register. <i>“And like I promised, your discount!”</i> A few quick beeps from your codex makes the transaction complete.");
	if(pc.sheepScore() >= 5) output(" You give her a " + pc.mf("bleated", "soft") + " <i>“baa”</i> like the sheep you are.");
	output("\n\nYou redon your gear while the fairy sweeps your wool away into a storage container.");
	
	// Reset wool timer
	pc.setPerkValue("Wooly", 1, -7);
	// Take cash, remove any discounts
	pc.credits -= ceriaServicePrice(cost);
	if(pc.hasKeyItem("Coupon - Shear Beauty")) pc.removeKeyItem("Coupon - Shear Beauty");
	// Give discounts
	output("\n\n<b>You have gained a coupon for any service or purchase from Shear Beauty!</b>");
	switch(cutType)
	{
		case "trim": pc.createKeyItem("Coupon - Shear Beauty", 0.5, 0, 0, 0, "Save 50% on your next purchase or service at Shear Beauty!"); break;
		case "shear": pc.createKeyItem("Coupon - Shear Beauty", 0.0, 0, 0, 0, "Your next purchase or service is FREE at Shear Beauty!"); break;
	}
	
	processTime(32);
	clearMenu();
	addButton(0,"Next",serviceFromCeriaFinish, false);
}

//Ceria Does Your Fur
//Fur Color Options
public function furColorMenu():void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("<i>“Fur, huh? Okay, these are pretty much the same options as hair. We’ve got like vanilla colors, metallics, glowy fur... pick whatever kind you want. Because it’s a full-body treatment, I’m gonna have to charge " + ceriaServicePrice(1500) + " credits for a vanilla or metallic, " + ceriaServicePrice(1800) + " for one of the glowy colors. Fur’s a lot of dye.”</i>");

	//[Standard] Go to Standard Fur Color
	//[Metallic] Go to Metallic Fur Color
	//[Glowing] Go to Glowing Fur Color
	//[Back] Go To Hairwork
	processTime(1);
	clearMenu();
	if(pc.credits >= ceriaServicePrice(1500)) addButton(0,"Standard",ceriaFurColorMenu,"standard","Standard","Standard colors.");
	else addDisabledButton(0,"Standard","Standard","You can’t afford this.");
	if(pc.credits >= ceriaServicePrice(1500)) addButton(1,"Metallic",ceriaFurColorMenu,"metallic","Metallic","Metallic colors.");
	else addDisabledButton(1,"Metallic","Metallic","You can’t afford this.");
	if(pc.credits >= ceriaServicePrice(1800)) addButton(2,"Glowing",ceriaFurColorMenu,"glowing","Glowing","Glowing colors.");
	else addDisabledButton(2,"Glowing","Glowing","You can’t afford this.");
	addButton(14,"Back",hairworkFromCeria);
}

public function ceriaFurColorMenu(colorType:String = "none"):void
{
	clearOutput();
	showCeria();
	author("Couch");
	
	var colorList:Array = ceriaHairDyeColors(colorType, "fur");
	var i:int = 0;
	var btnSlot:int = 0;
	
	//[Buttons for Colors] Go to Fur Treatment
	clearMenu();
	for(i = 0; i < colorList.length; i++)
	{
		if(btnSlot >= 14 && (btnSlot + 1) % 15 == 0)
		{
			addButton(btnSlot, "Back", furColorMenu);
			btnSlot++;
		}
		
		if(pc.furColor != colorList[i][0]) addButton(btnSlot, colorList[i][1], furColorApplication, colorList[i][0], StringUtil.toDisplayCase(colorList[i][0]), ((colorList[i].length > 2 ? colorList[i][2] : "Dye your fur " + colorList[i][0] + ".")));
		else addDisabledButton(btnSlot, colorList[i][1], StringUtil.toDisplayCase(colorList[i][0]), ("Your fur is already " + colorList[i][0] + "."));
		btnSlot++;
		
		if(colorList.length > 14 && (i + 1) == colorList.length)
		{
			while((btnSlot + 1) % 15 != 0) { btnSlot++; }
			addButton(btnSlot, "Back", furColorMenu);
		}
	}
	//[Back] Go to Hairwork
	addButton(14, "Back", furColorMenu);
	
	output("Ceria pulls out a small tablet showing a color wheel and presents it to you. <i>“Alright, pick what looks good.”</i>");
	if(colorList.length > 14) output("\n\n(This is a multipage menu - the buttons in the lower right can be used to page through it.)");
	processTime(1);
}

//Fur Treatment
public function furColorApplication(newColor:String):void
{
	if(pc.hasWings() && InCollection(pc.statusEffectv1("Wing Style"), [GLOBAL.FLAG_FURRED, GLOBAL.FLAG_FEATHERED]) && !pc.hasStatusEffect("Ceria Dye Wings"))
	{
		ceriaFurColorWings(["choose", newColor]);
		return;
	}
	if(pc.balls > 0 && InCollection(pc.statusEffectv1("Special Scrotum"), [GLOBAL.FLAG_FURRED, GLOBAL.FLAG_FEATHERED]) && !pc.hasStatusEffect("Ceria Dye Balls"))
	{
		ceriaFurColorBallZ(["choose", newColor]);
		return;
	}
	furColorApplicationGo(newColor);
}
public function ceriaFurColorWings(arg:Array):void
{
	clearOutput();
	clearBust();
	showName("DYE\nWINGS")
	clearMenu();
	
	var option:String = arg[0];
	var newColor:String = arg[1];
	var special:String = (arg.length > 2 ? arg[2] : "");
	
	if(option == "choose")
	{
		output("It looks like you have furry wings you can dye... do you wish for Ceria to color them too? If so, would you like to retain the fur color regardless of your body’s fur color changes in the future, or would you like them to match with the rest of your body’s fur color naturally?");
		output("\n\nCurrently, your wings are " + (pc.getStatusTooltip("Wing Style") != "" ? (pc.getStatusTooltip("Wing Style") + " and retains their own color, separate from your body fur color") : (pc.furColor + " and matches your body’s fur color")) + ".");
		output("\n\nBe warned, however, <b>if your wings are the only thing you have to dye, you might be wasting your credits if you choose not to dye it!</i>");
		
		addButton(0, "Match", ceriaFurColorWings, ["done", newColor, "match"], "Match Fur", "Dye them to always match the fur color.");
		addButton(1, "Unique", ceriaFurColorWings, ["done", newColor, "unique"], "Unique Color", "Dye them, but retain its own fur color seperately.");
		addButton(2, "No Dye", ceriaFurColorWings, ["done", newColor, "none"], "Don’t Dye", "Dye everything else, if applicable, and don’t apply dye to wing fur. (This will still cost credits!)");
		addButton(3, "Current", ceriaFurColorWings, ["done", newColor, "current"], "Current Preference", "Dye them and keep the preferences how they already are.");
		addButton(14, "Nevermind", furColorMenu);
		return;
	}
	
	switch(special)
	{
		case "match":
			output("You decide to dye your wings " + newColor + " and let them naturally match your body’s fur color whenever it changes.");
			pc.setStatusTooltip("Wing Style", "");
			break;
		case "unique":
			output("You decide to dye your wings " + newColor + " and let them stay that way, especially if your body’s fur color ever changes.");
			pc.setStatusTooltip("Wing Style", newColor);
			break;
		case "none":
			var oldColor:String = (pc.getStatusTooltip("Wing Style") != "" ? pc.getStatusTooltip("Wing Style") : pc.furColor);
			output("You decide to let your wings retain their " + oldColor + " fur while the rest of your fur (if any) gets dyed " + newColor + ".");
			pc.setStatusTooltip("Wing Style", oldColor);
			break;
		default:
			output("You decide to dye your wings " + newColor + " and let them do whatever they do when the rest of your body’s fur color changes.");
			if(pc.getStatusTooltip("Wing Style") != "") pc.setStatusTooltip("Wing Style", newColor);
			break;
	}
	
	pc.createStatusEffect("Ceria Dye Wings", 0, 0, 0, 0, true, "", "", false, 0);
	
	addButton(0, "Next", furColorApplication, newColor);
}
public function ceriaFurColorBallZ(arg:Array):void
{
	clearOutput();
	clearBust();
	showName("DYE\nSCROTUM")
	clearMenu();
	
	var option:String = arg[0];
	var newColor:String = arg[1];
	var special:String = (arg.length > 2 ? arg[2] : "");
	
	if(option == "choose")
	{
		output("It looks like you have a special fluffy scrotum to take care of... do you wish for Ceria to color it too? If so, would you like to retain its fur color regardless of your body’s fur color changes in the future, or would you like it to match with the rest of your body’s fur color naturally?");
		output("\n\nCurrently, your scrotum is " + (pc.getStatusTooltip("Special Scrotum") != "" ? (pc.getStatusTooltip("Special Scrotum") + " and retains its own color, separate from your body fur color") : (pc.furColor + " and matches your body’s fur color")) + ".");
		output("\n\nBe warned, however, <b>if your scrotum is the only thing you have to dye, you might be wasting your credits if you choose not to dye it!</i>");
		
		addButton(0, "Match", ceriaFurColorBallZ, ["done", newColor, "match"], "Match Fur", "Dye it to always match the fur color.");
		addButton(1, "Unique", ceriaFurColorBallZ, ["done", newColor, "unique"], "Unique Color", "Dye it, but retain its own fur color seperately.");
		addButton(2, "No Dye", ceriaFurColorBallZ, ["done", newColor, "none"], "Don’t Dye", "Dye everything else, if applicable, and don’t apply dye to scrotum fur. (This will still cost credits!)");
		addButton(3, "Current", ceriaFurColorBallZ, ["done", newColor, "current"], "Current Preference", "Dye it and keep the preferences how they already are.");
		addButton(14, "Nevermind", furColorMenu);
		return;
	}
	
	switch(special)
	{
		case "match":
			output("You decide to dye your scrotum " + newColor + " and let it naturally match your body’s fur color whenever it changes.");
			pc.setStatusTooltip("Special Scrotum", "");
			break;
		case "unique":
			output("You decide to dye your scrotum " + newColor + " and let it stay that way, especially if your body’s fur color ever changes.");
			pc.setStatusTooltip("Special Scrotum", newColor);
			break;
		case "none":
			var oldColor:String = (pc.getStatusTooltip("Special Scrotum") != "" ? pc.getStatusTooltip("Special Scrotum") : pc.furColor);
			output("You decide to let your scrotum retain its " + oldColor + " fur while the rest of your fur (if any) gets dyed " + newColor + ".");
			pc.setStatusTooltip("Special Scrotum", oldColor);
			break;
		default:
			output("You decide to dye your scrotum " + newColor + " and let it do whatever it does when the rest of your body’s fur color changes.");
			if(pc.getStatusTooltip("Special Scrotum") != "") pc.setStatusTooltip("Special Scrotum", newColor);
			break;
	}
	
	pc.createStatusEffect("Ceria Dye Balls", 0, 0, 0, 0, true, "", "", false, 0);
	
	addButton(0, "Next", furColorApplication, newColor);
}
public function furColorApplicationGo(newColor:String):void
{
	clearOutput();
	showCeria();
	author("Couch");
	if(!pc.hasFur())
	{
		output("<i>“This is going to be a little trickier than doing your hair, but at least we don’t have to do a full body job. Dealing with a full coat of fur can be quite tricky.”</i>");
		if(fuckedCeria()) output(" Ceria’s eyes rove up and down your body. <i>“But then again, some of us wouldn’t mind giving you a full-body once-over.”</i>")
		output("\n\nThe bubbly hairstylist leads to a chair and instructs, <i>“Strip and lie down while I get the gel ready.”</i>");
		output("\n\nYou’re provided a moment of privacy and a small towel to put across your lap for modesty before the elf returns. Ceria allows herself a moment to take in your almost-nude body with a lascivious smile before recovering her professional composure. ");
		output("Reaching into the tub of gel, she takes out a thick glob and smears it across the parts of you covered in fur, working the gel in with confident, skilled strokes until it’s fully absorbed. You can feel the gel’s contents flowing through you just under the surface, diffusing across your entire body but particularly seeking out the spots where you’ve already got fur on display.");
		output("\n\nCeria doesn’t stop until she empties out the entire tub, leaving you tingling all over as the payload in the gel gets to work altering your fur all the way down to the roots. By the time she lets you up, you’ve got an all-new palette to your pelt. <b>Your fur is now " + newColor + "!</b>");
	}
	else if(fuckedCeria())
	{
		output("<i>“This is a little more complicated than doing your hair. Come on, [pc.name], this way.”</i> For a moment you think Ceria might be about to take you into the break room again, but instead she takes you to what looks like a massage table, drawing a curtain around it for privacy. You see a small towel lying on the table, but Ceria scoops it up with one hand and lays it over her shoulder.");
		output("\n\n<i>“Strip and lie down while I get the gel ready.”</i> Ceria doesn’t leave while you obey, openly licking her lips at the view of you stripping for her. You indulge her a bit by taking your time to give her a stripshow, easing off each piece of your gear in turn before stretching out on your back on the table. When you’re done Ceria gets up on the table as well, kneeling over you and placing the tub of gel by your side. The stylist glances towards the privacy screen before looking back at you, at which point she gives you a grin and pulls her top off, dropping it off by your gear.");
		output("\n\n<i>“Alright, let’s get started. Just sit back and enjoy the show, " + pc.mf("hunk","cutie") + ".”</i> Ceria reaches into the tub of gel and pulls out a thick glob, coating both of her hands in it before laying them on your chest to start making slow circles. While her naturally-gloved hands seem to be immune, the gel sinks into your [pc.skinFurScalesNoun] as she works it in, gradually starting to disappear and leaving you with a cool sensation that soon begins to spread all over your body.");
		output("\n\nCeria applies some fresh gel every time it starts to run low, slowly working her way through the entire contents of the tub. Each time her hands meet near the centerline of your chest it causes her upper arms to push her breasts together just a bit, while she’s ");
		if(pc.biggestTitSize() < 1) output("relishing the feeling of your pectorals");
		else output("not at all shy about getting some squeezing in that you’re pretty sure isn’t necessary for working the gel into your breasts");
		output(". As the tub starts to run low, you tear your gaze away from the elven tits hanging above you for just a moment to observe your fur’s palette changing, as if the [pc.furColor] was being washed away to reveal " + newColor + " underneath. Ceria takes a moment to observe this as well, licking her lips.");
		output("\n\n<i>“Oh, that’s hot, [pc.name]. " + StringUtil.upperCase(newColor) + " looks amazing on you, you’re gonna love it. I know I certainly do.”</i> The stylist keeps going until she runs out of gel completely, and a little longer besides, rubbing your [pc.breasts] while she watches your fur finish transitioning to its new coloration. You can feel the tingling deep in your roots, as the gel ensures that its adjustments to your palette are permanent.");
		output("\n\n<i>“Oh yes, perfect. You look great, [pc.name].”</i> Ceria traces her fingers downward across your body, giving you a teasing grin as she stops just shy of your crotch");
		if(pc.hasCock()) output(" and narrowly avoids brushing your erection with her fingertips");
		output(". <i>“Of course, if you want to try out a different color sometime, I’ll gladly do this for you again any time you want.”</i>");
		output("\n\nCeria eventually takes her hands off of your body and gets up to put her shirt back on, allowing you to reclaim your gear and get a proper look at your new coloration. <b>Your fur is now " + newColor + "!</b>");
		pc.lust(10);
	}
	else
	{
		output("Once you’ve made your selection Ceria takes back the tablet, plugging it into a dispenser that soon spits out a large tub of what looks like " + newColor + " hair gel.");
		output("\n\n<i>“Alright, this is a little more complicated than doing your hair. This way, please.”</i> Ceria takes you past the counter to what looks like a massage table, drawing a curtain around it for privacy. <i>“I’m gonna need you to lie down here and strip.”</i>");
		output("\n\nYou’re provided a moment of privacy and a small towel to put across your lap for modesty before the elf returns. Ceria allows herself a moment to take in your almost-nude body with a lascivious smile before recovering her professional composure. ");
		if(pc.hasFur()) output("Reaching into the tub of hair gel, she takes out a thick glob and smears it across your chest before starting to work it into the skin underneath your fur, the gel gradually wicking away as your body absorbs it. You can feel the gel’s contents flowing through you just under the surface, diffusing evenly across your entire furry body.");

		else output("Reaching into the tub of gel, she takes out a thick glob and smears it across your bare chest, working the gel into the bare [pc.skinFurScalesNoun] until it’s fully absorbed. You can feel the gel’s contents flowing through you just under the surface, diffusing across your entire body but particularly seeking out the spots where you’ve already got fur on display.");

		output("\n\nCeria doesn’t stop until she empties out the entire tub, leaving you tingling all over as the payload in the gel gets to work altering your fur all the way down to the roots. By the time she lets you up, you’ve got an all-new palette to your pelt. <b>Your fur is now " + newColor + "!</b>");
	}
	pc.credits -= ceriaServicePrice(1500);
	if(newColor.indexOf("glowing") != -1 || newColor.indexOf("luminous") != -1 || newColor == "iridescent") pc.credits -= ceriaServicePrice(300);
	pc.furColor = newColor;
	
	pc.removeStatusEffect("Ceria Dye Wings");
	pc.removeStatusEffect("Ceria Dye Balls");
	
	//[Next] Go to Ceria Main
	processTime(22);
	clearMenu();
	addButton(0,"Next",serviceFromCeriaFinish);
}

//Chatting Up The Hairstylist
//Ceria Talk
public function ceriaTalk():void
{
	clearOutput();
	showCeria();
	author("Couch");
	processTime(1);
	//Hasn't used the store
	if(flags["CERIA_BOUGHT"] == undefined || flags["CERIA_BOUGHT"] < 1)
	{
		output("<i>“I was thinking I’d rather just talk to a cute girl like you.”</i> you say, prompting a playful smirk from Ceria.");
		output("\n\n<i>“Sorry, [pc.name], you’re cute, but I </i>do<i> have a business to run here. My boss would kill me if she found out I was chatting up customers who hadn’t bought anything yet. Buy something or get a treatment first, then we’ll talk.”</i>");
		//[Back] Go to Ceria Main}
		clearMenu();
		addButton(0,"Next",approachCeria);
	}
	//PC’s used the store: 
	else
	{
		output("<i>“I was thinking I might like to get to know you a little better.”</i> you say, prompting Ceria to lean over the counter just a little further.");
		output("\n\n<i>“Oh? Well, I’ve always got time to talk to a " + pc.mf("hunk","cutie") + " like you. What do you want to know?”</i>");
		clearMenu();
		//[Herself] Go to Herself
		addButton(0,"Herself",ceriaTalkAboutHerself,undefined,"Herself","Ask her about herself");
		//[Working Here] Go to Working Here
		addButton(1,"Working Here",talkToCeriaAboutWorkingHere,undefined,"Working Here","Ask her how working is.");
		//[Her Race] Go to Her Race
		addButton(2,"Her Race",talkToCeriaAboutHerRace,undefined,"Her Race","Ask her about her race.");
		//[TouchPointyEars] Gray out until Her Race is done, go to Touch Pointy Ears
		if(flags["CERIA_EAR_TOUCH_UNLOCKED"] != undefined) addButton(3,"TouchEars",touchPointyEars,undefined,"TouchEars","Touch those sensitive ears... you know you want to.");
		else addDisabledButton(3,"Locked","Locked","You haven’t unlocked this topic.");
		//[Back] Go to Ceria Main}
		addButton(14,"Back",approachCeria);
	}
}

//Herself
public function ceriaTalkAboutHerself():void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("<i>“What, like, just anything about me?”</i> Ceria looks upward in thought as she blows and pops a few bubbles.");
	output("\n\n<i>“Well, I’m from one of the L4 colonies around Terra, dad and mom still live there. Cheerleader in high school, attended college at South Harmon, got my stylist’s certification there.”</i> She points to a framed certificate on the wall just next to the counter.");
	output("\n\n<i>“Right now I’m living here on Tavros Station, looking to move back core-ward someday. Right now, though, I’m pretty happy where I am. Oh, and I’m a big fan of fantasy stuff, in case you couldn’t tell.”</i> She gives one of her ears a playful twitch.");
	output("\n\n<i>“That’s all?”</i> you ask, prompting an amused smile from Ceria.");
	output("\n\n<i>“You want my whole life story? There’s not much to tell, sorry. You want to know something more specific, ask me about it.”</i>");
	//[Next] Go to Ceria Talk
	processTime(4);
	clearMenu();
	addButton(0,"Next",ceriaTalk);
}

//Working Here
public function talkToCeriaAboutWorkingHere():void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("<i>“So what’s a girl like you doing in a place like this?”</i> you offer, causing Ceria to giggle.");
	output("\n\n<i>“My dad knows the owner of this place. Her name’s Nahri, you’ll like her if you ever meet her. I’d just gotten out of school and needed a job, so dad set me up with her. It’s kind of a long way out, but the living conditions are pretty good, especially for somewhere right by the fringe like this, and Nahri pays the rent so it’s not like I have that to worry about either. Plus I get to meet a bunch of interesting rushers like you. It’s a pretty cool job.”</i>");
	output("\n\n<i>“Where’s Nahri?”</i> you ask. You haven’t seen any other employees since you came in.");
	output("\n\nCeria shrugs. <i>“I dunno, she just goes off sometimes. Almost never gives me any warning, just asks me to mind the salon and then disappears for like a month. If you run into her out there in the rush, let her know I said hi, alright?”</i>");
	//[Next] Set global flag HEARD_OF_NAHRI to true, go to Ceria Talk
	processTime(4);
	clearMenu();
	addButton(0,"Next",ceriaTalk);
}

//Her Race
public function talkToCeriaAboutHerRace():void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("<i>“So, you’re a human under all that?</i> you say half-jokingly as you glance over Ceria’s various mods. She just smirks in response.");

	output("\n\n<i>“You wanna </i>really<i> see someone with lots of mods, check out those two transformative dealers. I’ve gone light compared to either of them. But yeah, I’ve used a lot of Sylvanol. We sell it right here in the shop, and I’d always wanted to try it, so I figured why not? Mom freaked the first time she saw me with the new look, but hey, it’s sparkly and it’s sexy. And, well, these babies....”</i> Ceria reaches up to gesture to her ears. Her fingers accidentally brush up against one, and she bites her lower lip. <i>“These are just the </i>best<i>.”</i> Hm....");
	flags["CERIA_EAR_TOUCH_UNLOCKED"] = 1;
	//[Next] Go to Ceria Talk, open Touch Pointy Ears
	processTime(3);
	clearMenu();
	addButton(0,"Next",ceriaTalk);
}

//Touch Pointy Ears
public function touchPointyEars():void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("You reach out across the counter and run a finger across one of Ceria’s ears from near the base to the tip. The reaction is immediate; the rosette elf practically melts from the touch and gives a longer, lewder moan than you’ve heard some girls give in porn. You can’t help but give her a playful look as you pull your finger back. <i>“That sensitive?”</i>");
	output("\n\n<i>“[pc.name]! Warn me next time you’re going to do that!”</i> Ceria gives you an annoyed look as she slaps at your hand, though not all that hard. <i>“Yeah, they’re that sensitive. I have really good genetic compatibility with Sylvanol, so my ears are even more sensitive than for most people who try it. I knew a few schoolmates who’d used it, none of them came out with sensitivity like mine. Really sucks if I have to go somewhere cold, but the rest of the time it’s like being teased every time there’s a good stiff breeze. I don’t know how Nahri puts up with it.”</i>");

	//Global flag HEARD_OF_NAHRI is true: 
	if(flags["HEARD_OF_NAHRI"] != undefined) 
	{
		output("\n\n<i>“Oh? Nahri’s that way too?”</i>");
		output("\n\n<i>“Yeah, but don’t tell her I told you. Now - ah!”</i>");
	}
	else
	{
		output("\n\n<i>“Nahri?”</i>");
		output("\n\n<i>“My boss. I’ll tell you about her later if you wanna know. Right now, though - ah!”</i>");
	}
	output("\n\nCeria’s interrupted by you reaching out for another rub, this time pinning the very tip of her ear between your thumb and forefinger so that you can explore the contours of it. She reacts like you’d gotten down under the counter and started going down on her, which only spurs you onward to keep teasing your thumb all along and around her eartip. ");
	if(flags["SEXED_PENNY"] != undefined) output("You idly wonder who’s more sensitive, her or Penny. Certainly Ceria’s making a good argument for herself with how her hands grip the counter as she gasps for breath under your aural attention, her untouched ear twitching madly with every motion of your thumb.");
	else output("You’ve got her gasping for breath and gripping the counter to hold herself up almost immediately, her untouched ear twitching wildly every time your thumb moves even the slightest amount.");
	output(" Her moans are exquisite; she’d rival any holofilm slut and has the lungs to back it up. If she wasn’t visibly restraining her own volume, her only attempt at resistance, you suspect those out in the hallway would be getting an earful of their own.");

	output("\n\nFinally you let up, letting go of Ceria with one last flourish of your fingertips across the back of her ear. She promptly fumbles under the counter for a few seconds, pulling out a sign marking the salon as temporarily closed, and fixes you with a hungry look. <i>“Okay, after a display like that there’s no way you’re not taking responsibility for turning me on, right, " + pc.mf("hunk","cutie") + "?”</i>");

	pc.lust(12);
	processTime(8);

	ceriaSexMenu();
	//[Get Oral] Have Ceria give you some oral attention while you play with her ears. // Requires dick, vagina, or both.
	//[Give Oral] Put your tongue to work on Ceria’s snatch. // No requirements.
	//[Fuck Ceria] Take Ceria to the break room and give her pussy a pounding. // Requires dick.
	//[Fairy Footjob] You wouldn’t mind finding out what those slipper feet feel like on your dick. // Requires dick.
	//[Give-And-Take Earplay] Let Ceria show you just how sensitive elven ears can really be. // Requires PC to have elven ears of at least 2 inches in length and a dick, vagina, or both.
	//[Back] Go to Ceria Talk
	addButton(14,"Back",ceriaTalk);
}


//Ceria Appearance
public function ceriaAppearance():void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("If you had to sum Ceria up in a phrase, it would be “sparkly bubblegum elf”. Practically everything about her, save for her well-tanned skin, is some shade of pink or blue, and most of it metallic at that. Her rose gold hair would hang down to just over her cleavage if it wasn’t tied back into a ponytail, while her eyes are a bright sapphire color with an unnatural gleam, both visibly the product of gene-modding. Her lips too are rose gold, either by mods or by lipstick. They’re just plump enough to be enticing without being slutty, and emphasized by the bubblegum you frequently see her blowing when she’s not doing someone’s hair.");
	output("\n\nA luminous pink arrowhead-like marking adorns each of Ceria’s cheeks, drawing attention to her other notable facial feature, the pair of seven-inch triangular ears that stick out horizontally from either side of her head. Each is as long as her head is wide, twitching and drooping to emphasize - indeed, dramatize - every shift of her expression.");
	output("\n\nBoth of Ceria’s arms are covered in what look like long metallic blue gloves, but they’re far too form-fitting to really be gloves. They must be the product of transformation as well, replacing her skin with a glistening lapis material that flows and shimmers every time her fingers flex. They come to gently pointed tips with no distinct fingernails, just flawless metal all the way from her hands to halfway up her upper arms. Her legs, though you can’t see them at the moment under her jeans, sport matching coverings from the thigh down. Unlike her hands, her feet forgo toes outright, instead being fused together and shaped in such a way that it looks as though she were wearing slippers with delicately pointed tips.");
	output("\n\nThe elven girl’s white top and blue jeans are cut just daringly enough that you can see the luminous pink body markings along her lean belly and cleavage, and of course plenty daring enough that you can get a good look at her cleavage itself. Ceria’s sporting a hefty DD-cup rack that sits high and proud on her chest, and as soon as she spots you looking her over she crosses her arms underneath them to push those twin volleyballs up higher still, giving you a playful wink. Her hips are no less impressive, and her butt is just big enough to give her jeans something to stretch nice and tight around.");
	output("\n\nStanding at 5\' 8\" tall, she’s just a touch on the tall side for a human female, though far from imposingly so.");
	if(fuckedCeria()) output(" You know from experience that she has a bubblegum-pink terran pussy between her legs, plus a cute little asshole between her cheeks right where it belongs.");
	//[Next] Go to Ceria Main
	clearMenu();
	addButton(0,"Next",approachCeria);
}

//Doing the Other Thing You’re Probably Here For
//Sex Menu
public function ceriseSexApproach():void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("Ceria glances around at your suggestion that she take a break to have some fun with you. <i>“Sure, why not? You’re the only one here, don’t have any appointments for a while and it’s not like the boss is around.”</i> She takes a moment to put a sign on the counter marking the salon as temporarily closed, then gives you an inviting look. <i>“So, what did you have in mind, [pc.name]?”</i>");
	ceriaSexMenu();
}

public function ceriaSexMenu():void
{
	clearMenu();
	showCeria();
	//[Get Oral] Have Ceria give you some oral attention while you play with her ears. // Requires dick, vagina, or both.
	if(pc.hasCock() || pc.hasVagina()) addButton(0,"Get Oral",getOralFromCeria,undefined,"Get Oral","Have Ceria give you some oral attention while you play with her ears.");
	else addDisabledButton(0,"Get Oral","Get Oral","You need a penis or vagina in the normal place to do this.");
	//[Give Oral] Put your tongue to work on Ceria’s snatch. // No requirements.
	addButton(1,"Give Oral",giveDatElfSlootOral,undefined,"Give Oral","Put your tongue to work on Ceria’s snatch.");
	//[Fuck Ceria] Take Ceria to the break room and give her pussy a pounding. // Requires dick.
	if(pc.hasCock() && pc.cockThatFits(400) >= 0) addButton(2,"Fuck Ceria",fuckCeria,undefined,"Fuck Ceria","Take Ceria to the break room and give her pussy a pounding.");
	else addDisabledButton(2,"Fuck Ceria","Fuck Ceria","You need a penis that’ll fit inside Ceria to fuck her.");
	//[Fairy Footjob] You wouldn’t mind finding out what those slipper feet feel like on your dick. // Requires dick.
	if(pc.hasCock()) addButton(3,"Footjob",fairyFootjob,undefined,"Fairy Footjob","You wouldn’t mind finding out what those slipper feet feel like on your dick.");
	else addDisabledButton(3,"Footjob","Footjob","You need a dick to get a footjob.");
	if(pc.hasVagina()) addButton(4,"Ear Fuck",earFuckWithCeria,undefined,"Ear Fuck","Since those ears are so sensitive, and of appropriate length... why not try putting one inside a vagina.");
	else addDisabledButton(4,"Ear Fuck","Ear Fuck","You need a vagina if you want to put her ear inside one.");
	//[Back] Go to Ceria Main
	addButton(14,"Back",approachCeria);
}

//Get Oral
public function getOralFromCeria():void
{
	clearOutput();
	showCeria(true);
	author("Couch");
	output("You tell Ceria you’d like to see what kind of skill all that bubblegum chewing has given her with her tongue.");
	output("\n\n<i>“Oh? Come on, then, [pc.name], right this way.”</i> Ceria takes a moment to dispose of her current piece of gum before she escorts you into the back of the salon, to a small but nicely decorated office-cum-break room. A fair chunk of the room is taken up by a big leather couch, which Ceria guides you to sit down on. The elven girl stands in front of you and turns her back to you before relieving herself first of her shirt and the lacy blue bra underneath, then of her jeans and panties, giving you a good look at the swirls of pink across her back.");
	output("\n\n<i>“Dunno if you’re one of those " + pc.mf("guys","girls") + " who cums buckets, and these are the only clothes I have with me, so I’d rather not risk getting them stained.”</i> Ceria folds an arm across her chest before she turns back around and slips down to her knees in front of you, giving you just enough of a glimpse at her pussy along the way to know she’s already glistening wet. <i>“Now, let’s see what you’ve got down here for me to play with, " + pc.mf("hunk","cutie") + ".”</i>");
	output("\n\nYou don’t have to be told twice, shedding your gear to let ");
	if(pc.hasCock()) output("your [pc.cocks]");
	if(pc.hasCock() && pc.hasVagina()) output(" and ");
	if(pc.hasVagina()) output("[pc.eachVagina]");
	output(" out into the open air.");

	var dick:Boolean = false;
	
	if(pc.hasCock() && pc.hasVagina()) dick = (rand(2) == 0);
	else if (pc.hasCock() && !pc.hasVagina()) dick = true;
		
	//PC has multiple cocks, multiple vaginas, or a mixed set, Ceria picks one sex organ at random:
	if ((pc.hasCock() && pc.hasVagina()) || pc.cocks.length > 1 || pc.vaginas.length > 1)
	{
		output("\n\n<i>“Ooh, you’re giving me some options here. Let’s see here, I think I’ll try...”</i> Her finger hovers back and forth over your groin before settling on ");
		if(dick) output("[pc.oneCock]");
		else output("[pc.oneVagina]");
		output(". <i>“...This one.”</i>");
	}
	
	var x:int = -1;
	if(dick) 
	{
		x = pc.cockThatFits(400);
		if(x < 0) x = pc.smallestCockIndex();
		output("\n\nCeria starts off by wrapping a hand around your dick, letting you feel the cool softness of her glittering gloved hand. Despite the metallic appearance her fingers are flawlessly silky smooth, practically gliding across the [pc.cockColor " + x + "] surface of your cock.");
		output("\n\n<i>“Nice, hm? I’m not enough of a fairy fanatic to want wings, but these? Totally worth losing being able to do my nails for.”</i> Ceria keeps stroking until the very first droplet of [pc.cumColor] pre begins to form at your [pc.cockHead " + x + "], at which point her handjob stops. You’re given just enough time to catch your breath before you finally feel those glittering lips brush your cock, as Ceria tips her head down to envelop the [pc.cockHead " + x + "] and the first inch of your dick with her mouth.");
		output("\n\nShe holds you there, sucking on the tip of your cock like a candy while her tongue slowly slides back and forth across your cumslit, making sure any [pc.cumFlavor] goodness that starts to bubble out doesn’t stay there for long. Her ears droop just a little as she starts to relax, closing her eyes. Presented with such a tempting target, you can hardly resist, and you reach down to start stroking Ceria’s ears. She immediately gives a whimper of pleasure, muffled by your dick in her mouth.");
		output("\n\n<i>“Keep sucking.”</i> you tell her, running one finger back and forth along the edge of Ceria’s ear. Ceria shivers, but soon obeys, resuming sucking your dick with a bit more hunger behind it. <i>“That’s a good girl.”</i>");
		output("\n\nCeria continues to whimper and groan, seemingly getting more pleasure out of the blowjob now than you are. There’s plenty for you to enjoy, though, between her lips wrapped around your [pc.cockHead " + x + "] and her silky fairy glove still wrapped around the base of your shaft");
		if(pc.hasKnot(x)) output(", your throbbing knot cupped in her palm");
		output(". And of course you can hardly forget that skillful sylvan tongue, tracing all sorts of patterns back and forth along your tip, trying desperately to make you cum before your hands make her melt.");
		if(pc.cumQ() < 200) 
		{
			output("\n\nFinally you can’t hold your [pc.balls] back any longer, letting out a grunt as you fill Ceria’s mouth with your [pc.cumNoun]. Even as she’s whining from an orgasm of her own, Ceria manages to swallow every last drop, not letting go of your dick until there’s not a speck of [pc.cumColor] seed left to stain it. You let go of Ceria’s ears so she can sit back, opening her mouth to show you that she’s swallowed it all.");
			output("\n\n<i>“Did you enjoy your lunch?”</i> you offer with a playful smile, prompting one from Ceria in return.");
			output("\n\n<i>“Definitely tasty, but feeling glad I took my pants off before I started. You really know how to work a girl’s ears, " + pc.mf("hunk","cutie") + ".”</i>");
		}
		else
		{
			flags["CERIA_MOUTH_FLOOD"] = 1;
			output("\n\nFinally you can’t hold your [pc.balls] back any longer, letting out a grunt as you fill Ceria’s mouth with your [pc.cumNoun]. Ceria puts up a valiant effort, but your torrential supply of seed is too much, and she’s forced to let go with a keening gasp, falling back against the coffee table behind her while you douse her face and those bouncy elf tits with your [pc.cumNoun]. Lucky for her she took her clothes off beforehand, or she’d be wearing a [pc.cumColor] shirt for the rest of the day.");
			output("\n\nAs she comes to, Ceria surveys her sticky form with a groan. <i>“Oh geez, you </i>are<i> one of those " + pc.mf("guys","girls") + " who cums buckets! You could have warned me, [pc.name]!”</i> You point out that she hardly would have been able to remember while she was cumming, leading her to playfully bat at your thigh with one hand. <i>“And whose fault is that? You’re the one who was working magic on my ears the whole time.”</i>");
		}
	}
	else
	{
		output("\n\nCeria starts off by licking two of her own fingers, showing off her glittering fairy gloves in the process. <i>“Mmm... totally worth not having nails, these are way better.”</i> Once the metallic blue is glistening with a thin layer of saliva, she slips her fingers into your pussy, gently working them around to help loosen you up a bit and give her a feel for your snatch’s shape. She also takes a moment to rub ");
		x = rand(pc.vaginas.length);
		if(pc.vaginas[x].clits < 1) output("your labia");
		else if(pc.vaginas[x].clits == 1) output("your clit");
		else output("each of your clits, with a level of familiarity that suggests she’s no stranger to alien pussy");
		output(", stopping only when her fingers have a nice coating of your [pc.girlCumNoun] for her to taste.");

		output("\n\n<i>“Mmm... nice and [pc.girlCumFlavor]. Now then....”</i> Ceria dips her head down and runs her tongue up your feminine slit, all the way from the bottom edge to the top. Seeing you shudder prompts her to do it again. Each lick digs a little deeper than the one before, the tip of her tongue gradually sinking into your [pc.vaginaColor " + x + "] folds where it can start sliding back and forth over your ");
		if(pc.vaginas[x].clits < 1) output("labia.");
		else if(pc.vaginas[x].clits == 1) output("clit.");
		else output("clits.");

		output("\n\nIn your pleasure you reach down to the sides of the elf girl’s head, and she immediately gives a muffled gasp as your fingers brush her ears.");

		output("\n\n<i>“Come on, don’t stop. Eat that [pc.vagina " + x + "], you horny elf.”</i> you insist, tracing a finger along the base of Ceria’s ear. She whimpers, but starts eating you out more fervently, rendered submissive by your aural attention. <i>“Yes, that’s it, get your tongue in there.”</i> You let out a coo of pleasure as Ceria’s tongue flicks against your g-spot, her lips pressed firmly against your snatch. A little bit of moving your fingers back and forth whenever she strikes an ideal tempo is all it takes to motivate her.");
		output("\n\nSoon the both of you are moaning in earnest; indeed, you suspect she’s probably getting more pleasure out of this than you are. Still, it’s plenty enough that soon you can feel an orgasm mounting, and your crooning gives way to a shout of Ceria’s name as you find release upon the young elf’s tongue. Ceria continues to lick at your [pc.girlCumFlavor] cunt even as you cum, pulling away with a gasp and ");
		if(pc.wetness() < 3) output("plenty of fresh [pc.girlCum] coating her glittering lips.");
		else output("[pc.girlCum] all over her face.");

		output("\n\n<i>“Oh, " + pc.mf("hunk","cutie") + ", you really know how to make a girl’s ears feel like heaven. I’m glad I took my pants off first.”</i>");
		if(pc.wetness() >= 3) output(" Ceria wipes her face down with her hands, licking them clean of your [pc.girlCumNoun]. <i>“Could’ve warned me you were such a faucet down here, though... well, not that I mind with a pussy as [pc.girlCumFlavor] as yours.”</i>");
	}
	output("\n\nYou help Ceria clean up the mess the two of you have made and retrieve your gear before she ushers you out to clean herself off. A minute later she returns to the salon counter, a fresh piece of bubblegum in her mouth and a very satisfied look on her face.");
	processTime(24);
	pc.orgasm();
	fuckedCeria(true);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//Give Oral
public function giveDatElfSlootOral():void
{
	clearOutput();
	showCeria(true);
	author("Couch");
	if(flags["EATEN_CERIA_OUT"] == undefined)
	{
		output("You tell Ceria that you’d like to see if she tastes the way she looks.");
		flags["EATEN_CERIA_OUT"] = 1;
	}
	//Repeat encounter: 
	else output("You tell Ceria that you’d like to get a taste of that sweet elf pussy again.");

	output("\n\n<i>“Ahaha, sure, I could go for that. Come on, then, [pc.name], follow me.”</i> Ceria takes a moment to dispose of her current piece of gum before she escorts you into the back of the salon and into the break room. Ceria pulls away so that you can watch her unzip her fly, sliding down her jeans to reveal her underwear, if you can even call it that. The material is lacy and thin, the only solidly covering part being a glittering blue leaf pattern laid over her pussy, the color perfectly matching her arms and legs.");

	output("\n\n<i>“Like what you see, " + pc.mf("hunk","cutie") + "?”</i> Ceria asks you with a teasing grin, rubbing a finger up and down over the leaf. <i>“Come on and take it off.”</i> You get down on your knees to obey, pulling down the undergarment to reveal Ceria’s pussy. There’s a light bit of suction at the leaf, and as soon as it pulls away you’re hit with a delicious sweet scent. A taste of Ceria’s nether lips is all you need to confirm it: she’s definitely put some mods into her pussy, replacing her juices with a sugary strawberry nectar.");

	output("\n\nCeria looks down at you, still sporting that grin. <i>“Something wrong?”</i>");
	output("\n\n<i>“Not at all, just figured you were going to taste like bubblegum.”</i>");
	output("\n\nCeria laughs. <i>“I considered it! But no, I like this better for my pussy. Drink all you want, I’ve got plenty.”</i>");
	output("\n\n<i>“Oh, you bumped up the volume too?”</i> you ask, sweeping a finger over the elf’s snatch and coming away with quite a bit more nectar than you’d expect from a human. She just giggles.");
	output("\n\n<i>“Maybe just a little. Now c’mon, [pc.name], get licking.”</i>");

	output("\n\nYou obediently put your hands on Ceria’s hips and start licking, earning a sultry coo from the elf as well as a fresh dose of your sweet reward. One of her hands comes to rest on the back of your head, while the other slips under her shirt to grope her own tit while you tend to her sweet sylvan twat.");

	output("\n\n<i>“Oh, baby... that’s it, [pc.name], right there! Lick me right there!”</i> Every flick of your tongue draws out more nectar for you to savor. The taste is just light enough that it doesn’t overload your senses, though your tongue’s attentions are certainly overwhelming hers. Ceria throws her head back and lets out a long, loud groan as you pull back enough to play with her clit some, adopting a back-and-forth rhythm of teasing her clit for a few seconds and then licking up the nectar that comes spilling forth from the attention. Ceria’s a vocal one, moaning and egging you on with every lick.");

	output("\n\n<i>“Come on, come on, keep going! I’m almost - ah! Yesssss....”</i> For all that she’s crying out from the licking itself, Ceria’s actual orgasm is surprisingly quiet. The bubblegum elf hisses her pleasure as she finds release on your tongue, giving you one last surge of her strawberry nectar to enjoy before you pull away and slip her panties back into place. The leaf immediately forms a tight seal, allowing you to lick her thighs clean with no further leakage from her juicy twat. Ceria lets out a satisfied sigh as you pull away, and once you stand up the elven hairstylist gives you a kiss on the cheek.");

	output("\n\n<i>“Thanks, " + pc.mf("hunk","cutie") + ", you’re really awesome with that tongue of yours. You want some more, ask any time, ‘kay?”</i>");

	output("\n\nYou tell her you’ll have to come back for another sample sometime, and take a moment to gather your gear before returning out to the front of the salon. It’s going to be quite a while before your mouth stops tasting of strawberries and sugar.");

	//[Next] Exit conversation with Ceria.
	processTime(24);
	pc.lust(13+rand(10));
	fuckedCeria(true);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//Fuck Ceria
public function fuckCeria():void
{
	clearOutput();
	showCeria(true);
	author("Couch");
	var x:int = pc.cockThatFits(400);
	var y:int = pc.cockThatFits2(400);
	if(x < 0) x = pc.smallestCockIndex();
	output("You tell Ceria that you’d like to take her into the break room for some fun if she’s interested. She leans further over the counter, giving you an amused look. <i>“Oh, feeling forward, are you? Sure, I’ve got time for a break.”</i> The hairstylist disposes of her bubblegum before she escorts you into the back of the salon and into the break room.");
	output("\n\nNo sooner is the door closed than you feel Ceria’s breasts press up against your [pc.chest] and her arms drape around your hips. You take the hint and kiss her, tasting the strawberry flavor of her metallic lips. Ceria pulls you closer and brings one hand up to your back");
	if(pc.hasWings()) output(", her fingers brushing that sensitive spot right between your wings. Oh, yes, she definitely knows what she’s doing back there");
	output(".");

	output("\n\nYou bring your own hands up under her shirt, your kiss briefly interrupted as you pull the elf’s top up and off. She makes sure to pick it back up right where you left off as soon as her shirt falls to the side. You untie her bra as well, allowing you to get at Ceria’s bubblegum-pink nipples and give one a tweak. She moans around the kiss in response, reflexively pulling you in closer. Her pants and panties come off next, and your own gear shortly after. Each shed piece of clothing causes Ceria to step up the kiss a bit more, gradually going from just tasting to a wet, sloppy makeout session that has your tongues vying for dominance");
	if(pc.hasTongueFlag(GLOBAL.FLAG_PREHENSILE)) output(", though with your superior flexibility it’s not even remotely a contest");
	output(".");

	output("\n\nCeria only breaks off the kiss when one of her hands slips down between your thighs, taking a feel of your ");
	if(pc.cockTotal() == 1) output("dick");
	else output("dicks");
	output(". ");

	//Single dick, 9 inches or less:
	if(y < 0 && pc.cocks[0].cLength() <= 9) output("<i>“Ooh, this bad boy’s nice and hard for me already.”</i>");
	//Single dick, 9+ inches:
	else if(y < 0) output("<i>“Damn, [pc.name], you’re packing a real monster, aren’t you?”</i> Ceria licks her lips eagerly. <i>“Let’s see if it feels as good as it looks.”</i>");
	//2 dicks: 
	else if(x >= 0 && y >= 0 && pc.cockTotal() == 2) output("<i>“Oh? Oh wow, you’ve got something special down here. I’m not usually big on anal, but....”</i> Ceria gets a heady grin on as she brushes her fingers up and down each of your cocks. <i>“For you, I think I’ll make an exception.”</i>");
	else 
	{
		output("<i>“Oh, you’re a greedy " + pc.mf("boy","girl") + ", aren’t you? I can’t take all of these, sorry.”</i> Her hand runs across all of your dicks before coming to just your [pc.cock " + x + "] and [pc.cock " + y + "]. <i>“But I can handle these two just fine.”</i>");
	}

	output("\n\nCeria sits back on the break room couch, putting her hands behind her head and arching her back just a little bit to push out her chest. You climb up on top of her and kiss her again, ");
	if ((pc as Creature).biggestTitSize() >= 1)
	{
		output(" pressing your ");
		if(pc.biggestTitSize() < 4) output("smaller");
		else if(pc.biggestTitSize() <= 6) output("matching");
		else output("larger");
		output(" bust against hers and");
	}
	output(" bringing her down onto her side and then her back so that you can properly mount her. Her legs end up wrapped around your waist, your ");
	if(y < 0) output("dick");
	else output("dicks");
	output(" quickly getting a bit of Ceria’s sweet nectar all over ");
	if(y < 0) output("its tip");
	else output("their tips");
	output(" thanks to the elf’s mounting arousal and extra-moist pussy. You don’t keep her waiting for long, pushing your hips forward to ease inside.");

	if(y < 0) 
	{
		output("\n\nShe’s nice and tight, that ample nectar making it a breeze to sink your dick into the even wetter depths ahead");
		if(pc.hasCockFlag(GLOBAL.FLAG_TAPERED,x)) output(", especially with your tapered tip perfect for easing open a pussy");
		else if(pc.hasCockFlag(GLOBAL.FLAG_FLARED,x)) output(", even with your fat, flat tip, though the little <i>“unf”</i> that issues forth from Ceria’s lips as your flare overcomes her resistance is quite enjoyable");
		output(". The way she croons as your shaft starts to slide into her depths makes it all the more satisfying, and soon you find yourself packing inch after inch of dick into that tight little elf twat.");
		pc.cockChange();
		output("\n\n<i>“Oh yeah, [pc.name], that’s it, fill me up...");
		if(pc.cocks[x].cLength() > 9) output(" Fuck, so </i>big<i>..");
		output(".”</i> Ceria’s arms go from behind her head to around your back");
		if(pc.hasWings()) output(", her fingers gently brushing your wingpoints");
		output(" as you start to fuck her. She’s too sopping wet not to savor; you work your hips slowly, every thrust producing that delicious sloppy sound accompanied by Ceria’s lovely moans.");

		output("\n\n");
		if(pc.biggestTitSize() < 1) output("You start picking up the pace just a little bit, until each roll of your hips is accompanied by those big tanned tits bouncing up and down in time with your sexual rhythm.");
		else 
		{
			output("As you pick up the pace, you’re treated to the sensation of her breasts grinding against yours, every so often providing you both with a light flash of extra pleasure when your ");
			if(pc.hasLipples()) output("teat-mounted lips caress her nipples.");
			else output("nipples brush against one another’s.");
		}
		output(" You hold this way, resisting the urge to plow Ceria’s pussy any faster lest you cum before you’ve had your fill. You want her to cum first, want to feel what it’s like for her to be gushing around your dick if she’s already this drenched, and it looks like this horny little elf is going to oblige.");

		output("\n\n<i>“Aah... aahnyeah, [pc.name], more! More!”</i> Ceria’s moans soon grow louder, more desperate, more hungry for her impending release. You give her a grin that’s practically feral, relishing the way her voice just keeps getting higher as she nears her climax. Soon she lets out a scream of relief, her bubblegum cunny gripping your dick as she douses it with a veritable fountain of sugary nectar. Your response is a guttural grunt; with your [pc.balls] feeling tight and ready to burst, the stimulation is plenty enough for you to hit your own climax.");

		if(pc.cumQ() < 1000) 
		{
			output("\n\nYou cum, mixing that sweet nectar with your own [pc.cumFlavor] spunk. Ceria’s cunt squeezes even tighter at the first spurt, milking you for all you’re worth until there’s a frothy mix of pink and [pc.cumColor] bubbling out around the sides of your dick.");
			if(pc.hasVagina()) output(" Underneath your cock, you feel [pc.eachVagina] clench as if gripping a dick of its own, sending [pc.girlCumNoun] streaming down your thighs.");
			output(" You pause, breathless, soaking in the afterglow for a few long seconds before finally pulling out with one last wet pop. Ceria looks dazed, letting go of your back as her arms drop limp at her sides.");

			output("\n\n<i>“Oh gods, [pc.name], that was great....”</i> As Ceria returns to her senses she scoops up some of the froth with her fingers, popping them into her mouth to sample the mix of sweet and [pc.cumFlavor] flavors. <i>“Mmm... oh, I like. We’ve gotta do this again and soon, " + pc.mf("hunk","cutie") + ".”</i>");
			output("\n\n<i>“Couldn’t agree more.”</i> you reply with a playful look, taking a bit of a sample for yourself as you help Ceria clean up. She ushers you out once you’ve gotten your gear back on, and comes back out to the counter a minute later with a <i>very</i> satisfied smile clinging to her lips.");
		}
		else
		{
			output("\n\nIt comes out of you like a geyser, overcoming the flow of Ceria’s nectar and pushing forcefully back into her womb. At first her depths are hungry for the cum, but your inhuman output is far superior to anything her body is meant for, and soon you’ve got Ceria groaning from the strain as you pack her full of so much [pc.cumNoun] that her belly begins to swell, the once-trim elf looking pregnant by the time the pressure is too much and [pc.cumColor] starts spurting out from around the sides of your dick, splattering against your thighs.");
			if(pc.hasVagina()) output(" Underneath your cock you feel [pc.eachVagina] twitching as if wishing it was getting such a stuffing, having to settle for sending [pc.girlCumNoun] streaming down your thighs.");

			output("\n\nCeria lets go of your back and goes limp as you pull out, a glazed expression on her face. Even her ears droop as if lacking the strength to hold themselves up, so thoroughly have you fucked the strength out of her. <i>“Ooogh... s-so fulllllll....”</i> For a little bit you think you’ve broken her, but gradually she returns to her senses, her hands roaming across her stretched belly with wonder. <i>“Oh wow, that’s... wow. Warn me the next time you’re going to cum that much, " + pc.mf("hunk","cutie") + ".”</i>");
			output("\n\nYou grin back at her. <i>“No promises.”</i>");
			output("\n\nIt takes you quite some time to clean up the mess before Ceria ushers you out. She comes back out several minutes later looking good as new, though perhaps weak-legged and with a little more curve to her belly than usual.");
		}
	}
	else
	{
		output("\n\nShe may have said she’s not big on anal, but you can hardly tell with how little resistance Ceria’s sphincter offers, taking your [pc.cockHead " + y + "] with a whimper from the elf. At the same time, your [pc.cock " + x + "] is enjoying the pleasure of her pussy, which is so wet and slippery that it’s an absolute breeze to sink inside to the hilt. You’re rewarded with Ceria’s wide-eyed pleasure face as she tries to maintain steady breathing while you fill both of her holes with dick.");
		pc.cockChange();
		output("\n\n<i>“Nngh... o-okay, I got this... just go slow, [pc.name], okay?”</i>");
		output("\n\nYou agree, wanting to savor this anyway. The tight, rhythmic squeezing of her ass, the drenched softness of her pussy, each of your dicks soaking in a different kind of pleasure that combine for a truly heavenly fuck as you slowly roll your hips. Every time your [pc.cock " + y + "] starts to pull out of her ass it’s with the same motion that your other [pc.cock " + x + "] buries itself to the hilt in her cunt. Every motion draws a little gasp of shock from Ceria as the slightly desynchronized fucking keeps her from ever quite relaxing between thrusts. Oh yes, having two cocks is just the <i>best</i>.");
		output("\n\nCeria draws her arms around your back");
		if(pc.hasWings()) output(", her fingers caressing your wingpoints");
		output(" as you plow her.");
		if(pc.biggestTitSize() < 1) output(" You start picking up the pace a little bit, getting Ceria’s tits to start heaving upward every time [pc.cock " + y + "] plunders the hot depths of her ass, landing with a heavy bounce just as you’re pulling [pc.cock " + x + "] out from the soaking depths of her pussy.");
		else 
		{
			output(" As you pick up the pace you’re treated to the sensation of her breasts grinding against your ");
			if(pc.biggestTitSize() < 4) output("smaller");
			else if(pc.biggestTitSize() <= 6) output("matching");
			else output("larger");
			output(" rack, your tits rolling back and forth in time with your hips.");
		}
		output(" You maintain this speed, enjoying watching Ceria quiver and moan under your double-pronged plowing. Still, no matter what the speed, the pleasure from two dicks is eventually too much, and you feel your [pc.balls] churning with the imminent need to cum, to stuff this elf full in front and back alike.");

		if(pc.cumQ() < 1000)
		{
			output("\n\nYou feel your [pc.cumNoun] begin to gush forth in alternating spurts, each producing a tiny gasp from Ceria as you fill her with your [pc.cumVisc] spunk. Both of her holes squeeze even tighter, massaging your dicks as if trying to coax even more cum out. Soon there’s a frothy mix of pink and [pc.cumColor] wreathing the sides of [pc.cock " + x + "], while Ceria’s ass does a much better job of holding your [pc.cumNoun] inside.");
			if(pc.hasVagina()) output(" Underneath your cocks, you feel [pc.eachVagina] clench as if gripping a dick of its own, sending [pc.girlCumNoun] streaming down your thighs.");
			output(" You can’t help but grin in satisfaction as a little bit of [pc.cumColor] bubbles out from Ceria’s ass as you pull out, with the elf’s arms dropping from your back to go to her belly.");
			output("\n\n<i>“Oof... still not used to being stuffed back there....”</i> Ceria groans a bit as she rubs herself. <i>“Still, it certainly wasn’t bad. You want to do this again, [pc.name], don’t be afraid to ask.”</i>");
			output("\n\n<i>“Oh, I won’t.”</i> you reply as you reach down to Ceria’s pussy, sampling some of your mixed fluids. Her sugary strawberry flavor makes an excellent complement to your own [pc.cumFlavor] taste, and you end up sampling a few more times as you help Ceria clean up, earning a playful swat from her.");
			output("\n\n<i>“That’s enough, you greedy " + pc.mf("boy","girl") + ", now get out of here so I can finish.”</i> She ushers you out once you’ve gotten your gear back on, and comes back out to the counter a few minutes later, looking quite satisfied.");
		}
		else
		{
			output("\n\nYou can feel the first pulse come flowing up your dual cumveins, a thick dose of [pc.cumNoun] that gushes out of your [pc.cock " + x + "] into Ceria’s waiting cunt. The second follows a moment later, blasting into her ass as you start cumming in a continuous back-and-forth rhythm. Both of her holes squeeze even tighter, her ass practically vicelike around your [pc.cock " + y + "] as if trying to prevent you from filling her in back, but your inhuman output will not be so easily denied. Soon her cries of ecstacy turn to moans of shock as you fill her with so much cum that it makes her once-slim belly swell until she looks practically gravid, her twat and tailpipe alike packed to the brim with your [pc.cumVisc] seed.\n\nYou’d gladly fill her even more, but her tightness isn’t quite so great as to allow that. The excess [pc.cumColor] spunk floods out around the sides of your cocks to cover your thighs in your own [pc.cumNoun].");
			if(pc.hasVagina()) output(" Underneath your dicks, you feel [pc.eachVagina] twitching as if wishing it was getting so gloriously filled, having to settle for adding a wash of [pc.girlCum] to the mess between your legs.");
			output("\n\nYou pull out to find Ceria’s gone limp and slack-jawed, letting out a dazed groan. Her eyes are half-shut and her ears droop low, fucked and stuffed so thoroughly that she’s gone completely insensate. The moment you pull out, massive spurts of [pc.cumNoun] start belching from her pussy, her own juices completely swallowed up by your titanic flood. It looks like she’s not going to come back to her senses for a little while after a fucking like that, so you clean up as best you can and make sure she’s comfortable, giving the elf girl a kiss on the forehead before you take your leave.");
			output("\n\nIt’s quite a while before Ceria comes back out to the counter, looking back to normal. She shoots you an annoyed look, but you can’t help but notice she’s got a bit of a smile tugging at her cheeks... and she’s looking just a little less trim than usual.");
		}
	}
	processTime(33+rand(10));
	pc.orgasm();
	fuckedCeria(true);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//Fairy Footjob
//You tell Ceria that you’re interested in those exotic fairy feet of hers.
public function fairyFootjob():void
{
	clearOutput();
	showCeria();
	author("Couch");
	output("<i>“Oho? Not too many people ask me about that... you want a closer look, " + pc.mf("hunk","cutie") + "? Come on, then, right this way.”</i> Ceria motions for you to follow her into the salon’s break room, her walk emphasizing her hips and legs a bit more than usual to keep your eyes on the glittering blue boots that cover everything from the thigh down, topped off in those sleek metallic slippers. Once inside Ceria gestures for you to sit down on the leather couch while she snatches up one of the spare cushions and tosses it on the table in front of you. You take a moment to relieve yourself of your gear as you sit, [pc.oneCock] already ");
	if(pc.hasSheath(pc.biggestCockIndex()) || pc.hasStatusEffect("Genital Slit")) 
	{
		output("poking out of its ");
		if(pc.hasSheath(pc.biggestCockIndex())) output("sheath");
		else output("slit");
		output(" and ");
	}
	output("half erect.");

	output("\n\nCeria sits down on the cushion and crosses her right leg over her left as if concealing her pussy, letting you get a good view of how slender and flawlessly smooth her legs are. There’s not a single blemish or even any visible joints to be found even when she moves, the skin perfectly retaining its contours. It’s as though her legs were sculpted from liquid azure metal.");

	output("\n\n<i>“Mmm, you like these, don’t you, [pc.name]? Look at that, you’re getting hard just looking at them.”</i> Ceria runs a hand along her leg, cooing as she does. <i>“They really are so much better than human legs. No nails to worry about, no need to shave, no need to wear heels... oh so low-maintenance and oh so sexy.”</i>");

	output("\n\nCeria slowly lifts the leg she’s folded and extends it outward, letting the tip of her slipper come to rest against your [pc.cockHeadBiggest]. Whatever her legs are made out of is pleasantly cool to the touch, and you swiftly become fully erect as she rubs the slipper around the edge of your cocktip");
	if(pc.hasCockFlag(GLOBAL.FLAG_FLARED,pc.biggestCockIndex())) output(", dipping underneath your flare to caress the underside");
	//cock is pointed:
	else if(pc.hasCockFlag(GLOBAL.FLAG_TAPERED,pc.biggestCockIndex())) output(", lightly flicking your pointed tip");
	else if(pc.hasCockFlag(GLOBAL.FLAG_NUBBY,pc.biggestCockIndex())) output(" and weaves the tip deftly back and forth between your nubs");
	output(".");

	output("\n\n<i>“Oh, you naughty " + pc.mf("boy","girl") + ", you like my foot that much? Here, then, try the other.”</i> Her left leg comes up, this one going to the base of your dick and working it up and down");
	if(pc.hasKnot(pc.biggestCockIndex())) output(", caressing the underside of your knot");
	output(". She shows off the ability to flex her non-existent toes, the shape of her slipper practically molding itself to the contours of your cock. Her right foot continues to work your [pc.cockHeadBiggest], teasing your dick at both ends.");

	output("\n\nSoon you feel your precum bubbling up from inside you to form a thick droplet at your tip. As if on cue, Ceria’s right foot passes over your cumslit, catching the pre on the underside of her foot. She rubs it back and forth for a few seconds, then lifts her foot off your cock to show you the [pc.cumColor] staining her flawless azure slipper. When her foot comes back down it’s halfway down your shaft, ");
	if(pc.cocks[pc.biggestCockIndex()].cType == GLOBAL.TYPE_EQUINE) output("right on top of your medial ring, ");
	output("where she plants the underside of her foot against your shaft and begins to stroke up and down. Her left foot continues to work your [pc.knot " + pc.biggestCockIndex() + "], retaining its perfect coolness even as you feel yourself heating up from the exotic footjob.");

	output("\n\nYou hardly notice that Ceria’s feet have angled your dick towards yourself until you cum, ");
	if(pc.cumQ() < 250) output("sending [pc.cumNoun] splattering across your [pc.chest] to leave a [pc.cumColor] stain across your front.");
	else output("a fountain of [pc.cumColor] erupting from your cock to drench you in wave after wave of [pc.cumNoun].");
	//PC has fucked or been blown by Ceria before and has excessive volume: 
	if(pc.cumQ() >= 500 && flags["CERIA_MOUTH_FLOOD"] != undefined) output(" Ceria laughs as you wipe away some of the [pc.cumVisc] spunk from your face. <i>“Now you know what it feels like!”</i>");
	output(" You’re left to stew in your own juices for a few seconds as she admires the view before finally handing you a towel to start cleaning up. While you do, you’re treated to the sight of Ceria cleaning off her feet with a much smaller towel, buffing them until they’re glistening flawlessly once more without a hint of [pc.cumColor].");
	output("\n\nYou’re ushered out of the break room once you’ve cleaned yourself off, while Ceria lingers to set the room back in order. She comes back out to the front shortly after, giving you a wink.");

	processTime(15+rand(4));
	fuckedCeria(true);
	pc.orgasm();
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}

//[DUN] lesbian scene with a long pointy eared species using the ear as a vaginal insertion toy - include particle beam weapons for ship (I don't care if it has ship combat or not)
//Offbeatr Custom Scene 4: Mindworm
public function earFuckWithCeria():void
{
	clearOutput();
	showCeria(true);
	output("Looking at the elf-girl’s quivering ears, an idea as perverted as it is brilliant strikes you. You reach out to gently stroke along the edge of Ceria’s ear, smiling when she quivers in bliss. <i>“You ever tried sliding one of these inside of someone before?");
	if(pc.isBimbo()) 
	{
		output("”</i> You giggle");
		if(pc.hairLength > 2) output(" and twirl your hair");
		output(". <i>“I bet they feel just as good as any cock!");
	}
	else output(" They must be what, six or seven inches long? That’s cock-sized, dear.");
	output("”</i> Letting go so that the poor girl can stop squirming and think, you move your palm down to [pc.oneVagina]");
	if(!pc.isCrotchExposed()) output(", pushing your [pc.lowerGarments] out of the way to better allow access");
	output(", gently caressing your ");
	if(pc.lust() >= 75) output("flushed");
	else output("rapidly flushing");
	output(" pussy.");
	output("\n\nCeria watches, spellbound. ");
	if(flags["CERIA_EARFUCKS"] != undefined) output("<i>“A-again?”</i> Her knees buckle, though whether from your teasing or her eagerness for her next ear-fuck, you’ll never know. One thing for certain is that the elf is fluttering her eyelashes and gently chewing her gold-hued lip, tilting her head so that all you’d have to do is reach out and grab hold. Her cheeks flush hotter, moment by moment, all but begging you to stuff her sensitive ear as far into your twat as possible.");
	else output("<i>“I-inside?”</i> Her knees knock together, and she nervously chews at her lips, ignorant of the flush spreading across her cheeks. <i>“No I haven’t, but...”</i> she lowers herself to the ground, turning to let one of her flopping, pointed lengths point your way, <i>“...I’m willing to give it a try. If you’re gentle.”</i> Looking up at you, her blush instantly deepens, and her ear quivers, bouncing provocatively. All you have to do is scoot forward and slide it inside...");
	output("\n\nYou can barely contain yourself, rather than rushing forward and pounding your puss into the side of her head, you take your time, gathering ");
	if(pc.wettestVaginalWetness() >= 5) output("a handful of your free-flowing fluids");
	else if(pc.wettestVaginalWetness() >= 4) output("a palmful of your ever-present vaginal lubrication");
	else if(pc.wettestVaginalWetness() >= 3) output("a palmful of your abundant fluids");
	else output("a palmful of your increasingly voluminous lubricant");
	output(". <i>“Hold still,”</i> you bid, cupping the underside of the elf’s twitching ear. Smearing your [pc.girlCum] along the smooth skin, you delight in the way your every motion is reflected on Ceria’s face. She gasps and shudders, letting her eyelids droop low as the pleasure eats away at the dregs of her self-control. Her blue-encased thighs quiver delightfully as you round the very tip of her elven blessing, and as you make a stroke back along the top edge, she can’t help but audibly moan, her lips parted in whorish bliss.");
	output("\n\nEncouraged by the sight of the lust-drunk elf, you wrap your fingers the whole way around and start to pump her from wide base to narrow tip, jacking off Ceria’s ear just as fast and hard as any dick. She reacts about as you would expect. Her mouth hangs slack whenever it isn’t moaning obscenities, and tiny puddles of drool are beginning to form atop her DD-cup cleavage. She seems oblivious to her own state, so oblivious that she doesn’t even react when you start smearing pussy-juice on her other ear, allowing you to pump both sides of her head equally forcefully.");
	output("\n\nCeria’s eyes roll back until they’re little more than white slits, and a ragged moan rips its way out of her throat, blissfully screaming, <i>“Yessssss!”</i> Her hips twitch wildly, and the scent of strawberries fills the air, followed shortly by the sound of her sweet-scented girlcum splattered against the floor. You let go of her ears, too turned on by elf to hold back any longer. It’s time you got to ride one of those sexy, elven blessings and see if your pussy can make her squirt as easily as your hands.");
	processTime(10);
	pc.lust(25);
	clearMenu();
	addButton(0,"Next",earFuckCeriaPart2);
}
public function earFuckCeriaPart2():void
{
	clearOutput();
	showCeria(true);
	
	var x:int = rand(pc.vaginas.length);
	
	output("Ceria is like dough in your hands, heavy and pliant. If you weren’t holding her up, she’d probably slump down into her own puddled juices. Holding her forehead, you guide the tip of her ear up to the lips of your [pc.vagina " + x + "], rubbing it gently against your lips. It’s cooler than you expected, nowhere as hot and urgent as a penis might be, but the contact with your sordidly-soaked snatch soon has it warming. You ease it in and moan in delight, matched by Ceria’s answering cry.");
	output("\n\n<i>“Ahh!”</i> The elf’s hips buck, and you have to hold her tight to keep her from slipping away. In the process, her slender ear dips further into your [pc.vaginaNoun " + x + "], it’s narrow tip seemingly designed to perfectly spread your canal. Now that the process has started, you see no point in slowing and push her ear in further, sliding inch after inch of quivering elven bliss into your deepest depths. You had no idea that she could make it quiver so pleasurably! Ceria’s ear twitches with every thrust, rubbing on your most sensitive places, making you wet enough to mat her hair to the side of her head as you slide home.");
	if(pc.clitLength >= 4)
	{
		output("\n\nYour oversized clit");
		if(pc.totalClits() > 1) output("s shoot");
		else output("shoots");
		output(" bolts of pleasure up your spine when ");
		if(pc.totalClits() == 1) output("it");
		else output("they");
		output(" crash");
		if(pc.totalClits() == 1) output("es");
		output(" against Ceria’s silken locks, pressed between your body and hers. The human clitoris was never designed to be so big or so phallic, and you have to yank the elf back immediately lest you be overwhelmed by sensation. There’s so much that you could get off in a moment if you stayed there, impaled on her ear and grinding against her head, yet you know all too well that rushing to the peak so early would be ultimately unsatisfying.");
	}
	output("\n\nThe trembling stylist appears to be handling herself a little better now that you’re confining your attentions to a single point of contact. Her eyes are half open, and she’s moaning words again, things like <i>“yes,”</i> <i>“fuck,”</i> and <i>“faster!”</i> Looking down at her, you smile when you see her hands on her breasts. She’s handling herself roughly, making the pliant titflesh wobble and bounce, her rigid nipples slightly crinkled as fingers slide around their areolae.");
	output("\n\nAny attempt at conversation is abandoned, replaced by the heavy bump and grind of one sweaty body against another. Your [pc.vaginaNoun " + x + "] squelches lewdly with each back-and-forth movement, splattering more [pc.girlCumNoun] into Ceria’s hair with each passing second. The scent of your pussy fills the air, tinted with the strawberry flavor of the elf’s fruity ejaculations. You moan with her, tangling your fingers in her sodden locks, curling them around your knuckles as you slap her cheek with your cunt.");
	output("\n\nHot, liquid twinges roll through your belly and into your [pc.vaginas], making your passage");
	if(pc.totalVaginas() > 1) output("s");
	output(" clench and squeeze. Your [pc.legOrLegs] tremble");
	if(pc.legCount == 1) output("s");
	output(", jolting forward in an extra hard thrust, forcing you to take all of Ceria’s ear at once. The bizarre eroticism of it mixes in with your helpless ecstasy, flooding your [pc.vagina " + x + "] with bliss, both liquid and sensory. You can feel it flowing up your spine, robbing you of control of your muscles, making your body squirm and writhe on the end of Ceria’s ear.");
	if(pc.isSquirter()) output(" You splatter the side of her head with [pc.girlCumNoun], drenching her to the waist in your feminine enthusiasm.");
	if(pc.hasCock()) 
	{
		output(" [pc.Cum] washes over her crown when your [pc.cocks] sympathetically climax");
		if(pc.cockTotal() == 1) output("es");
		output(", spraying thick lines of [pc.cumColor] across her once perfectly arranged hair.");
	}
	output("\n\nYour fingers lose their strength, and you fall away from Ceria, her ear loudly slipping free from your twat, flinging girlish goo into the air as it snaps up to its usual angle. Aftershocks roll through your sensitized quim one after another, keeping you on the floor, cumming");
	if(pc.hasCock()) output(" all over yourself");
	else output(" everywhere");
	output(". Ceria lies right next to you, doing the same, her panties unable to hold back her gushing strawberry flavor.");
	processTime(20);
	pc.orgasm();
	clearMenu();
	addButton(0,"Next",earFuckCeriaPart3);
}

public function earFuckCeriaPart3():void
{
	clearOutput();
	showCeria(true);
	output("When Ceria recovers, she looks like she wants to be angry with you, to be mad at how effectively you’ve soiled her once immaculate appearance, but it’s tough for her to look stern with that fucked-out look just behind her eyes and strands of your nectar dripping from both her ears.");
	//First time
	if(flags["CERIA_EARFUCKS"] == undefined) output("\n\n<i>“That was messier than I expected... but fun. You’ll have to give me a few minutes to freshen up before I can re-open the shop.”</i> She bends low, still covered in your juices, and kisses you full on the lips. <i>“Thanks, gorgeous!”</i>");
	//Repeat
	else output("\n\n<i>“That was so worth the mess.”</i> Ceria bends low, still covered in your juices, and plants a messy kiss full on your lips. <i>“Let me go clean up, then I can re-open the shop... or go for round two.”</i>");
	//Merge
	output("\n\nYou’re left sitting there in a puddle of your own juices when she spins away, prancing off to a back room to clean up. A cleaning robot arrives in her absence, working to clean up the mess you two left on the floor, but the strawberry aroma lingers behind.");
	processTime(15);
	IncrementFlag("CERIA_EARFUCKS");
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}


//Appearance Adjustments
//New Stat
//[pc.hairstyle]
//String value. Default value of null. If null or an unrecognized value, does nothing. If a recognized value, adds a relevant line to appearance descriptor.

/*
Revised Description (Vanilla Hair)
Standard/unrecognized color, human ears
Your {length}, [pc.hairColor] hair looks good on you, accentuating your features well.
Standard/unrecognized color, nonhuman ears
The {length}, [pc.hairColor] hair on your head parts around a pair of {ears}.
Metallic hair, human ears
Your {length} hair looks good on you, sparkling with a metallic [pc.hairColor] sheen.
Metallic hair, nonhuman ears
The {length} hair on your head glitters with a [pc.hairColor] sheen, parting around a pair of {ears}.
Glowing hair, human ears
Your {length} hair possesses a natural luminance to it, a soft [pc.hairColor] that draws attention.
Glowing hair, nonhuman ears
The {length} hair on your head is [pc.hairColor], its glow parted by a pair of {ears}.

Added text by hairstyle, should be added to description text after existing descriptions of hair
Ponytail: Your hair is done up in a ponytail, keeping it comfortably out of your way while looking stylish.
Twintails: Your hair is tied into a pair of twintails, lending you a bit of feminine flair while keeping your hair nicely manageable.
Curls: Your hair’s entire length has been done into curls, giving it plenty of extra body.
Braided: Your hair is woven into braids that frame your face expertly.
Afro: Your hair is puffed up into one big mass of an afro.
Mohawk: Your hair is spiked up along the centerline of your head, giving you some punk attitude.
Mullet: Your hair is cut short in the front while displaying its full length only in the back, giving you a mixed look of business and casual.

List of Colors By Type
Standard
Auburn
Black
Blonde
Blue
Brown
Cerulean
Crimson
Dirty Blonde
Gray
Green
Lavender
Orange
Pink
Red
Violet
White
Yellow
Metallic
Amethyst
Bronze
Copper
Emerald
Gold
Pearl
Rose Gold
Ruby
Sapphire
Silver
Glowing
Luminous Blue
Luminous Green
Luminous Orange
Luminous Pink
Luminous Red
Luminous Silver
Luminous Violet
Glowing Gold

New Global Flag
HEARD_OF_NAHRI
Currently affects a piece of dialogue in the Touch Pointy Ears scene. Will eventually be used to cause Nahri to appear if/when her xpack is written.
*/
