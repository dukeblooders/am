//******************************************************************************
// Modules
//******************************************************************************
fe.load_module("file");


//******************************************************************************
// User configuration
//******************************************************************************
class UserConfig
{
    </ label="Play intro", help="Toggle playback of intro video when Attract-Mode starts", options="Yes,No", order=1 />
    play_intro = "Yes";
}


//******************************************************************************
// Settings
//******************************************************************************
local video_extension = ".mp4"
local video_path = "../intro"


//******************************************************************************
// Variables
//******************************************************************************
local player = null


//******************************************************************************
// End
//******************************************************************************
function End()
{
    fe.signal("select");
}


//******************************************************************************
// Init
//******************************************************************************
local config = fe.get_config();

switch (config["play_intro"])
{
    case "No":
        return End()
		
    case "Yes":
    default:
		local pathList = DirectoryListing(video_path).results
	
		local paths = []
		foreach(path in pathList)
			if (regexp(video_extension).capture(path) != null)
				paths.push(path)

		if (paths.len() == 0) 
		{
			End()
		}
		else
		{
			local path = paths[rand() % paths.len()]

			player = fe.add_image(path, 0, 0, fe.layout.width, fe.layout.height);
		
			fe.add_ticks_callback("TicksCallback")
		}
        break;
}


//******************************************************************************
// Callbacks
//******************************************************************************
function TicksCallback(ttime)
{
    if (!player.video_playing)
        End()
}