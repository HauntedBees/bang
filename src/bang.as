package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * bang - an art game
	 * @author Sean Finch
	 * @version 21JUL2010
	 */
	/*	Copyright © 2010 - 2015 Sean Finch

    This file is part of bang.

    bang is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    bang is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with bang.  If not, see <http://www.gnu.org/licenses>. */
	public class bang extends Sprite{
		private var KILLER:MovieClip;
		private var WEAPON:MovieClip;
		private var GROUND:Number;
		private var BFIRED:Number;
		private var RELOAD:Boolean;
		private var THINGS:Array;
		private var PEOPLE:Array;
		private var HORROR:Array;
		private var DEBRIS:Array;
		private var WOUNDS:Array;
		private var TOREMO:Array;
		private var DIRECT:int;
		private var STCONT:int;
		private var WORDLY:TextField;
		private var PEOPLE_YOU_HAVE_KILLED:Array;
		private var GIBS:Array;
		private var BNGSND:Sound;
		private var RLDSND:Sound;
		private var plsydr:Boolean;
		private var snd1:Sound;
		private var snd2:Sound;
		private var snd3:Sound;
		private var snd4:Sound;
		private var snd5:Sound;
		private var W:Boolean;
		private var A:Boolean;
		private var S:Boolean;
		private var D:Boolean;
		private var isMoving:Boolean;
		public function bang() {
			W = false;
			A = false;
			S = false;
			D = false;
			isMoving = false;
			STCONT = 0;
			DIRECT = 1;
			KILLER = new Player();
			WEAPON = new Gun();
			snd1 = new cry01();
			snd2 = new cry02();
			snd3 = new cry03();
			snd4 = new cry04();
			snd5 = new cry05();
			BNGSND = new soundSHOOT();
			RLDSND = new soundRELOAD();
			plsydr = false;
			THINGS = [];
			PEOPLE = [];
			HORROR = [];
			DEBRIS = [];
			WOUNDS = [];
			TOREMO = [];
			GIBS = [];
			PEOPLE_YOU_HAVE_KILLED = [];
			var textformat:TextFormat = new TextFormat();
			textformat.size = 11;
			WORDLY = new TextField();
			WORDLY.defaultTextFormat = textformat;
			WORDLY.wordWrap = true;
			WORDLY.width = stage.stageWidth;
			WORDLY.height = stage.stageHeight / 2;
			WORDLY.selectable = true;
			WORDLY.mouseWheelEnabled = true;
			addChild(WORDLY);
			THINGS.push(WORDLY);
			KILLER.x = 100;
			KILLER.y = 150.5;
			GROUND = KILLER.y + KILLER.height / 2;
			BFIRED = 0;
			RELOAD = false;
			KILLER.gotoAndStop(1);
			WEAPON.gotoAndStop(1);
			addChild(KILLER);
			addChild(WEAPON);
			THINGS.push(KILLER);
			THINGS.push(WEAPON);
			stage.addEventListener(MouseEvent.CLICK, Murder);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, DownKey);
			stage.addEventListener(KeyboardEvent.KEY_UP, UpKey);
			addEventListener(Event.ENTER_FRAME, WhyWouldYouDoHorribleThings);
		}
		private function UpKey(e:KeyboardEvent):void {
			isMoving = false;
			switch(e.keyCode) {
				case 65:
					A = false;
					break;
				case 68:
					D = false;
					break;
				case 83:
					S = false;
					break;
				case 87:
					W = false;
					break;
			}
		}
		private function DownKey(e:KeyboardEvent):void {
			isMoving = true;
			switch(e.keyCode) {
				case 82:
					RELOAD = true;
					break;
				case 65:
					A = true;
					break;
				case 68:
					D = true;
					break;
				case 83:
					S = true;
					break;
				case 87:
					W = true;
					break;
			}
		}
		private function WhyWouldYouDoHorribleThings(e:Event):void {
			if (W||A||S||D) {
				STCONT += 1;
				if (STCONT % 10 == 0) { KILLER.gotoAndStop(2); }
				else if (STCONT % 6 == 0) { KILLER.gotoAndStop(3); }
			} else {
				STCONT = 0;
				KILLER.gotoAndStop(1);
			}
			if (W) {
				if (KILLER.y > (GROUND - 15)) {
					KILLER.y -= 2;
				}
			}
			if (S) {
				if (KILLER.y < (GROUND + 7)) {
					KILLER.y += 2;
				}
			}
			if (D) {
				KILLER.scaleX = 1;
				for each(var BULLETA:MovieClip in HORROR) {
					BULLETA.x -= 2;
				}
				for each(var INNOCENTA:Array in PEOPLE) {
					INNOCENTA[0].x -= 2;
				}
				for each(var EMCLIPA:Array in DEBRIS) {
					EMCLIPA[0].x -= 2;
				}
				for each(var GOREA:Array in GIBS) {
					GOREA[0].x -= 2;
				}
				for each(var WOUNDA:Array in WOUNDS) {
					WOUNDA[0].x -= 2;
				}
			}
			if (A) {
				KILLER.scaleX = -1;
				for each(var BULLETB:MovieClip in HORROR) {
					BULLETB.x += 2;
				}
				for each(var INNOCENTB:Array in PEOPLE) {
					INNOCENTB[0].x += 2;
				}
				for each(var EMCLIPB:Array in DEBRIS) {
					EMCLIPB[0].x += 2;
				}
				for each(var GOREB:Array in GIBS) {
					GOREB[0].x += 2;
				}
				for each(var WOUNDB:Array in WOUNDS) {
					WOUNDB[0].x += 2;	
				}
			}
			if (PEOPLE_YOU_HAVE_KILLED.length > 3) {
				PEOPLE_YOU_HAVE_KILLED.splice(0, 1);
			}
			var someRandomEvent:int = Math.ceil(860 * Math.random());
			if (someRandomEvent == 4) {
				AddRandomEvent();
			}
			if (RELOAD == true) {
				if (plsydr == false) {
					plsydr = true;
					RLDSND.play();
				}
				WEAPON.rotation = 90;
				WEAPON.x = KILLER.x + 2;
				WEAPON.y = KILLER.y + 5;
				BFIRED -= 0.5;
				if (BFIRED <= 0) { RELOAD = false; }
			} else {
				plsydr = false;
				WEAPON.rotation = 0;
				WEAPON.x = KILLER.x + 5.5;
				WEAPON.y = KILLER.y - 2.5;
			}
			for each(var BULLET:MovieClip in HORROR) {
				BULLET.x += 4;
			}
			for each(var INNOCENT:Array in PEOPLE) {
				LiveYourLifeYoungManBeforeItEnds(INNOCENT);
			}
			for each(var EMCLIP:Array in DEBRIS) {
				EMCLIP[1] += 0.5;
				if (EMCLIP[2] <= EMCLIP[3]) {
					EMCLIP[0].x -= EMCLIP[4];
					EMCLIP[0].rotation -= 10;
					if (EMCLIP[0].y >= GROUND) { EMCLIP[1] *= -0.4; EMCLIP[2] += 1; }
					EMCLIP[0].y += EMCLIP[1];
				} else {
					if (EMCLIP[0].rotation % 180 != 0) {
						EMCLIP[0].rotation -= 10;
					}
					if (EMCLIP[0].y < GROUND) {
						EMCLIP.y++;
					}
				}
			}
			for each(var GORE:Array in GIBS) {
				GORE[1] += 0.5;
				if (GORE[2] <= GORE[3]) {
					GORE[0].x -= GORE[4];
					GORE[0].rotation -= 10;
					if (GORE[0].y >= GROUND) { GORE[1] *= -0.4; GORE[2] += 1; }
					GORE[0].y += GORE[1];
				} else {
					if (GORE[0].rotation % 180 != 0) {
						GORE[0].rotation -= 10;
					}
					if (GORE[0].y < GROUND) {
						GORE.y++;
					}
				}
			}
			for each(var WOUND:Array in WOUNDS) {
				var removeBlood:Boolean = false;
				WOUND[2] -= 1;
				if (WOUND[2] <= 0) {
					WOUND[2] = 10;
					WOUND[1] += 1;
					if (WOUND[1] > 3) {
						removeBlood = true;
					}
				}
				if (removeBlood) {
					TOREMO.push(WOUND[0]);
					WOUND[3][1] = 3;
					var removeIndex:int = WOUNDS.indexOf(WOUND);
					WOUNDS.splice(removeIndex, 1);
				} else {
					WOUND[0].gotoAndStop(WOUND[1]);
				}
			}
			for each(var SPRI:* in TOREMO) {
				stage.removeChild(SPRI);
			}
			TOREMO = [];
			var randInt:int = Math.ceil(200 * Math.random());
			if (randInt % 200 == 0) {
				PEOPLE.push(InnocentYoungMan());
			}
		}
		private function AddRandomEvent():void {
			if (PEOPLE_YOU_HAVE_KILLED.length > 0) {
				var victim:People = PEOPLE_YOU_HAVE_KILLED[Math.floor(Math.random() * PEOPLE_YOU_HAVE_KILLED.length)];
				WORDLY.appendText(GetRandomEvent(victim) + "\n\n");
				WORDLY.scrollV = WORDLY.maxScrollV;
			}
		}
		private function GetRandomEvent(victim:People):String {
			var randomNumberAgain:int = Math.ceil(Math.random() * 26);
			switch (randomNumberAgain) {
				case 1:
					return victim.THEMANIKILLED + "'s " + GetRandomFamilyMember() + " is waiting for a response to that e-mail...";
					break;
				case 2:
					return victim.THEMANIKILLED + "'s " +GetRandomFamilyMember() + "'s birthday is today.";
					break;
				case 3:
					return victim.THEMANIKILLED + " would have turned " + (victim.age + 1) + " today.";
					break;
				case 4:
					return victim.THEMANIKILLED + "'s " + GetRandomFamilyMember() + " is missing " + victim.genderpronouns[4] + ".";
					break;
				case 5:
					return victim.THEMANIKILLED + " is missed. Why did you have to kill " + victim.genderpronouns[4] + "?";
					break;
				case 6:
					return victim.THEMANIKILLED + " is still dead. There is no respawning in real life.";
					break;
				case 7:
					return victim.THEMANIKILLED + " would be asking you why you killed " + victim.genderpronouns[4] + ", but " + victim.genderpronouns[1] + " can't, because " + victim.genderpronouns[1] + "'s dead.";
					break;
				case 8:
					return victim.THEMANIKILLED + " won't be making it to " + victim.genderpronouns[2] + " best friend's birthday party tonight. Why did you do it?";
					break;
				case 9:
					return victim.THEMANIKILLED + " had a family. " + victim.genderpronouns[0] + " had a job. " + victim.genderpronouns[0] + " had a life. You took it from " + victim.genderpronouns[4] + ".";
					break;
				case 10:
					return victim.THEMANIKILLED + " might be in Heaven. Or Hell. We don't know. But we do know where " + victim.genderpronouns[2] + " body is. In front of you. Dead.";
					break;
				case 11:
					return "Why are you doing this? You aren't getting any points. You won't level up if you kill a certain amount of people. They won't hurt you.";
					break;
				case 12:
					return "You disgust me.";
					break;
				case 13:
					return "Why are you killing all of these innocent people? They may mean nothing to you, but they mean the world to their families.";
					break;
				case 14:
					return "Stop doing this. You're not just hurting the people you're shooting, but their families and friends, too.";
					break;
				case 15:
					return "Have you seen a doctor lately? Your thirst for blood might be a symptom of a serious mental disorder.";
					break;
				case 16:
					return "You know, " + victim.THEMANIKILLED + " liked video games. Before you killed " + victim.genderpronouns[4] + ", that is.";
					break;
				case 17:
					return "Do you ever get tired of this? Of killing people?";
					break;
				case 18:
					return "Stop this.";
					break;
				case 19:
					return "How many innocent people more must you kill?";
					break;
				case 20:
					return "Just because you can't feel their pain doesn't mean they don't feel it.";
					break;
				case 21:
					return "You are horrible.";
					break;
				case 22:
					return "Remember " + victim.THEMANIKILLED + "? You killed " + victim.genderpronouns[4] + ", and you don't even remember.";
					break;
				case 23:
					return "Their blood will stain your hands forever.";
					break;
				case 24:
					return "Did you see " + victim.THEMANIKILLED + "'s face? Did you see " + victim.genderpronouns[4] + " face when you killed " + victim.genderpronouns[4] + "? Did you hear " + victim.genderpronouns[4] + " scream in pain? In fear? In agony? I did.";
					break;
				case 25:
					return victim.THEMANIKILLED + " never got to say goodbye to " + victim.genderpronouns[4] + " friends and family.";
					break;
				case 26:
					return "Feeling good about yourself?";
					break;
			}
			return victim.THEMANIKILLED + " is dead.";
		}
		private function GetRandomFamilyMember():String {
			var randomNumberAgain:int = Math.ceil(Math.random() * 10);
			switch (randomNumberAgain) {
				case 1:
					return "father";
					break;
				case 2:
					return "mother";
					break;
				case 3:
					return "brother";
					break;
				case 4:
					return "sister";
					break;
				case 5:
					return "aunt";
					break;
				case 6:
					return "uncle";
					break;
				case 7:
					return "grandfather";
					break;
				case 8:
					return "grandmother";
					break;
				case 9:
					return "nephew";
					break;
				case 10:
					return "neice";
					break;
			}
			return "friend";
		}
		private function LiveYourLifeYoungManBeforeItEnds(INNOCENT:Array):void {
			if (INNOCENT[1] < 1 || INNOCENT[1] > 4) { INNOCENT[1] = 1; }
			if (INNOCENT[4] <= 0) { INNOCENT[6] = true; }
			if (INNOCENT[6]==true) {
				if (INNOCENT[0].rotation < 90) {
					if (INNOCENT[2] < 6) { INNOCENT[2] = 6 + Math.floor(3 * Math.random()); }
					INNOCENT[4] += 1;
					INNOCENT[4] += 1;
					INNOCENT[0].rotation += INNOCENT[4];
					INNOCENT[0].x = INNOCENT[0].x + Math.sin(INNOCENT[0].rotation * INNOCENT[0].height);
					INNOCENT[0].y = INNOCENT[0].y + Math.cos(INNOCENT[0].rotation * INNOCENT[0].width) + 0.5;
				}
			} else {
				for each(var LEAD:MovieClip in HORROR) {
					if (LEAD.x >= INNOCENT[0].x - INNOCENT[0].width / 2 && LEAD.x <= INNOCENT[0].x + INNOCENT[0].width / 2) {
						if (INNOCENT[6] == false) {
							var hurt:int = Math.round(6 * Math.random());
							switch(hurt) {
								case 1:
									snd1.play();
									break;
								case 2:
									snd2.play();
									break;
								case 3:
									snd3.play();
									break;
								case 4:
									snd4.play();
									break;
								case 5:
									snd5.play();
									break;
							}
							INNOCENT[1] = 2;
							var WOUND:MovieClip = new Wound();
							WOUND.x = INNOCENT[0].x + INNOCENT[0].width / 2 + 0.5;
							WOUND.y = LEAD.y;
							WOUND.gotoAndStop(1);
							stage.addChild(WOUND);
							WOUNDS.push([WOUND, 1, 5, INNOCENT]);
							while (Math.ceil(10 * Math.random()) % 3 != 0) {
								var gibs:MovieClip = new Gib();
								gibs.x = INNOCENT[0].x;
								gibs.y = LEAD.y;
								gibs.gotoAndStop(Math.ceil(10 * Math.random()));
								addChild(gibs);
								GIBS.push([gibs, -5 + 10 * (Math.random()), 0, Math.ceil(3 + 4 * Math.random()), 2 * Math.random()]);
							}
							var stopBull:int = Math.ceil(10 * Math.random());
							if (stopBull % 2 == 0) {
								removeChild(LEAD);
								var indexOfBull:int = HORROR.indexOf(LEAD);
								HORROR.splice(indexOfBull, 1);
							}
						}
					}
				}
				if (INNOCENT[1] == 1) {
					INNOCENT[0].x -= 1;
					INNOCENT[3] -= 1;
					if (INNOCENT[3] <= 0) {
						INNOCENT[3] = 10;
						if (INNOCENT[2] == 1) {
							INNOCENT[2] = 2;
						} else if (INNOCENT[2] == 2) {
							INNOCENT[2] = 3;
						} else if (INNOCENT[2] == 3) {
							INNOCENT[2] = 2;
						}	
					}
				}
				if (INNOCENT[1] == 2) {
					INNOCENT[2] = 5;
					if (INNOCENT[5] == false) {
						INNOCENT[4] -= 50;
						INNOCENT[5] = true;
					} else {
						INNOCENT[7] -= 1;
						if (INNOCENT[7] <= 0) {
							INNOCENT[1] = 3;
							INNOCENT[7] = 100;
						}
					}
				}
				if (INNOCENT[1] == 3) {
					INNOCENT[1] = 1;
					INNOCENT[5] = false;
					INNOCENT[2] = 1;
				}
				if (INNOCENT[4] <= 0) {
					CalculateNewVictim();
					INNOCENT[1] = 4;
					INNOCENT[6] = true;
					INNOCENT[4] = 0;
				}
			}
			INNOCENT[0].gotoAndStop(INNOCENT[2]);
		}
		private function CalculateNewVictim():void {
			var victim:People = new People();
			WORDLY.appendText(victim.THESTORY + "\n\n");
			WORDLY.scrollV = WORDLY.maxScrollV;
			PEOPLE_YOU_HAVE_KILLED.push(victim);
		}
		private function Murder(e:MouseEvent):void {
			if (BFIRED < 8 && RELOAD == false) {
				RELOAD = false;
				BNGSND.play();
				WEAPON.play();
				BFIRED += 1;
				HORROR.push(MakeKiller(KILLER.x + 5.5, KILLER.y - 3.5));
				DEBRIS.push(ThePriceOfBlood(KILLER.x + 5.5, KILLER.y - 5.5));
			} else {
				RELOAD = true;
			}
		}
		private function MakeKiller(nx:Number, ny:Number):MovieClip {
			var BULLET:MovieClip = new Bullet();
			BULLET.x = nx;
			BULLET.y = ny;
			addChild(BULLET);
			return BULLET;
		}
		private function ThePriceOfBlood(nx:Number, ny:Number):Array {
			var EMCLIP:MovieClip = new Clip();
			EMCLIP.x = nx;
			EMCLIP.y = ny;
			addChild(EMCLIP);
			return [EMCLIP, -3 - 2 * Math.random(), 0, Math.ceil(3+4*Math.random()), 2*Math.random()];
		}
		private function InnocentYoungMan():Array {
			var INNOCENT:MovieClip = new Victim();
			INNOCENT.x = 500.5;
			INNOCENT.y = GROUND - INNOCENT.height / 2 - 5 + Math.ceil(10 * Math.random());
			INNOCENT.gotoAndStop(1);
			addChild(INNOCENT);
			return [INNOCENT, 1, 1, 10, 50 + 150 * Math.random(), false, false, 60];
		}
	}
}