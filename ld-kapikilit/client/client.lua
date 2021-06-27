PantCore = nil
local PlayerData = {}
local kapiDurumu = nil
local yakinKapi = "0"
local closestObject = 0
local doorDataLoaded = false

local bolgeler = {
	["pd"] = {coords = vector3(450.0, -978.0, 25.0), r = 100},
	["hastane"] = {coords = vector3(325.66, -576.31, 43.43), r = 100},
	["orta-kasaba"] = {coords = vector3(1846.0, 3687.0, 35.0), r = 100},
	["ust-pd"] = {coords = vector3(-447.0, 6013.0, 31.0), r = 100},
	["ust-ems"] = {coords = vector3(-258.0, 6315.0, 32.0), r = 100},
	["hacker"] = {coords = vector3(-1150.0, -1521.0, 11.0), r = 10},
	["mucevher"] = {coords = vector3(-631.0, -236.0, 38.0), r = 10},
	["hapishane"] = {coords = vector3(1738.0, 2603.0, 45.0), r = 400},
	["nightclup"] = {coords = vector3(377.78, 267.77, 95.14), r = 100},
	["kasaba-mechanic"] = {coords = vector3(1182.33,2645.12, 37.81), r = 50},
	["pdhp"] = {coords = vector3(846.33,-1300.12, 28.81), r = 100},
	["ada"] = {coords = vector3(4436.4912109375, -4450.591796875, 4.6121530532837), r = 50},
	["ranger"] = {coords = vector3(379.24548339844, 790.89141845703, 190.40626525879), r = 50}
}

local kapiListesi = {
	["ranger"] = {
		["1"] = {
			hash = 0x101,
			model = `1715748964`,
			kordinat = vector3(380.2174987793, 792.85894775391, 190.64311218262),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["2"] = {
			hash = 0x102,
			model = `1715748964`,
			kordinat = vector3(378.01858520508, 792.85894775391, 190.64311218262),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["39"] = {
			hash = 0x139,
			model = `-868087669`,
			kordinat = vector3(381.25778198242, 795.55505371094, 187.82640075684),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["40"] = {
			hash = 0x140,
			model = `-1018783587`,
			kordinat = vector3(387.60949707031, 792.83935546875, 187.82640075684),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["41"] = {
			hash = 0x141,
			model = `-1018783587`,
			kordinat = vector3(388.56500244141, 799.48120117188, 187.82640075684),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
	},
	["pd"] = {
		-- PD Otopark Tarafı Çift Kapı
		["3"] = {
			hash = 0x103,
			model = -1547307588,
			kordinat = vector3(440.73919677734, -998.74621582031, 30.81530380249),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["4"] = {
			hash = 0x104,
			model = -1547307588,
			kordinat = vector3(443.06176757812, -998.74621582031, 30.81530380249),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		-- PD Press Room
		["5"] = {
			hash = 0x105,
			model = -288803980,
			kordinat = vector3(438.19708251953, -996.31665039062, 30.823192596436),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["6"] = {
			hash = 0x106,
			model = -288803980,
			kordinat = vector3(438.19708251953, -993.91125488281, 30.823192596436),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		-- PD Lobi sağ
		["7"] = {
			hash = 0x107,
			model = -96679321,
			kordinat = vector3(440.52008056641, -986.23345947266, 30.823192596436),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		-- PD Lobi Sol
		["8"] = {
			hash = 0x108,
			model = -1406685646,
			kordinat = vector3(440.52008056641, -977.60107421875, 30.823192596436),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		--PD Arkadan Giriş
		["9"] = {
			hash = 0x109,
			model = -1547307588,
			kordinat = vector3(455.88616943359, -972.25427246094, 30.815307617188),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["10"] = {
			hash = 0x110,
			model = -1547307588,
			kordinat = vector3(458.20874023438, -972.25427246094, 30.815307617188),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		-- Boss Ofis
		["11"] = {
			hash = 0x111,
			model = -96679321,
			kordinat = vector3(458.65432739258, -990.64978027344, 30.823192596436),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		-- Çatı Girişi
		["12"] = {
			hash = 0x112,
			model = -692649124,
			kordinat = vector3(464.30856323242, -984.52844238281, 43.771240234375),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		-- Otopark Girişi 1
		["13"] = {
			hash = 0x113,
			model = 1830360419,
			kordinat = vector3(464.15655517578, -997.50927734375, 26.370704650879),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		--PD Otopark tarfı çift 1
		["14"] = {
			hash = 0x114,
			model = -288803980,
			kordinat = vector3(469.92736816406, -1000.5437011719, 26.40548324585),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["15"] = {
			hash = 0x115,
			model = -288803980,
			kordinat = vector3(467.52221679688, -1000.5437011719, 26.40548324585),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		--PD Otopark tarfı çift 2
		["16"] = {
			hash = 0x116,
			model = -1406685646,
			kordinat = vector3(471.37530517578, -985.03192138672, 26.40548324585),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["17"] = {
			hash = 0x117,
			model = -96679321,
			kordinat = vector3(471.37530517578, -987.43737792969, 26.40548324585),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		--PD Alt Kat Arka Giriş
		["18"] = {
			hash = 0x118,
			model = -692649124,
			kordinat = vector3(469.7743, -1014.4060058594, 26.483816146851),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["19"] = {
			hash = 0x119,
			model = -692649124,
			kordinat = vector3(467.36862182617, -1014.4060058594, 26.483816146851),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		--PD Alt Kat Arka Önü
		["20"] = {
			hash = 0x120,
			model = 149284793,
			kordinat = vector3(471.36785888672, -1007.7933959961, 26.40548324585),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["21"] = {
			hash = 0x121,
			model = 149284793,
			kordinat = vector3(471.37582397461, -1010.1978759766, 26.40548324585),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		-- Otopark Girişi 2
		["22"] = {
			hash = 0x122,
			model = 1830360419,
			kordinat = vector3(464.15905761719, -974.66558837891, 26.370704650879),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		-- Evidance
		["23"] = {
			hash = 0x123,
			model = -692649124,
			kordinat = vector3(475.83233642578, -990.48394775391, 26.40548324585),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		-- İdentification
		["24"] = {
			hash = 0x124,
			model = 149284793,
			kordinat = vector3(478.28915405273, -997.91009521484, 26.40548324585),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		-- Sorgu 1 Sağ
		["25"] = {
			hash = 0x125,
			model = -1406685646,
			kordinat = vector3(482.67013549805, -987.57916259766, 26.40548324585),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		-- Sorgu 2 Sağ
		["26"] = {
			hash = 0x126,
			model = -1406685646,
			kordinat = vector3(482.67025756836, -995.728515625, 26.40548324585),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		-- Lineup
		["27"] = {
			hash = 0x127,
			model = -288803980,
			kordinat = vector3(479.05996704102, -1003.1729736328, 26.406503677368),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		-- cells
		["28"] = {
			hash = 0x128,
			model = -53345114,
			kordinat = vector3(481.00836181641, -1004.117980957, 26.480054855347),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["29"] = {
			hash = 0x129,
			model = -53345114,
			kordinat = vector3(484.17642211914, -1007.734375, 26.480054855347),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["30"] = {
			hash = 0x130,
			model = -53345114,
			kordinat = vector3(486.91311645508, -1012.188659668, 26.480054855347),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["31"] = {
			hash = 0x131,
			model = -53345114,
			kordinat = vector3(483.91271972656, -1012.188659668, 26.480054855347),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["32"] = {
			hash = 0x132,
			model = -53345114,
			kordinat = vector3(480.9128112793, -1012.188659668, 26.480054855347),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["33"] = {
			hash = 0x133,
			model = -53345114,
			kordinat = vector3(476.61569213867, -1008.8754272461, 26.480054855347),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["34"] = {
			hash = 0x134,
			model = -53345114,
			kordinat = vector3(477.91259765625, -1012.188659668, 26.480054855347),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		--processing
		["35"] = {
			hash = 0x135,
			model = -288803980,
			kordinat = vector3(475.95385742188, -1006.9378051758, 26.406385421753),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		--mugshot
		["36"] = {
			hash = 0x136,
			model = -1406685646,
			kordinat = vector3(475.95385742188, -1010.8193359375, 26.406385421753),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		--PD Arka Dış Sürgülü
		["37"] = {
			hash = 0x137,
			model = -1603817716,
			kordinat = vector3(488.8948059082, -1017.2099609375, 27.145839691162),
			kilitmesafe = 8.0,
			otokilit = true,
			tip = "sürgülü",
			meslek = {'police', 'ambulance'}
		},
	},
	["hacker"] = {
		["58"] = {
			hash = 0x158,
			model = `v_ilev_trev_doorfront`,
			kordinat = vector3(-1150.28, -1521.46, 11.4),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'hacker'}
		},
	},
	["mucevher"] = {
		["95"] = {
			hash = 0x195,
			model = 1425919976,
			kordinat = vector3(-631.96, -236.33, 38.21),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["96"] = { 
			hash = 0x196,
			model = 9467943,
			kordinat = vector3(-630.43, -238.44, 38.21),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
	},
	["hapishane"] = {
		["106"] = { -- Hapishane Sürgülü Arka
			hash = 0x206,
			model = 741314661,
			kordinat = vector3(1818.54, 2604.81, 44.61),
			kilitmesafe = 8.0,
			otokilit = true,
			tip = "surgulu",
			meslek = {'police', 'ambulance'}
		},
		["107"] = { -- Hapishane Sürgülü Ön 
			hash = 0x207,
			model = 741314661,
			kordinat = vector3(1845.04, 2604.61, 44.61),
			kilitmesafe = 8.0,
			otokilit = true,
			tip = "surgulu",
			meslek = {'police', 'ambulance'}
		},
		["109"] = {
			hash = 0x209,
			model = -1612152164,
			kordinat = vector3(1780.23, 2588.54, 44.78),
			kilitmesafe = 1.8,
			otokilit = true,
			tip = "surgulu",
			meslek = {'police', 'ambulance'}
		},
		["110"] = {
			hash = 0x210,
			model = -1612152164,
			kordinat = vector3(1782.59, 2590.89, 44.78),
			kilitmesafe = 1.8,
			otokilit = true,
			tip = "surgulu",
			meslek = {'police', 'ambulance'}
		},
		["111"] = {
			hash = 0x211,
			model = -1156020871,
			kordinat = vector3(1797.76, 2596.56, 46.39),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["112"] = {
			hash = 0x212,
			model = -1156020871,
			kordinat = vector3(1798.09, 2591.69, 46.42),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["113"] = {
			hash = 0x213,
			model = -1033001619,
			kordinat = vector3(1819.12, 2594.91, 46.05),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["114"] = {
			hash = 0x214,
			model = -1612152164,
			kordinat = vector3(1828.85, 2591.67, 44.95),
			kilitmesafe = 1.8,
			otokilit = true,
			tip = "surgulu",
			meslek = {'police', 'ambulance'}
		},
		["115"] = {
			hash = 0x215,
			model = -1612152164,
			kordinat = vector3(1831.51, 2594.45, 44.95),
			kilitmesafe = 1.8,
			otokilit = true,
			tip = "surgulu",
			meslek = {'police', 'ambulance'}
		},
		["116"] = {
			hash = 0x216,
			model = -1033001619,
			kordinat = vector3(1841.59, 2594.27, 46.05),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["117"] = {
			hash = 0x217,
			model = -1612152164,
			kordinat = vector3(1841.59, 2594.27, 46.05),
			kilitmesafe = 1.8,
			otokilit = true,
			tip = "surgulu",
			meslek = {'police', 'ambulance'}
		},
		["118"] = {
			hash = 0x218,
			model = -1612152164,
			kordinat = vector3(1839.60, 2588.30, 44.96),
			kilitmesafe = 1.8,
			otokilit = true,
			tip = "surgulu",
			meslek = {'police', 'ambulance'}
		},
		["119"] = {
			hash = 0x219,
			model = -1612152164,
			kordinat = vector3(1836.56, 2594.45, 44.95),
			kilitmesafe = 1.8,
			otokilit = true,
			tip = "surgulu",
			meslek = {'police', 'ambulance'}
		},
		["120"] = {
			hash = 0x220,
			model = -1033001619,
			kordinat = vector3(1786.37, 2600.22, 46.00),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["121"] = {
			hash = 0x221,
			model = -1033001619,
			kordinat = vector3(1782.71, 2598.99, 45.87),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["122"] = {
			hash = 0x222,
			model = -1033001619,
			kordinat = vector3(1776.56, 2588.41, 49.86),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
	},
	["hastane"] = {
		["123"] = {
			hash = 0x223,
			model = 854291622,
			kordinat = vector3(307.12, -569.57, 43.43),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance', 'police'}
		},
		["124"] = {
			hash = 0x224,
			model = -434783486,
			kordinat = vector3(312.01, -571.34, 43.43),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["125"] = {
			hash = 0x225,
			model = -1700911976,
			kordinat = vector3(314.42, -572.22, 43.43),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance', 'police'}
		},
	
		["126"] = {
			hash = 0x226,
			model = -434783486,
			kordinat = vector3(317.84, -573.47, 43.43),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["127"] = {
			hash = 0x227,
			model = -1700911976,
			kordinat = vector3(320.26, -574.35, 43.43),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance', 'police'}
		},
	
		["128"] = {
			hash = 0x228,
			model = -434783486,
			kordinat = vector3(323.24, -575.43, 43.43),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["129"] = {
			hash = 0x229,
			model = -1700911976,
			kordinat = vector3(325.66, -576.31, 43.43),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance', 'police'}
		},
		["130"] = {
			hash = 0x230,
			model = 854291622,
			kordinat = vector3(340.78, -581.82, 43.43),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance', 'police'}
		},
		["131"] = {
			hash = 0x231,
			model = 854291622,
			kordinat = vector3(339.0, -586.70, 43.43),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance', 'police'}
		},
		["132"] = {
			hash = 0x232,
			model = 854291622,
			kordinat = vector3(313.48, -595.46, 43.43),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance'}
		},
	},
	["ust-pd"] = {
		["136"] = {
			hash = 0x236,
			model = -1011692606,
			kordinat = vector3(-437.61, 5992.82, 31.94),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["137"] = {
			hash = 0x237,
			model = 631614199,
			kordinat = vector3(-432.18, 5992.12, 31.87),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["138"] = {
			hash = 0x238,
			model = 631614199,
			kordinat = vector3(-428.06, 5996.67, 31.87),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["139"] = {
			hash = 0x239,
			model = 631614199,
			kordinat = vector3(-431.19, 5999.74, 31.87),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["140"] = {
			hash = 0x240,
			model = -952356348,
			kordinat = vector3(-441.05, 6005.0, 31.86),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["141"] = {
			hash = 0x241,
			model = -952356348,
			kordinat = vector3(-439.14, 6009.38, 31.72),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["142"] = {
			hash = 0x242,
			model = -519068795,
			kordinat = vector3(-454.54, 6011.26, 31.87),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["143"] = {
			hash = 0x243,
			model = -2023754432,
			kordinat = vector3(-449.79, 6015.79, 31.87),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
	},
	["ust-ems"] = {
		["151"] = {
			hash = 0x251,
			model = -770740285,
			kordinat = vector3(-256.52, 6314.24, 32.47),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance'}
		},
		["152"] = {
			hash = 0x252,
			model = 1415151278,
			kordinat = vector3(-250.79, 6319.95, 32.47),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["153"] = {
			hash = 0x253,
			model = 1415151278,
			kordinat = vector3(-252.61, 6318.13, 32.57),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance', 'police', 'ambulance'}
		},
	},
	["orta-kasaba"] = {
		-- BB Hastane
		["170"] = {
			hash = 0x270,
			model = 580361003,
			kordinat = vector3(1838.80, 3678.69, 34.42),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["171"] = {
			hash = 0x271,
			model = 1415151278,
			kordinat = vector3(1840.09, 3676.46, 34.42),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance'}
		},
		["172"] = {
			hash = 0x272,
			model = -770740285,
			kordinat = vector3(1840.71, 3681.75, 34.30),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance'}
		},
		["173"] = {
			hash = 0x273,
			model = -770740285,
			kordinat = vector3(1826.89, 3676.40, 34.30),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance'}
		},
		["174"] = {
			hash = 0x274,
			model = -770740285,
			kordinat = vector3(1835.51, 3684.81, 34.30),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance'}
		},
		["175"] = {
			hash = 0x275,
			model = 580361003,
			kordinat = vector3(1831.82, 3691.0, 34.42),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["176"] = {
			hash = 0x276,
			model = 1415151278,
			kordinat = vector3(1833.11, 3688.77, 34.42),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance', 'police'}
		},
		["177"] = {
			hash = 0x277,
			model = 1415151278,
			kordinat = vector3(1828.59, 3686.16, 34.42),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["178"] = {
			hash = 0x278,
			model = 580361003,
			kordinat = vector3(1827.30, 3688.39, 34.42),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'ambulance', 'police'}
		},
	},
	["nightclup"] = {
		["300"] = {
			hash = 0x400,
			model = -1555108147,
			kordinat = vector3(377.78, 267.77, 95.14),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'nightclub'}
		},
		["301"] = {
			hash = 0x401,
			model = 1695461688,
			kordinat = vector3(380.16, 266.63, 91.36),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'nightclub'}
		},
	},
	["kasaba-mechanic"] = {
		["302"] = {
			hash = 0x402,
			model = -822900180,
			kordinat = vector3(1182.33,2645.12, 37.81),
			kilitmesafe = 1.8,
			otokilit = true,
			tip = "surgulu",
			meslek = {'mechanic'}
		},
		["303"] = {
			hash = 0x403,
			model = 1544229216,
			kordinat = vector3(1182.75,2641.91, 37.81),
			kilitmesafe = 1.8,
			otokilit = true,
			tip = "surgulu",
			meslek = {'mechanic'}
		},
	},
	["pdhp"] = {
		["304"] = {
			hash = 0x404,
			model = -502195954,
			kordinat = vector3(848.71917724609, -1284.9019775391, 28.297201156616), 
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["305"] = {
			hash = 0x405,
			model = -551608542,
			kordinat =  vector3(840.64971923828, -1286.2633056641, 28.383264541626),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["306"] = {
			hash = 0x406,
			model = 1734343003,
			kordinat =  vector3(833.67828369141, -1286.2784423828, 28.38140296936), 
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["307"] = {
			hash = 0x407,
			model = -553047264,
			kordinat =  vector3(845.60583496094, -1301.4105224609, 28.383079528809), 
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["308"] = {
			hash = 0x408,
			model = -340230128,
			kordinat = vector3(845.84820556641, -1308.7668457031, 28.383003234863), 
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["309"] = {
			hash = 0x409,
			model = -2051651622,
			kordinat = vector3(853.86187744141, -1307.5090332031, 28.386138916016), 
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["310"] = {
			hash = 0x410,
			model = -703073730,
			kordinat = vector3(846.45928955078, -1314.2349853516, 26.810171127319),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["311"] = {
			hash = 0x411,
			model = -770740285,
			kordinat = vector3(848.80828857422, -1306.8149414063, 24.337409973145), 
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["312"] = {
			hash = 0x412,
			model = -770740285,
			kordinat = vector3(846.50756835938, -1306.8153076172, 24.337409973145), 
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["313"] = {
			hash = 0x413,
			model = 1335311341,
			kordinat = vector3(851.51977539063, -1303.8876953125, 24.470909118652), 
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["314"] = {
			hash = 0x414,
			model = -658747851,
			kordinat = vector3(851.51983642578, -1306.4903564453, 24.470907211304), 
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["315"] = {
			hash = 0x415,
			model = -340230128,
			kordinat = vector3(844.54937744141, -1298.8759765625, 24.469999313354), 
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["316"] = {
			hash = 0x416,
			model = -1033001619,
			kordinat = vector3(839.97546386719, -1301.3809814453, 24.469999313354),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["317"] = {
			hash = 0x417,
			model = -321609811,
			kordinat = vector3(840.25775146484, -1305.6469726563, 23.317279815674),
			kilitmesafe = 1.8,
			otokilit = true,
			tip = "surgulu",
			meslek = {'police', 'ambulance'}
		},
		["318"] = {
			hash = 0x418,
			model = -321609811,
			kordinat = vector3(838.62194824219, -1305.650390625, 23.317279815674),
			kilitmesafe = 1.8,
			otokilit = true,
			tip = "surgulu",
			meslek = {'police', 'ambulance'}
		},
		["319"] = {
			hash = 0x419,
			model = -321609811,
			kordinat = vector3(834.40948486328, -1305.7039794922, 23.320789337158),
			kilitmesafe = 1.8,
			otokilit = true,
			tip = "surgulu",
			meslek = {'police', 'ambulance'}
		},
		["320"] = {
			hash = 0x420,
			model = -2051651622,
			kordinat = vector3(839.81103515625, -1287.4006347656, 24.469480514526),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
		["321"] = {
			hash = 0x421,
			model = -2051651622,
			kordinat = vector3(837.20812988281, -1287.4010009766, 24.469480514526),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["322"] = {
			hash = 0x422,
			model = -1033001619,
			kordinat = vector3(837.85650634766, -1290.6068115234, 24.469999313354),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["333"] = {
			hash = 0x423,
			model = -553047264,
			kordinat = vector3(839.61444091797, -1290.6066894531, 24.46950340271),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["334"] = {
			hash = 0x424,
			model = -1920147247,
			kordinat = vector3(829.70324707031, -1310.0792236328, 28.383958816528),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["335"] = {
			hash = 0x425,
			model = -2051651622,
			kordinat = vector3(853.17706298828, -1306.8865966797, 31.814998626709),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
	},
	["ada"] = {
		["336"] = {
			hash = 0x426,
			model = 1526539404,
			kordinat = vector3(4436.4912109375, -4450.591796875, 4.6121530532837),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["337"] = {
			hash = 0x427,
			model = 1413187371,
			kordinat = vector3(4432.8427734375, -4451.9013671875, 7.4907579421997),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["338"] = {
			hash = 0x428,
			model = 1526539404,
			kordinat = vector3(4442.8583984375, -4443.3349609375, 7.5974321365356),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {'police', 'ambulance'}
		},
		["339"] = {
			hash = 0x429,
			model = 227019171,
			kordinat = vector3(4444.2275390625, -4447.0966796875, 7.5974321365356),
			kilitmesafe = 1.8,
			otokilit = true,
			meslek = {}
		},
	},

	["evler"] = {
		-- Pinkcage Motel
		["1000"] = {
			hash = 0x1000,
			model = -1156992775,
			kordinat = vector3(306.84893798828, -213.67449951172, 54.37154006958),
			otokilit = true,
		},
		["1001"] = {
			hash = 0x1001,
			model = -1156992775,
			kordinat = vector3(310.64282226562, -203.79110717773, 54.371589660645),
			otokilit = true,
		},
		["1002"] = {
			hash = 0x1002,
			model = -1156992775,
			kordinat = vector3(315.39260864258, -194.17465209961, 54.371391296387),
			otokilit = true,
		},
		["1003"] = {
			hash = 0x1003,
			model = -1156992775,
			kordinat = vector3(315.25088500977, -220.26713562012, 58.170391082764),
			otokilit = true,
		},
		["1004"] = {
			hash = 0x1004,
			model = -1156992775,
			kordinat = vector3(306.84893798828, -213.67449951172, 58.169151306152),
			otokilit = true,
		},
		["1005"] = {
			hash = 0x1005,
			model = -1156992775,
			kordinat = vector3(310.64312744141, -203.79040527344, 58.169502258301),
			otokilit = true,
		},
		["1006"] = {
			hash = 0x1006,
			model = -1156992775,
			kordinat = vector3(315.39260864258, -194.17465209961, 58.169731140137),
			otokilit = true,
		},
		["1007"] = {
			hash = 0x1007,
			model = -1156992775,
			kordinat = vector3(347.39486694336, -199.3318939209, 54.3720703125),
			otokilit = true,
		},
		["1008"] = {
			hash = 0x1008,
			model = -1156992775,
			kordinat = vector3(343.60018920898, -209.21490478516, 54.371631622314),
			otokilit = true,
		},
		["1009"] = {
			hash = 0x1009,
			model = -1156992775,
			kordinat = vector3(339.80627441406, -219.0977935791, 54.372089385986),
			otokilit = true,
		},
		["1010"] = {
			hash = 0x1010,
			model = -1156992775,
			kordinat = vector3(335.33987426758, -227.98184204102, 58.169570922852),
			otokilit = true,
		},
		["1011"] = {
			hash = 0x1011,
			model = -1156992775,
			kordinat = vector3(339.80627441406, -219.0977935791, 58.168529510498),
			otokilit = true,
		},
		["1012"] = {
			hash = 0x1012,
			model = -1156992775,
			kordinat = vector3(343.60018920898, -209.21490478516, 58.168529510498),
			otokilit = true,
		},
		["1013"] = {
			hash = 0x1013,
			model = -1156992775,
			kordinat = vector3(347.39486694336, -199.3318939209, 58.168529510498),
			otokilit = true,
		},
         -- Marina Motel
		["1014"] = {
			hash = 0x1014,
			model = 1398355146,
			kordinat = vector3(-867.83819580078, -1286.615234375, 13.370532989502),
			otokilit = true,
		},
		["1015"] = {
			hash = 0x1015,
			model = 1398355146,
			kordinat = vector3(-901.66760253906, -1298.9172363281, 13.370532989502),
			otokilit = true,
		},
		["1016"] = {
			hash = 0x1016,
			model = 1398355146,
			kordinat = vector3(-935.47888183594, -1311.2132568359, 13.370532989502),
			otokilit = true,
		},
		["1017"] = {
			hash = 0x1017,
			model = 1398355146,
			kordinat = vector3(-867.80700683594, -1286.7216796875, 9.8934030532837),
			otokilit = true,
		},
		["1018"] = {
			hash = 0x1018,
			model = 1398355146,
			kordinat = vector3(-901.63641357422, -1299.0236816406, 9.8934030532837),
			otokilit = true,
		},
		["1019"] = {
			hash = 0x1019,
			model = 1398355146,
			kordinat = vector3(-935.44769287109, -1311.3197021484, 9.8934030532837),
			otokilit = true,
		},
		["1020"] = {
			hash = 0x1020,
			model = 1398355146,
			kordinat = vector3(-867.80004882812, -1286.7265625, 6.3374929428101),
			otokilit = true,
		},
		["1021"] = {
			hash = 0x1021,
			model = 1398355146,
			kordinat = vector3(-901.62945556641, -1299.0285644531, 6.3374929428101),
			otokilit = true,
		},
		["1022"] = {
			hash = 0x1022,
			model = 1398355146,
			kordinat = vector3(-935.44073486328, -1311.3245849609, 6.3374929428101),
			otokilit = true,
		},
		
		-- Vespucci Beach House
		["1023"] = {
			hash = 0x1023,
			model = -1128607325,
			kordinat = vector3(-1096.8572998047, -1673.3681640625, 8.6150979995728),
			otokilit = true,
		},
		
		--Vespucci Beach House 2
		["1024"] = {
			hash = 0x1024,
			model = 1980513646,
			kordinat = vector3(-1986.4057617188, -503.32620239258, 12.330739974976),
			otokilit = true,
		},
		["1025"] = {
			hash = 0x1025,
			model = 308207762,
			kordinat = vector3(-1986.9691162109, -511.65283203125, 12.329000473022),
			otokilit = true,
		},
		
		-- Armadillo St. House
		["1026"] = {
			hash = 0x1026,
			model = -228773386,
			kordinat = vector3(1294.4572753906, -1739.4392089844, 54.354209899902),
			otokilit = true,
		},
		["1027"] = {
			hash = 0x1027,
			model = -228773386,
			kordinat = vector3(1300.9367675781, -1752.689453125, 54.361228942871),
			otokilit = true,
		},
		
		-- Didion St.
		["1028"] = {
			hash = 0x1028,
			model = -88942360,
			kordinat = vector3(19.09104347229, 343.40258789062, 115.70169067383),
			otokilit = true,
		},
		
		-- Perrera Beach Motel
		["1029"] = {
			hash = 0x1029,
			model = -2123441472,
			kordinat = vector3(-1494.44, -668.33, 29.28),
			otokilit = true,
		},
		["1030"] = {
			hash = 0x1030,
			model = -2123441472,
			kordinat = vector3(-1498.82, -664.72, 29.28),
			otokilit = true,
		},
		["1031"] = {
			hash = 0x1031,
			model = -2123441472,
			kordinat = vector3(-1495.20, -660.93, 29.28),
			otokilit = true,
		},
		["1032"] = {
			hash = 0x1032,
			model = -2123441472,
			kordinat = vector3(-1490.61, -657.57, 29.28),
			otokilit = true,
		},
		["1033"] = {
			hash = 0x1033,
			model = -2123441472,
			kordinat = vector3(-1486.60, -654.71, 29.84),
			otokilit = true,
		},
		["1034"] = {
			hash = 0x1034,
			model = -2123441472,
			kordinat = vector3(-1482.00, -651.38, 29.84),
			otokilit = true,
		},
		["1035"] = {
			hash = 0x1035,
			model = -2123441472,
			kordinat = vector3(-1478.05, -648.49, 29.84),
			otokilit = true,
		},
		["1036"] = {
			hash = 0x1036,
			model = -2123441472,
			kordinat = vector3(-1473.52, -645.19, 29.84),
			otokilit = true,
		},
		["1037"] = {
			hash = 0x1037,
			model = -2123441472,
			kordinat = vector3(-1469.50, -642.27, 29.84),
			otokilit = true,
		},
		["1038"] = {
			hash = 0x1038,
			model = -2123441472,
			kordinat = vector3(-1464.90, -638.92, 29.84),
			otokilit = true,
		},
		["1039"] = {
			hash = 0x1039,
			model = -2123441472,
			kordinat = vector3(-1460.57, -641.06, 29.83),
			otokilit = true,
		},
		["1040"] = {
			hash = 0x1040,
			model = -2123441472,
			kordinat = vector3(-1451.67, -653.36, 29.84),
			otokilit = true,
		},
		["1041"] = {
			hash = 0x1041,
			model = -2123441472,
			kordinat = vector3(-1454.55, -656.63, 29.84),
			otokilit = true,
		},
		["1042"] = {
			hash = 0x1042,
			model = -2123441472,
			kordinat = vector3(-1459.14, -659.97, 29.84),
			otokilit = true,
		},
		["1043"] = {
			hash = 0x1043,
			model = -2123441472,
			kordinat = vector3(-1463.11, -662.84, 29.83),
			otokilit = true,
		},
		["1044"] = {
			hash = 0x1044,
			model = -2123441472,
			kordinat = vector3(-1467.72, -666.16, 29.85),
			otokilit = true,
		},
		["1045"] = {
			hash = 0x1045,
			model = -2123441472,
			kordinat = vector3(-1471.53, -669.02, 29.85),
			otokilit = true,
		},
		["1046"] = {
			hash = 0x1046,
			model = -2123441472,
			kordinat = vector3(-1490.66, -671.45, 33.64),
			otokilit = true,
		},
		["1047"] = {
			hash = 0x1047,
			model = -2123441472,
			kordinat = vector3(-1494.45, -668.33, 33.64),
			otokilit = true,
		},
		["1048"] = {
			hash = 0x1048,
			model = -2123441472,
			kordinat = vector3(-1498.82, -664.72, 33.64),
			otokilit = true,
		},
		["1049"] = {
			hash = 0x1049,
			model = -2123441472,
			kordinat = vector3(-1495.20, -660.93, 33.64),
			otokilit = true,
		},
		["1050"] = {
			hash = 0x1050,
			model = -2123441472,
			kordinat = vector3(-1490.61, -657.57, 33.64),
			otokilit = true,
		},
		["1051"] = {
			hash = 0x1051,
			model = -2123441472,
			kordinat = vector3(-1486.60, -654.71, 33.64),
			otokilit = true,
		},
		["1052"] = {
			hash = 0x1052,
			model = -2123441472,
			kordinat = vector3(-1482.00, -651.38, 33.64),
			otokilit = true,
		},
		["1053"] = {
			hash = 0x1053,
			model = -2123441472,
			kordinat = vector3(-1478.05, -648.49, 33.64),
			otokilit = true,
		},
		["1054"] = {
			hash = 0x1054,
			model = -2123441472,
			kordinat = vector3(-1473.52, -645.19, 33.64),
			otokilit = true,
		},
		["1055"] = {
			hash = 0x1055,
			model = -2123441472,
			kordinat = vector3(-1469.50, -642.27, 33.64),
			otokilit = true,
		},
		["1056"] = {
			hash = 0x1056,
			model = -2123441472,
			kordinat = vector3(-1464.90, -638.92, 33.64),
			otokilit = true,
		},
		["1057"] = {
			hash = 0x1057,
			model = -2123441472,
			kordinat = vector3(-1460.57, -641.06, 33.64),
			otokilit = true,
		},
		["1058"] = {
			hash = 0x1058,
			model = -2123441472,
			kordinat = vector3(-1455.01, -648.76, 33.63),
			otokilit = true,
		},
		["1059"] = {
			hash = 0x1059,
			model = -2123441472,
			kordinat = vector3(-1451.67, -653.36, 33.63),
			otokilit = true,
		},
		["1060"] = {
			hash = 0x1060,
			model = -2123441472,
			kordinat = vector3(-1454.55, -656.63, 33.63),
			otokilit = true,
		},
		["1061"] = {
			hash = 0x1061,
			model = -2123441472,
			kordinat = vector3(-1459.14, -659.97, 33.63),
			otokilit = true,
		},
		["1062"] = {
			hash = 0x1062,
			model = -2123441472,
			kordinat = vector3(-1463.11, -662.84, 33.63),
			otokilit = true,
		},
		["1063"] = {
			hash = 0x1063,
			model = -2123441472,
			kordinat = vector3(-1467.72, -666.16, 33.63),
			otokilit = true,
		},
		["1064"] = {
			hash = 0x1064,
			model = -2123441472,
			kordinat = vector3(-1471.53, -669.02, 33.63),
			otokilit = true,
		},
		["1065"] = {
			hash = 0x1065,
			model = -2123441472,
			kordinat = vector3(-1476.28, -672.39, 33.63),
			otokilit = true,
		},
	
		-- Tree Tops Motel
		["1066"] = {
			hash = 0x1066,
			model = -580006562,
			kordinat = vector3(-1339.7490234375, -941.02581787109, 12.504458427429),
			otokilit = true,
		},
		["1067"] = {
			hash = 0x1067,
			model = -580006562,
			kordinat = vector3(-1338.6185302734, -942.43756103516, 12.481762886047),
			otokilit = true,
		},
		["1068"] = {
			hash = 0x1068,
			model = -580006562,
			kordinat = vector3(-1331.5150146484, -939.84204101562, 12.460681915283),
			otokilit = true,
		},
		["1069"] = {
			hash = 0x1069,
			model = -580006562,
			kordinat = vector3(-1329.6798095703, -939.18408203125, 12.483140945435),
			otokilit = true,
		},
		["1070"] = {
			hash = 0x1070,
			model = -580006562,
			kordinat = vector3(-1311.2541503906, -932.46771240234, 13.477070808411),
			otokilit = true,
		},
		["1071"] = {
			hash = 0x1071,
			model = -580006562,
			kordinat = vector3(-1318.3142089844, -935.04736328125, 13.473349571228),
			otokilit = true,
		},
		["1072"] = {
			hash = 0x1072,
			model = -580006562,
			kordinat = vector3(-1320.1800537109, -935.71649169922, 13.480257034302),
			otokilit = true,
		},
		["1073"] = {
			hash = 0x1073,
			model = -580006562,
			kordinat = vector3(-1311.2541503906, -932.46771240234, 16.480815887451),
			otokilit = true,
		},
		["1074"] = {
			hash = 0x1074,
			model = -580006562,
			kordinat = vector3(-1318.3142089844, -935.04736328125, 16.48042678833),
			otokilit = true,
		},
		["1075"] = {
			hash = 0x1075,
			model = -580006562,
			kordinat = vector3(-1320.1716308594, -935.71337890625, 16.480815887451),
			otokilit = true,
		},
		["1076"] = {
			hash = 0x1076,
			model = -580006562,
			kordinat = vector3(-1329.6314697266, -939.16650390625, 15.477767944336),
			otokilit = true,
		},
		["1077"] = {
			hash = 0x1077,
			model = -580006562,
			kordinat = vector3(-1331.5072021484, -939.83917236328, 15.479879379272),
			otokilit = true,
		},
		["1078"] = {
			hash = 0x1078,
			model = -580006562,
			kordinat = vector3(-1338.6185302734, -942.43756103516, 15.480977058411),
			otokilit = true,
		},
		
		-- Didion Drv. 317
		["1079"] = {
			hash = 0x1079,
			model = 561230220,
			kordinat = vector3(-349.11572265625, 515.93957519531, 120.90333557129),
			otokilit = true,
		},
		["1080"] = {
			hash = 0x1080,
			model = -1119592433,
			kordinat = vector3(-350.06723022461, 519.10748291016, 120.88333129883),
			otokilit = true,
		},
		["1081"] = {
			hash = 0x1081,
			model = 2049607469,
			kordinat = vector3(-335.75433349609, 526.38488769531, 120.43237304688),
			otokilit = true,
		},
		
		-- michael ev
		["1082"] = {
			hash = 0x1082,
			model = 159994461,
			kordinat = vector3(-816.71600341797, 179.09796142578, 72.827377319336),
			otokilit = true,
		},
		["1083"] = {
			hash = 0x1083,
			model = -1563640173,
			kordinat = vector3(-806.28173828125, 186.02461242676, 72.624046325684),
			otokilit = true,
		},
		["1084"] = {
			hash = 0x1084,
			model = -1454760130,
			kordinat = vector3(-796.56567382812, 177.22137451172, 73.040451049805),
			otokilit = true,
		},
		["1085"] = {
			hash = 0x1085,
			model = -1454760130,
			kordinat = vector3(-793.39428710938, 180.50746154785, 73.040451049805),
			otokilit = true,
		},
		-- Forum Drive No 17
		["1086"] = {
			hash = 0x1086,
			model = 520341586,
			kordinat = vector3(-14.868921279907, -1441.1821289062, 31.193225860596),
			otokilit = true,
		},
		-- Lester Ev
		["1087"] = {
			hash = 0x1087,
			model = 1145337974,
			kordinat = vector3(1273.8155517578, -1720.6968994141, 54.92142868042),
			otokilit = true,
		},
		
		-- Route 68 Harmony Mootel
		["1088"] = {
			hash = 0x1088,
			model = -384231627,
			kordinat = vector3(397.68908691406, 2636.580078125, 45.12279510498),
			otokilit = true,
		},
		["1089"] = {
			hash = 0x1089,
			model = -384231627,
			kordinat = vector3(392.34051513672, 2633.4291992188, 45.121307373047),
			otokilit = true,
		},
		["1090"] = {
			hash = 0x1090,
			model = -384231627,
			kordinat = vector3(384.96069335938, 2631.8100585938, 45.120754241943),
			otokilit = true,
		},
		["1091"] = {
			hash = 0x1091,
			model = -384231627,
			kordinat = vector3(379.61212158203, 2628.6591796875, 45.11926651001),
			otokilit = true,
		},
		["1092"] = {
			hash = 0x1092,
			model = -384231627,
			kordinat = vector3(372.23239135742, 2627.041015625, 45.12279510498),
			otokilit = true,
		},
		["1093"] = {
			hash = 0x1093,
			model = -384231627,
			kordinat = vector3(366.88381958008, 2623.8901367188, 45.121307373047),
			otokilit = true,
		},
		["1094"] = {
			hash = 0x1094,
			model = -384231627,
			kordinat = vector3(359.50408935547, 2622.2700195312, 45.125778198242),
			otokilit = true,
		},
		["1095"] = {
			hash = 0x1095,
			model = -384231627,
			kordinat = vector3(354.15551757812, 2619.119140625, 45.124290466309),
			otokilit = true,
		},
		["1096"] = {
			hash = 0x1096,
			model = -384231627,
			kordinat = vector3(346.77569580078, 2617.5009765625, 45.122375488281),
			otokilit = true,
		},
		["1097"] = {
			hash = 0x1097,
			model = -384231627,
			kordinat = vector3(341.42712402344, 2614.3500976562, 45.120887756348),
			otokilit = true,
		},
		
		-- Şarap Mahzeni
		["1098"] = {
			hash = 0x1098,
			model = -384231627,
			kordinat = vector3(-1885.6789550781, 2060.7749023438, 145.73190307617),
			otokilit = true,
		},
		-- Şarap Mahzeni Kilitlenecek
		["1099"] = {
			hash = 0x1099,
			model = 988364535,
			kordinat = vector3(-1864.2130126953, 2061.2651367188, 141.14559936523),
			otokilit = true,
		},
		-- Yün Kilitli kapı 
		["1100"] = {
			hash = 0x1100,
			model = 262671971,
			kordinat = vector3(1407.5465087891, 1128.3287353516, 114.48545074463),
			otokilit = true,
		},

		-- Vinewood Hotel 

		["1101"] = {
			hash = 0x1101,
			model = -711771128,
			kordinat = vector3(487.88873291016, 223.07618713379, 104.88340759277),
			otokilit = true,
		},
		["1102"] = {
			hash = 0x1102,
			model = -711771128,
			kordinat = vector3(495.97232055664, 238.02177429199, 104.88095855713),
			otokilit = true,
		},
		["1103"] = {
			hash = 0x1103,
			model = -711771128,
			kordinat = vector3(508.15914916992, 233.5823059082, 104.88026428223),
			otokilit = true,
		},
		["1104"] = {
			hash = 0x1104,
			model = -711771128,
			kordinat = vector3(520.33142089844, 229.15997314453, 104.88550567627),
			otokilit = true,
		},
		["1105"] = {
			hash = 0x1105,
			model = -711771128,
			kordinat = vector3(532.13195800781, 223.01147460938, 104.88526916504),
			otokilit = true,
		},
		["1106"] = {
			hash = 0x1106,
			model = -711771128,
			kordinat = vector3(528.01129150391, 211.69393920898, 104.88538360596),
			otokilit = true,
		},
		["1107"] = {
			hash = 0x1107,
			model = -711771128,
			kordinat = vector3(523.85766601562, 200.33068847656, 104.88771820068),
			otokilit = true,
		},
		["1108"] = {
			hash = 0x1108,
			model = -711771128,
			kordinat = vector3(517.86090087891, 189.6071472168, 104.88523101807),
			otokilit = true,
		},
		["1109"] = {
			hash = 0x1109,
			model = -711771128,
			kordinat = vector3(491.84329223633, 199.07206726074, 104.88545227051),
			otokilit = true,
		},
		["1110"] = {
			hash = 0x1110,
			model = -711771128,
			kordinat = vector3(481.21325683594, 204.72229003906, 104.88040924072),
			otokilit = true,
		},
		["1111"] = {
			hash = 0x1111,
			model = -711771128,
			kordinat = vector3(491.84295654297, 199.07092285156, 108.44510650635),
			otokilit = true,
		},
		["1112"] = {
			hash = 0x1112,
			model = -711771128,
			kordinat = vector3(481.22427368164, 204.76239013672, 108.44654846191),
			otokilit = true,
		},
		["1113"] = {
			hash = 0x1113,
			model = -711771128,
			kordinat = vector3(485.34872436523, 216.0436706543, 108.44773864746),
			otokilit = true,
		},
		["1114"] = {
			hash = 0x1114,
			model = -711771128,
			kordinat = vector3(489.52862548828, 227.53921508789, 108.45066833496),
			otokilit = true,
		},
		["1115"] = {
			hash = 0x1115,
			model = -711771128,
			kordinat = vector3(495.98971557617, 238.02496337891, 108.45024871826),
			otokilit = true,
		},
		["1116"] = {
			hash = 0x1116,
			model = -711771128,
			kordinat = vector3(508.1598815918, 233.58413696289, 108.44752502441),
			otokilit = true,
		},
		["1117"] = {
			hash = 0x1117,
			model = -711771128,
			kordinat = vector3(520.35369873047, 229.13851928711, 108.45041656494),
			otokilit = true,
		},
		["1118"] = {
			hash = 0x1118,
			model = -711771128,
			kordinat = vector3(532.12738037109, 223.00720214844, 108.44902038574),
			otokilit = true,
		},
		["1119"] = {
			hash = 0x1119,
			model = -711771128,
			kordinat = vector3(528.01428222656, 211.73327636719, 108.4471206665),
			otokilit = true,
		},
		["1120"] = {
			hash = 0x1120,
			model = -711771128,
			kordinat = vector3(523.86993408203, 200.34286499023, 108.44730377197),
			otokilit = true,
		},
		["1121"] = {
			hash = 0x1121,
			model = -711771128,
			kordinat = vector3(517.87310791016, 189.5948638916, 108.44775390625),
			otokilit = true,
		},
	-- groove iç
		["1122"] = {
			hash = 0x1122,
			model = -1775447247,
			kordinat = vector3(115.04344177246, -1961.34375, 21.477006912231),
			otokilit = true,
		},
	-- groove yol
		["1123"] = {
			hash = 0x1123,
			model = 520341586,
			kordinat = vector3(46.02250289917, -1863.2879638672, 23.371206283569),
			otokilit = true,
		},
	-- hala yan ev 
		["1124"] = {
			hash = 0x1124,
			model = -543490328,
			kordinat = vector3(17.625335693359, -1443.5633544922, 31.104707717896),
			otokilit = true,
		},
		["1125"] = {
			hash = 0x1125,
			model = -1128607325,
			kordinat = vector3(20.375104904175, -1432.5051269531, 31.106452941895),
			otokilit = true,
		},
		["1126"] = {
			hash = 0x1126,
			model = -1128607325,
			kordinat = vector3(27.866645812988, -1436.1546630859, 31.104703903198),
			otokilit = true,
		},
		-- Mirror evler 
		
		["1127"] = {
			hash = 0x1127,
			model = 12662004,
			kordinat = vector3(971.60052490234, -726.48071289062, 58.343795776367),
			otokilit = true,
		},
		["1128"] = {
			hash = 0x1128,
			model = -232187956,
			kordinat = vector3(978.4755859375, -716.10162353516, 58.439254760742),
			otokilit = true,
		},

		["1129"] = {
			hash = 0x1129,
			model = 520341586,
			kordinat = vector3(959.23675537109, -669.54858398438, 58.551517486572),
			otokilit = true,
		},
		["1130"] = {
			hash = 0x1130,
			model = 964838196,
			kordinat = vector3(945.22106933594, -677.03985595703, 58.614887237549),
			otokilit = true,
		},

		["1131"] = {
			hash = 0x1131,
			model = -672840959,
			kordinat = vector3(934.58081054688, -651.85394287109, 58.522270202637),
			otokilit = true,
		},
		["1132"] = {
			hash = 0x1132,
			model = -1422530141,
			kordinat = vector3(943.42999267578, -652.60961914062, 58.721031188965),
			otokilit = true,
		},

		["1133"] = {
			hash = 0x1133,
			model = 964838196,
			kordinat = vector3(900.42956542969, -474.15881347656, 59.599884033203),
			otokilit = true,
		},
		["1134"] = {
			hash = 0x1134,
			model = 520341586,
			kordinat = vector3(906.71026611328, -488.75714111328, 59.536514282227),
			otokilit = true,
		},

		["1135"] = {
			hash = 0x1135,
			model = -672840959,
			kordinat = vector3(942.79998779297, -527.32788085938, 60.71907043457),
			otokilit = true,
		},
		["1136"] = {
			hash = 0x1136,
			model = -1422530141,
			kordinat = vector3(945.10052490234, -518.74963378906, 60.917831420898),
			otokilit = true,
		},

		["1137"] = {
			hash = 0x1137,
			model = 520341586,
			kordinat = vector3(920.11114501953, -568.91259765625, 58.467514038086),
			otokilit = true,
		},
		["1138"] = {
			hash = 0x1138,
			model = 964838196,
			kordinat = vector3(913.34686279297, -554.53198242188, 58.530883789062),
			otokilit = true,
		},

		["1139"] = {
			hash = 0x1137,
			model = 520341586,
			kordinat = vector3(1101.4747314453, -412.04864501953, 67.656517028809),
			otokilit = true,
		},
		["1140"] = {
			hash = 0x1138,
			model = 964838196,
			kordinat = vector3(1117.2899169922, -413.60955810547, 67.719886779785),
			otokilit = true,
		},

		
		["1141"] = {
			hash = 0x1137,
			model = -232187956,
			kordinat = vector3(1098.8342285156, -438.99984741211, 68.008903503418),
			otokilit = true,
		},
		["1142"] = {
			hash = 0x1138,
			model =-2080370239,
			kordinat = vector3(1108.3444824219, -444.12075805664, 67.717651367188),
			otokilit = true,
		},
		
		["1143"] = {
			hash = 0x1143,
			model = -1422530141,
			kordinat = vector3(1221.0582275391, -669.82263183594, 63.785491943359),
			otokilit = true,
		},
		["1144"] = {
			hash = 0x1144,
			model = -672840959,
			kordinat = vector3(1228.5581054688, -674.57989501953, 63.586730957031),
			otokilit = true,
		},

		["1145"] = {
			hash = 0x1145,
			model = -232187956,
			kordinat = vector3(1251.2349853516, -493.47610473633, 70.125091552734),
			otokilit = true,
		},
		["1146"] = {
			hash = 0x1146,
			model = 12662004,
			kordinat = vector3(1238.7895507812, -493.79739379883, 70.029632568359),
			otokilit = true,
		},
		["1147"] = {
			hash = 0x1147,
			model = -2080370239,
			kordinat = vector3(1245.1994628906, -502.43371582031, 69.833839416504),
			otokilit = true,
		},
		["1148"] = {
			hash = 0x1148,
			model = -2080370239,
			kordinat = vector3(982.35150146484, -726.18353271484, 58.148002624512),
			otokilit = true,
		},

		["1149"] = {
			hash = 0x1149,
			model = 520341586,
			kordinat = vector3(1303.9165039062, -527.20593261719, 71.561515808105),
			otokilit = true,
		},
		["1150"] = {
			hash = 0x1150,
			model = 964838196,
			kordinat = vector3(1309.5611572266, -512.35009765625, 71.624885559082),
			otokilit = true,
		},

		["1151"] = {
			hash = 0x1151,
			model = 520341586,
			kordinat = vector3(1349.1267089844, -546.615234375, 73.98851776123),
			otokilit = true,
		},
		["1152"] = {
			hash = 0x1152,
			model = 964838196,
			kordinat = vector3(1355.5991210938, -532.1025390625, 74.051887512207),
			otokilit = true,
		},

		["1153"] = {
			hash = 0x1153,
			model = 520341586,
			kordinat = vector3(1389.6821289062, -569.89874267578, 74.599517822266),
			otokilit = true,
		},
		["1154"] = {
			hash = 0x1154,
			model = 964838196,
			kordinat = vector3(1404.4030761719, -563.9111328125, 74.662887573242),
			otokilit = true,
		},

		["1155"] = {
			hash = 0x1155,
			model = 520341586,
			kordinat = vector3(1386.2075195312, -594.26513671875, 74.586517333984),
			otokilit = true,
		},
		["1156"] = {
			hash = 0x1156,
			model = 964838196,
			kordinat = vector3(1398.6619873047, -604.13653564453, 74.649887084961),
			otokilit = true,
		},

		["1157"] = {
			hash = 0x1157,
			model = 520341586,
			kordinat = vector3(1366.6300048828, -607.0625, 74.814514160156),
			otokilit = true,
		},
		["1158"] = {
			hash = 0x1158,
			model = 964838196,
			kordinat = vector3(1366.3129882812, -622.95141601562, 74.877883911133),
			otokilit = true,
		},
		["1159"] = {
			hash = 0x1159,
			model = 520341586,
			kordinat = vector3(1322.6176757812, -583.31799316406, 73.347518920898),
			otokilit = true,
		},
		["1160"] = {
			hash = 0x1160,
			model = 964838196,
			kordinat = vector3(1315.7606201172, -597.65454101562, 73.410888671875),
			otokilit = true,
		},
		["1161"] = {
			hash = 0x1161,
			model = 520341586,
			kordinat = vector3(1300.2966308594, -574.50207519531, 71.833518981934),
			otokilit = true,
		},
		["1162"] = {
			hash = 0x1162,
			model = 964838196,
			kordinat = vector3(1295.3902587891, -589.61779785156, 71.89688873291),
			otokilit = true,
		},

		-- Kırmızı yanı apartman 
		
		["1163"] = {
			hash = 0x1163,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 48.026832580566),
			otokilit = true,
		},
		["1164"] = {
			hash = 0x1164,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 53.018592834473),
			otokilit = true,
		},
		["1165"] = {
			hash = 0x1165,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 57.963489532471),
			otokilit = true,
		},
		["1166"] = {
			hash = 0x1166,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 62.999687194824),
			otokilit = true,
		},
		["1167"] = {
			hash = 0x1167,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 68.025512695312),
			otokilit = true,
		},
		["1168"] = {
			hash = 0x1168,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 73.044052124023),
			otokilit = true,
		},
		["1169"] = {
			hash = 0x1169,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 78.069381713867),
			otokilit = true,
		},
		["1170"] = {
			hash = 0x1170,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 83.09797668457),
			otokilit = true,
		},
		["1171"] = {
			hash = 0x1171,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 88.170211791992),
			otokilit = true,
		},
		["1172"] = {
			hash = 0x1172,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 93.247543334961),
			otokilit = true,
		},
		["1173"] = {
			hash = 0x1173,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 98.456611633301),
			otokilit = true,
		},
		["1174"] = {
			hash = 0x1174,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 103.55363464355),
			otokilit = true,
		},
		["1175"] = {
			hash = 0x1175,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 108.7145614624),
			otokilit = true,
		},
		["1176"] = {
			hash = 0x1176,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 113.81753540039),
			otokilit = true,
		},
		["1177"] = {
			hash = 0x1177,
			model = -543490328,
			kordinat = vector3(-276.17556762695, -734.8076171875, 118.9118347168),
			otokilit = true,
		},
		["1178"] = {
			hash = 0x1178,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 48.026832580566),
			otokilit = true,
		},
		["1179"] = {
			hash = 0x1179,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391,  53.018589019775),
			otokilit = true,
		},
		["1180"] = {
			hash = 0x1180,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 57.963489532471),
			otokilit = true,
		},
		["1181"] = {
			hash = 0x1181,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 62.999691009521),
			otokilit = true,
		},
		["1182"] = {
			hash = 0x1182,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 68.025512695312),
			otokilit = true,
		},
		["1183"] = {
			hash = 0x1183,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 73.044052124023),
			otokilit = true,
		},
		["1184"] = {
			hash = 0x1184,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 78.069381713867),
			otokilit = true,
		},
		["1185"] = {
			hash = 0x1185,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 83.097984313965),
			otokilit = true,
		},
		["1186"] = {
			hash = 0x1186,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 88.170211791992),
			otokilit = true,
		},
		["1187"] = {
			hash = 0x1187,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 93.247543334961),
			otokilit = true,
		},
		["1188"] = {
			hash = 0x1188,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 98.456611633301),
			otokilit = true,
		},
		["1189"] = {
			hash = 0x1189,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 103.55364227295),
			otokilit = true,
		},
		["1190"] = {
			hash = 0x1190,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 108.71453857422),
			otokilit = true,
		},
		["1191"] = {
			hash = 0x1191,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 113.81754302979),
			otokilit = true,
		},
		["1192"] = {
			hash = 0x1192,
			model = -543490328,
			kordinat = vector3(-287.60678100586, -728.68316650391, 118.91184234619),
			otokilit = true,
		},
		-- Bayview Otel
		["1193"] = {
			hash = 0x1193,
			model = -664582244,
			kordinat = vector3(-681.81958007812, 5769.9638671875, 17.673889160156),
			otokilit = true,
		},
		["1194"] = {
			hash = 0x1194,
			model = -664582244,
			kordinat = vector3(-683.65643310547, 5766.0541992188, 17.679815292358),
			otokilit = true,
		},
		["1195"] = {
			hash = 0x1195,
			model = -664582244,
			kordinat = vector3(-685.50012207031, 5762.130859375, 17.679918289185),
			otokilit = true,
		},
		["1196"] = {
			hash = 0x1196,
			model = -664582244,
			kordinat = vector3(-687.33026123047, 5758.2133789062, 17.687311172485),
			otokilit = true,
		},
		["1197"] = {
			hash = 0x1197,
			model = -664582244,
			kordinat = vector3(-691.02056884766, 5759.4223632812, 17.673889160156),
			otokilit = true,
		},
		["1198"] = {
			hash = 0x1198,
			model = -664582244,
			kordinat = vector3(-694.97149658203, 5761.2236328125, 17.673889160156),
			otokilit = true,
		},
		["1199"] = {
			hash = 0x1199,
			model = -664582244,
			kordinat = vector3(-698.88739013672, 5763.048828125, 17.673889160156),
			otokilit = true,
		},
		["1200"] = {
			hash = 0x1200,
			model = -664582244,
			kordinat = vector3(-702.81060791016, 5764.892578125, 17.673889160156),
			otokilit = true,
		},
		["1201"] = {
			hash = 0x1201,
			model = -664582244,
			kordinat = vector3(-706.74334716797, 5766.69140625, 17.673889160156),
			otokilit = true,
		},
		["1202"] = {
			hash = 0x1202,
			model = -664582244,
			kordinat = vector3(-710.64660644531, 5768.5395507812, 17.673889160156),
			otokilit = true,
		},
		
		-- Stash house
		["1203"] = {
			hash = 0x1203,
			model = -2113580896,
			kordinat = vector3(724.74731445312, -697.95483398438, 28.892692565918),
			otokilit = true,
		},

		-- Strangeway
		["1204"] = {
			hash = 0x1204,
			model = 964838196,
			kordinat = vector3(-597.21911621094, 209.99320983887, 74.310844421387),
			otokilit = true,
		},
		-- Motor Hotel
		["1205"] = {
			hash = 0x1205,
			model = -1635579193,
			kordinat = vector3(1142.7965087891, 2664.509765625, 38.193367004395),
			otokilit = true,
		},
		["1206"] = {
			hash = 0x1206,
			model = -1635579193,
			kordinat = vector3(1142.8197021484, 2651.7724609375, 38.17932510376),
			otokilit = true,
		},
		["1207"] = {
			hash = 0x1207,
			model = -1635579193,
			kordinat = vector3(1142.8028564453, 2644.2138671875, 38.180355072021),
			otokilit = true,
		},
		["1208"] = {
			hash = 0x1208,
			model = -1635579193,
			kordinat = vector3(1141.8248291016, 2641.2277832031, 38.179431915283),
			otokilit = true,
		},
		["1209"] = {
			hash = 0x1209,
			model = -1635579193,
			kordinat = vector3(1133.4150390625, 2641.2019042969, 38.185253143311),
			otokilit = true,
		},
		["1210"] = {
			hash = 0x1210,
			model = -1635579193,
			kordinat = vector3(1122.0966796875, 2641.1982421875, 38.190124511719),
			otokilit = true,
		},
		["1211"] = {
			hash = 0x1211,
			model = -1635579193,
			kordinat = vector3(1115.3822021484, 2641.1938476562, 38.179306030273),
			otokilit = true,
		},
		["1212"] = {
			hash = 0x1212,
			model = -1635579193,
			kordinat = vector3(1107.8323974609, 2641.212890625, 38.198837280273),
			otokilit = true,
		},
		["1213"] = {
			hash = 0x1213,
			model = -1635579193,
			kordinat = vector3(1105.6751708984, 2648.3984375, 38.177387237549),
			otokilit = true,
		},
		-- Tangerine Motel
		["1214"] = {
			hash = 0x1214,
			model = 597055185,
			kordinat = vector3(970.86749267578, -200.19839477539, 73.529800415039),
			otokilit = true,
		},
		["1215"] = {
			hash = 0x1215,
			model = 597055185,
			kordinat = vector3(967.47546386719, -205.85107421875, 73.541702270508),
			otokilit = true,
		},
		["1216"] = {
			hash = 0x1216,
			model = 597055185,
			kordinat = vector3(951.00610351562, -210.8059387207, 73.519737243652),
			otokilit = true,
		},
		["1217"] = {
			hash = 0x1217,
			model = 597055185,
			kordinat = vector3(947.54040527344, -205.12532043457, 73.524261474609),
			otokilit = true,
		},
		["1218"] = {
			hash = 0x1218,
			model = 597055185,
			kordinat = vector3(950.31939697266, -200.4697265625, 73.530799865723),
			otokilit = true,
		},
		["1219"] = {
			hash = 0x1219,
			model = 597055185,
			kordinat = vector3(953.12121582031, -195.84439086914, 73.541206359863),
			otokilit = true,
		},
		["1220"] = {
			hash = 0x1220,
			model = 597055185,
			kordinat = vector3(970.86395263672, -200.20513916016, 76.568305969238),
			otokilit = true,
		},
		["1221"] = {
			hash = 0x1221,
			model = 597055185,
			kordinat = vector3(967.451171875, -205.85125732422, 76.587074279785),
			otokilit = true,
		},
		["1222"] = {
			hash = 0x1222,
			model = 597055185,
			kordinat = vector3(964.63586425781, -210.51290893555, 76.571502685547),
			otokilit = true,
		},
		["1223"] = {
			hash = 0x1223,
			model = 597055185,
			kordinat = vector3(961.83752441406, -215.12713623047, 76.567840576172),
			otokilit = true,
		},
		["1224"] = {
			hash = 0x1224,
			model = 597055185,
			kordinat = vector3(956.9189453125, -214.32885742188, 76.579032897949),
			otokilit = true,
		},
		["1225"] = {
			hash = 0x1225,
			model = 597055185,
			kordinat = vector3(947.95935058594, -208.98713684082, 76.577041625977),
			otokilit = true,
		},
		["1226"] = {
			hash = 0x1226,
			model = 597055185,
			kordinat = vector3(947.54583740234, -205.14036560059, 76.587440490723),
			otokilit = true,
		},
		["1227"] = {
			hash = 0x1227,
			model = 597055185,
			kordinat = vector3(950.31213378906, -200.46855163574, 76.577056884766),
			otokilit = true,
		},
		["1228"] = {
			hash = 0x1228,
			model = 597055185,
			kordinat = vector3(970.82415771484, -200.17042541504, 79.617210388184),
			otokilit = true,
		},
		["1229"] = {
			hash = 0x1229,
			model = 597055185,
			kordinat = vector3(967.46325683594, -205.87289428711, 79.615653991699),
			otokilit = true,
		},
		["1230"] = {
			hash = 0x1230,
			model = 597055185,
			kordinat = vector3(964.67144775391, -210.51290893555, 79.603584289551),
			otokilit = true,
		},
		["1231"] = {
			hash = 0x1231,
			model = 597055185,
			kordinat = vector3(961.88946533203, -215.16064453125, 79.603691101074),
			otokilit = true,
		},
		["1232"] = {
			hash = 0x1232,
			model = 597055185,
			kordinat = vector3(956.89117431641, -214.35316467285, 79.635238647461),
			otokilit = true,
		},
		["1233"] = {
			hash = 0x1233,
			model = 597055185,
			kordinat = vector3(947.96911621094, -208.97096252441, 79.625854492188),
			otokilit = true,
		},
		["1234"] = {
			hash = 0x1234,
			model = 597055185,
			kordinat = vector3(947.52404785156, -205.11297607422, 79.614723205566),
			otokilit = true,
		},
		["1235"] = {
			hash = 0x1235,
			model = 597055185,
			kordinat = vector3(950.32446289062, -200.47839355469, 79.626571655273),
			otokilit = true,
		},
		["1236"] = {
			hash = 0x1236,
			model = 597055185,
			kordinat = vector3(953.13208007812, -195.83743286133, 79.616004943848),
			otokilit = true,
		},
		-- paleto villa 

		["1237"] = {
			hash = 0x1237,
			model = -1516927114,
			kordinat = vector3(-130.78968811035, 6552.7734375, 30.40308380127),
			otokilit = true,
		},
		["1238"] = {
			hash = 0x1238,
			model = -658026477,
			kordinat = vector3(-127.81976318359, 6560.1596679688, 30.076711654663),
			otokilit = true,
		},

		--Unutulan Çift Kapılar
		["2000"] = {
			hash = 0x2000,
			model = 2049607469,
			kordinat = vector3(-334.12, 524.84, 120.43),
			otokilit = true,
		},
		["2001"] = {
			hash = 0x2001,
			model = -1686014385,
			kordinat = vector3(-816.11, 177.51, 72.83),
			otokilit = true,
		},
		["2002"] = {
			hash = 0x2002,
			model = 1245831483,
			kordinat = vector3(-794.18530273438, 182.56800842285, 73.040451049805),
			otokilit = true,
		},
		["2003"] = {
			hash = 0x2003,
			model = 1245831483,
			kordinat = vector3(-794.50512695312, 178.01237487793, 73.040451049805),
			otokilit = true,
		},
	}
}


Citizen.CreateThread(function()
    while PantCore == nil do
        TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)
        Citizen.Wait(200)
	end

	PantCore.Functions.TriggerCallback('ld-kapikilit:ilk-giris', function(kapiDurumuServer)
		for bolge, bolgeData in pairs(kapiListesi) do
			for no, kapi in pairs(bolgeData) do
				if not IsDoorRegisteredWithSystem(kapi.hash) then
					AddDoorToSystem(kapi.hash, kapi.model, kapi.kordinat, true, true, true)
					if kapiDurumuServer[no] then
						kapiDurum = kapiDurumuServer[no].durum
					else
						kapiDurum = (kapi.otokilit == true and 1 or 0)
					end
					DoorSystemSetDoorState(kapi.hash, kapiDurum, 0 ,1)
					SetStateOfClosestDoorOfType(kapi.hash, kapi.kordinat, 1, 0.0, true)
				end	
			end
		end
		doorDataLoaded = true
	end)
end)

RegisterNetEvent('PantCore:Client:OnPlayerLoaded')
AddEventHandler('PantCore:Client:OnPlayerLoaded', function()
	PlayerData = PantCore.Functions.GetPlayerData()
end)

RegisterNetEvent('PantCore:Client:OnJobUpdate')
AddEventHandler('PantCore:Client:OnJobUpdate', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('esx_doorlock:currentlyhacking')
AddEventHandler('esx_doorlock:currentlyhacking', function(mycb)
	mycb = true
	TriggerEvent("mhacking:show") --This line is where the hacking even starts
	TriggerEvent("mhacking:start", 2, 15, mycb1) --This line is the difficulty and tells it to start. First number is how long the blocks will be the second is how much time they have is.
end)

local playerPed = PlayerPedId()
local oyuncuKordinat = GetEntityCoords(playerPed)
local bulunanKonum = nil
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if doorDataLoaded then
			playerPed = PlayerPedId()
			oyuncuKordinat = GetEntityCoords(playerPed)
			konumBulundu = false
			for x,y in pairs(bolgeler) do 
				if #(y.coords - oyuncuKordinat) < y.r then
					bulunanKonum = x
					konumBulundu = true
				end
			end
			if not konumBulundu then
				bulunanKonum = nil
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local sure = 500
		if doorDataLoaded and bulunanKonum then
			for no, kapi in pairs(kapiListesi[bulunanKonum]) do
				if #(oyuncuKordinat - kapi.kordinat) < kapi.kilitmesafe then
					for i=1, #kapi.meslek do
						if (PlayerData.job and PlayerData.job.name == kapi.meslek[i]) then
							sure = 1
							yakinKapi = kapi
							kapiDurumu = DoorSystemGetDoorState(kapi.hash) == 0 and 1 or 0
							if kapiDurumu == 1 then yazi = "Unlocked" else yazi = "Locked" end
							local doorCoordsOffset = GetOffsetFromEntityInWorldCoords(GetClosestObjectOfType(kapi.kordinat, 3.0, kapi.model, false, false, false), chechDoorCoordsOffset(kapi.model, Object, kapi.kordinat))  
							--print(json.encode(kapi))
							PantCore.Functions.DrawText3D(doorCoordsOffset.x, doorCoordsOffset.y, doorCoordsOffset.z, "[E] " .. yazi)
							if IsControlJustReleased(0, 38) then
								doorAnim()
								if kapiDurumu == 1 then
									PantCore.Functions.Notify("Door locked", "error", 1200)
								else
									PantCore.Functions.Notify("Door unlocked", "success", 1200)
								end
								if kapi.tip ~= "surgulu" then doorOpenRatio(kapi.hash) end
								TriggerServerEvent("ld-kapikilit:kapi-durumu", kapi, kapiDurumu)
							end	

						end
					end
				end
			end
		end
		Citizen.Wait(sure)
	end
end)

RegisterNetEvent("ld-kapikilit:kapi-durumu-guncelle")
AddEventHandler("ld-kapikilit:kapi-durumu-guncelle", function(kapi, data)
	DoorSystemSetDoorState(kapi.hash, data.durum, 0 ,1)
	SetStateOfClosestDoorOfType(kapi.hash, kapi.kordinat, 1, 0.0, true)
end)

RegisterNetEvent('esx_doorlock:motel-kapi')
AddEventHandler('esx_doorlock:motel-kapi', function()
	doorAnim()
	doorOpenRatio(yakinKapi.hash)
	TriggerServerEvent("ld-kapikilit:kapi-durumu", yakinKapi, kapiDurumu)
end)

exports('kapidurum', function(kapiNo)
	local yazi = "BİLİNMİYOR!"
	local kapi = kapiListesi["evler"][kapiNo]
	local coord = nil
	if kapi then
		local kapiDurumu = DoorSystemGetDoorState(kapi.hash) == 0 and 1 or 0
		if kapiDurumu == 1 then yazi = "Açık" else yazi = "Kilitli" end
		coord = GetOffsetFromEntityInWorldCoords(GetClosestObjectOfType(kapi.kordinat, 3.0, kapi.model, false, false, false), chechDoorCoordsOffset(kapi.model, Object, kapi.kordinat))  
	end
    return {durum = yazi, coord = vector3(coord.x, coord.y, coord.z)}
end)

RegisterNetEvent('esx_doorlock:ev-kapi')
AddEventHandler('esx_doorlock:ev-kapi', function(kapiNo)
	doorAnim()
	local kapiData = kapiListesi["evler"][kapiNo]
	doorOpenRatio(kapiData.hash)
	local kapiDurumu = DoorSystemGetDoorState(kapiData.hash) == 0 and 1 or 0
	if kapiDurumu == 1 then
		PantCore.Functions.Notify("Door locked", "error", 1200)
	else
		PantCore.Functions.Notify("Door unlocked", "success", 1200)
	end
	TriggerServerEvent("ld-kapikilit:kapi-durumu", kapiData, kapiDurumu)
end)

RegisterNetEvent('esx_doorlock:mucevher-kapi')
AddEventHandler('esx_doorlock:mucevher-kapi', function(durum)
	local kapiData = {}
	print(durum)
	kapiData.durum = durum
	TriggerEvent("ld-kapikilit:kapi-durumu-guncelle", kapiListesi["mucevher"]["95"], kapiData)
	TriggerEvent("ld-kapikilit:kapi-durumu-guncelle", kapiListesi["mucevher"]["96"], kapiData)
	print("maladiss")
end)

function mycb1(success, timeremaining)
	TriggerServerEvent("esx_hackerjob:tabletver")
	TriggerEvent('mhacking:hide')	
	if success then
		TriggerServerEvent("ld-kapikilit:kapi-durumu", yakinKapi, kapiDurumu)
		PantCore.Functions.Notify('Door unlocked!')
		if math.random(0, 100) >= 95 then
			TriggerEvent("Ld-PolisBildirim:BildirimGonder", "Hack", false)	
		end
	else
		TriggerEvent("Ld-PolisBildirim:BildirimGonder", "Hack", false)	
		PantCore.Functions.Notify('You failed!')	
	end
end

function doorOpenRatio(hash)
	while math.abs(DoorSystemGetOpenRatio(hash)) > 0.1 do
		Citizen.Wait(20)
	end
end

function doorAnim()
    ClearPedSecondaryTask(playerPed)
	while not HasAnimDictLoaded("anim@heists@keycard@") do
        RequestAnimDict("anim@heists@keycard@" )
        Citizen.Wait(5)
    end
	TaskPlayAnim(playerPed, "anim@heists@keycard@", "exit", 8.0, 1.0, 850, 49, 0, 0, 0, 0 )
end

function chechDoorCoordsOffset(model, Object, doorCoords)
	local data = vector3(0.0, 0.0, 0.0)
	if model == -2023754432 or model == 1888438146 or model == -1417290930 or model == 1641293839 or model == 854291622 then
		data = vector3(1.1, 0.0, 0.0)
	elseif model == -222270721 or model == 746855201 or model == -1033001619 or model == -574290911 or model == -434783486 then
		data = vector3(1.2, 0.0, 0.0)   
	elseif model == -1156020871 or model == 1309269072 or model == -1023447729 or model == -1011692606 or model == 91564889 then
		data = vector3(1.4, 0.0, 0.0)  
	elseif model == 12662004 or model == 561230220 or model == -1920147247 or model == -464151082 or model == -770740285 or model == -543497392 or model == 1770281453 or model == 1173348778 or model == 479144380 or model == 1242124150 or model == 2088680867 or model == -320876379 or model == 631614199 or model == -1320876379 or model == -1437850419 or model == -681066206 or model == 245182344 or model == 1971752884 or model == 1773345779 or model == 320433149 or model == -607040053 or model == 272205552 or model == 1507503102 or model == 1557126584 or model == -131296141 or model == 9467943 or model == 534758478 or  model == 551491569 or model == -495720969 or model == 749848321 or model == 933053701 or model == 185711165 or model == -1726331785 or model == -543490328 then
		data = vector3(-1.1, 0.0, 0.0) 																	 
	elseif model == -710818483 or model == -642608865 then
		data = vector3(-1.3, 0.0, 0.0)
	elseif model == 988364535 then
		data = vector3(0.4, 0.0, 0.0)
	elseif model == -1141522158 then
		data = vector3(-0.4, 0.0, 0.0)
	elseif model == -1156992775 then
		data = vector3(0.95, 0.0, 0.0)
	elseif model == 1653893025 then
		data = vector3(-1.20, 0.0, 0.0)
	elseif model == 161378502 then
		data = vector3(-1.20, 0.0, 1.15)
	elseif model == 1808123841 then	
		data = vector3(1.3, 0.0, 0.05)
	elseif model == -1483471451 then
		data = vector3(-3.0, 0.0, 1.50)
	elseif model == -1603817716 then
		data = vector3(-2.8, 0.0, 1.50)
	elseif model == -1612152164 then
		data = vector3(-1.1, 0.0, 1.1)
	elseif model == 873979204 then
		data = vector3(1.20, 0.0, 0.0)
	elseif model == 493136920 then
		data = vector3(1.20, 0.0, 0.0)
	elseif model == 665455406 then
		data = vector3(1.20, 0.0, 0.0)
	elseif model == -658026477 or model == -664582244 or model == -232187956 or model == -1128607325 or model == -1775447247 or model == -711771128 or model == 520341586 or model == -88942360 or model == 1980513646 or model == 308207762 or model == 1398355146 or model == -1700911976 or model == 1388858739 or model == 34120519 or model == 964838196 or model == -952356348 or model == -1563799200 or model == 1346738325 or model == -1927754726 or model == 580361003 or model == -1988553564 or model == -884718443 then
		data = vector3(-1.20, 0.0, 0.0)
	elseif model == -340230128 or model == -829332642 or model == 736699661 or model == 458025182 or model == -519068795 or model == -551608542 or model == 165994623 or model == -1543859032 then
		data = vector3(1.20, 0.0, 0.0)
	elseif model == -2123441472 or model == 2049607469 then
		data = vector3(-1.0, 0.0, -0.2)
	elseif model == -580006562 then
		data = vector3(-1.0, 0.0, 0.25)
	elseif model == 159994461 then
		data = vector3(0.8, 0.0, -0.45)
	elseif model == -384231627 or model == -1422530141 then
		data = vector3(0.0, 1.05, 0.0)
	elseif model == -672840959 then
		data = vector3(0.0, -1.0, 0.0)
	elseif model == -53345114 or model == -96679321 then
		data = vector3(-1.0, 0.0, 0.0)
	else
		data = vector3(1.0, 0.0, 0.0)
	end
	return data
end