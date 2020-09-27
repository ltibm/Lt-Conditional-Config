//This addanos requires externally library;
//Download adress is https://github.com/ltibm/TextEngine
#include "../TextEngine/TextEngine"
#include "LtCndConfig/_functions"
CCVar@ cvar_Status;
CCVar@ cvar_LoadTime;
const string config_path = "scripts/plugins/LtCndConfig/configs/";
string tempcfgfileLocation = "";
void PluginInit()
{
	g_Module.ScriptInfo.SetAuthor( "Lt." );
	g_Module.ScriptInfo.SetContactInfo( "https://steamcommunity.com/id/ibmlt/" );
	//@cvar_Lazy = CCVar("lazy_cfg", "server_lazy", "Set cfg name", ConCommandFlag::AdminOnly);
	@cvar_Status = CCVar("cconfig_status", 3, "Enable or disable this addon(1 to 3)", ConCommandFlag::AdminOnly);
	@cvar_LoadTime = CCVar("cconfig_loadtime", 0.25, "Set conditional config  loading time", ConCommandFlag::AdminOnly);
	ConfigStart();
}
void MapInit()
{
	if(cvar_Status.GetInt() != 1) return;
	ConfigStart();
}
void MapActivate()
{
	if(cvar_Status.GetInt() != 2) return;
	ConfigStart();
}

void MapStart()
{
	if(cvar_Status.GetInt() < 3) return;
	ConfigStart();
}
void ConfigStart()
{
	//0 disabled
	if(cvar_Status.GetInt() == 0) return;
	if(cvar_LoadTime.GetFloat() <= 0.001)
	{
		LoadConditionalConfig();
		return;
	}

	g_Scheduler.SetTimeout("LoadConditionalConfig", cvar_LoadTime.GetFloat());
}
void LoadConditionalConfig()
{
	tempcfgfileLocation= GetDynamicConfigFile();
	g_EngineFuncs.ServerCommand("exec \"" + tempcfgfileLocation + "\"\r\n");
	g_EngineFuncs.ServerPrint("\r\nConditional config file is loaded\r\n");
	g_Scheduler.SetTimeout("DeleteTempFile", 1.5);
}
void DeleteTempFile()
{
	FILEUTIL::Delete(tempcfgfileLocation);
}
string GetDynamicConfigFile()
{
	string loc = "_config_start.cfg";
	string saveloc = "scripts/plugins/store/condconfig" + GenerateNumber() + ".cfg";
	TextEngine::Text::TextEvulator@ te = TextEngine::Text::TextEvulator(config_path + loc, true);
	dictionary@ globals = dictionary();
	InitFunctionsAndVars(@globals);
	te.TrimStartEnd = true;
	@te.GlobalParameters = @globals;
	te.Parse();
	auto@ result = te.Elements.EvulateValue(0, 0);
	FILEUTIL::SaveAllText(saveloc, result.TextContent);
	return saveloc;
}
int GenerateNumber(int minlen = 4, int maxlen = 4)
{
	if(maxlen <= 0) return 0;
	if(minlen < 1) minlen = 1;
	if(minlen > maxlen) minlen = maxlen;
	int mlen = maxlen;
	if(minlen != maxlen)
	{
		mlen = Math.RandomLong(minlen, maxlen);
	}
	string generated = "";
	for(int i = 0; i < mlen; i++)
	{
		if(i == 0)
		{		
			generated += string(Math.RandomLong(1, 9));
		}
		else
		{	
			generated += string(Math.RandomLong(0, 9));
		}
	}
	return atoi(generated);
}