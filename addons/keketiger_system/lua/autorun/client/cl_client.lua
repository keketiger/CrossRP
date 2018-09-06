if (CLIENT) then
	timer.Create("ClearDecals", 180, 0, function() -- 180 seconds
		RunConsoleCommand("r_cleardecals", "") -- Command that clear decals
		--notification.AddLegacy( "Successful cleaning decals on the map!", NOTIFY_GENERIC, 5 ) -- Message about success clear decals
		-- RunConsoleCommand("cl_removedecals", "") -- Old command that working when sv_cheats 1
		--print("[ACD] Successful cleaning decals on the map!") -- Print message in player console
	end)	
end