Config = {}
Config.KeyToOpenMenu = 38 -- https://docs.fivem.net/docs/game-references/controls/
Config.KeyToOpenMenuText = "E" -- NAME OF KEY

Config.showNPCName = true -- FALSE = BETTER CPU CONSUMPTION

Config.NPC = {
    {name="Nae Moraru", x=-889.4756, y=-853.501, z=19.56612},
  }

Config.Rewards = {
  ['First'] = {moneyValue1 = 15000, moneyValue2 = 30000 , candiesValue1 = 25, candiesValue2 = 40}

}

Config.TargetPumpkins = {
  {value = 2},
  {value = 3}
}
Config.Hits = {
  {value = 1},
  {value = 3} -- Maximum 3 , if you want to change go to scripts.js and look for the updateHit event
}

Config.Pumpkins = {
  {
      pos = vector4(-1054.676, -232.1662, 43.02101, 5.579286) -- MAIN VALUE FROM CUTSCENE ( vector4(-1054.676, -232.1662, 43.02101, 5.579286) )
  },
  {
      pos = vector4(-874.9026, -854.6263, 18.12326, 211.039)
  },
  {
      pos = vector4(-866.2543, -851.3271, 18.37952, 6.10395)
  },
  {
      pos = vector4(-864.2824, -841.4655, 18.23237, 12.73577)
  },
  {
      pos = vector4(-882.5585, -858.5096, 18.12326, 137.9147)
  }
}
