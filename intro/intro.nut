fe.load_module("file");

class UserConfig
{
    </ label="Play intro", help="Toggle playback of intro video when Attract-Mode starts", options="Yes,No", order=1 />
    play_intro = "Yes";
}

// Any signal will cause intro mode to exit
function end_mode()
{
    fe.signal("select");
}

local config = fe.get_config();
local paths
local player

switch (config["play_intro"])
{
    case "No":
        return end_mode()
        break
		
    case "Yes":
    default:
		
		local pathlist = DirectoryListing("../intro").results
	
		paths = []
		for (local i=0; i<pathlist.len(); i++ )
		{
			local r = regexp(".mp4")
			local t = r.capture(pathlist[i])
			
			if (t != null)
				paths.push(pathlist[i])
		}

		if (paths.len() == 0) end_mode()
		else
		{
			local path = paths[rand() % paths.len()]
		
			player = fe.add_image(path, 0, 0, ScreenWidth, ScreenHeight);
		
			fe.add_ticks_callback("intro_tick")
		}
        break;
}

function intro_tick(ttime)
{
    if (player.video_playing == false)
        end_mode()
	
    return false
}
