#pragma semicolon 1
#pragma newdecls required

#include <smutils>
#include <kcf_core>
#include <kcf_bans>

public Plugin myinfo = 
{
    name        = "Kxnrl Community Framework - Bans Invoker [SourceBans API]",
    author      = "Kyle",
    description = "Invoker of Sourcebans and sourcebans",
    version     = PI_VERSION,
    url         = "https://kxnrl.com"
};

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
    RegPluginLibrary("sourcebans");

    CreateNative("SBBanPlayer", Native_SBBanPlayer);
    CreateNative("SBAddBan",    Native_SBAddBan);

    return APLRes_Success;
}

public int Native_SBBanPlayer(Handle plugin, int numParams)
{
    int admin  = GetNativeCell(1);
    int target = GetNativeCell(2);
    int length = GetNativeCell(3);
    char reason[128];
    GetNativeString(4, reason, 128);

    KCF_Bans_BanClient(admin, target, 0, length, reason);
}

public int Native_SBAddBan(Handle plugin, int numParams)
{
    int client = GetNativeCell(1);
    int length = GetNativeCell(2);

    char auth[32], nick[64], reason[128];
    GetNativeString(3, auth,    32);
    GetNativeString(4, nick,    32);
    GetNativeString(5, reason, 128);

    return KCF_Bans_BanIdentity(client, auth, 0, length, reason);
}
