if (CLIENT) then
    timer.Create('ClearDecals', 180, 0, function() -- 180 seconds
        RunConsoleCommand('r_cleardecals', '')
        --RunConsoleCommand('cl_removedecals', '') -- Old command that working when sv_cheats 1
        --print('[Serveur] Nettoyage des decals sur la carte réussi !') -- Print message in player console
    end)
end
