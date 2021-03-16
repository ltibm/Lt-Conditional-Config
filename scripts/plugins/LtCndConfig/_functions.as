void InitFunctionsAndVars(dictionary@ globals)
{
	globals.set("config_path", config_path);
	globals.set("map", @Object_Function(@Func_Map));
	globals.set("is_survival", @Object_Function(@Func_IsSurvival));
	globals.set("startswith", @Object_Function(@Func_StartsWith));
	globals.set("endswith", @Object_Function(@Func_EndsWith));
	globals.set("str_startswith_multi_ci", @Object_Function(@Func_StartsWith_Ci));
}
//Case insesivite
Object@ Func_StartsWith_Ci(Objects@ parameters)
{
	if(parameters.Count < 2 || parameters[0] is null || parameters[0].IsEmpty() || parameters[1] is null || parameters[1].ObjectType != ObjectType_ObjectList)
	{
		return Object_Bool(false);
	}
	string first = parameters[0].ToString().ToLowercase();
	Objects@ allArrays = @parameters[1];
	for(int i = 0; i < allArrays.Count; i++)
	{
		if(allArrays[i] is null || allArrays[i].IsEmpty()) continue;
		string last = allArrays[i].ToString().ToLowercase();
		if(first.StartsWith(last)) return Object_Bool(true);
	}
	return Object_Bool(false);
}
Object@ Func_IsSurvival(Objects@ parameters)
{
	return @Object_Bool(g_SurvivalMode.IsEnabled() && g_SurvivalMode.MapSupportEnabled());
}
Object@ Func_Map(Objects@ parameters)
{
	return @Object(g_Engine.mapname);
}
Object@ Func_StartsWith(Objects@ parameters)
{
	if(parameters.Count < 2)
	{
		return Object_Bool(false);
	}

	string first = parameters[0].ToString();
	string last = parameters[1].ToString();
	return Object_Bool(first.StartsWith(last));
}
Object@ Func_EndsWith(Objects@ parameters)
{
	if(parameters.Count < 2)
	{
		return Object_Bool(false);
	}
	string first = parameters[0].ToString();
	string last = parameters[1].ToString();
	return Object_Bool(first.EndsWith(last));
}
/*void PrintLine(string str)
{
	g_EngineFuncs.ServerPrint("\r\n" + str + "\r\n");
}*/