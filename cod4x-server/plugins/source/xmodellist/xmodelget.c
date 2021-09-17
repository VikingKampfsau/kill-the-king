//#include "../../src/xassets.h"
#include "../pinc.h"

#define ARRAY_COUNT(array) (sizeof((array))/sizeof((array)[0]))

extern uint16_t db_hashTable[32768];

enum XAssetType
{
  ASSET_TYPE_XMODELPIECES,
  ASSET_TYPE_PHYSPRESET,
  ASSET_TYPE_XANIMPARTS,
  ASSET_TYPE_XMODEL,
  ASSET_TYPE_MATERIAL,
  ASSET_TYPE_TECHNIQUE_SET,
  ASSET_TYPE_IMAGE,
  ASSET_TYPE_SOUND,
  ASSET_TYPE_SOUND_CURVE,
  ASSET_TYPE_LOADED_SOUND,
  ASSET_TYPE_CLIPMAP,
  ASSET_TYPE_CLIPMAP_PVS,
  ASSET_TYPE_COMWORLD,
  ASSET_TYPE_GAMEWORLD_SP,
  ASSET_TYPE_GAMEWORLD_MP,
  ASSET_TYPE_MAP_ENTS,
  ASSET_TYPE_GFXWORLD,
  ASSET_TYPE_LIGHT_DEF,
  ASSET_TYPE_UI_MAP,
  ASSET_TYPE_FONT,
  ASSET_TYPE_MENULIST,
  ASSET_TYPE_MENU,
  ASSET_TYPE_LOCALIZE_ENTRY,
  ASSET_TYPE_WEAPON,
  ASSET_TYPE_SNDDRIVER_GLOBALS,
  ASSET_TYPE_FX,
  ASSET_TYPE_IMPACT_FX,
  ASSET_TYPE_AITYPE,
  ASSET_TYPE_MPTYPE,
  ASSET_TYPE_CHARACTER,
  ASSET_TYPE_XMODELALIAS,
  ASSET_TYPE_RAWFILE,
  ASSET_TYPE_STRINGTABLE,
  ASSET_TYPE_COUNT
};

union XAssetHeader
{
  struct XModelPieces *xmodelPieces;
  struct PhysPreset *physPreset;
  struct XAnimParts *parts;
  struct XModel *model;
  struct Material *material;
  struct MaterialPixelShader *pixelShader;
  struct MaterialVertexShader *vertexShader;
  struct MaterialTechniqueSet *techniqueSet;
  struct GfxImage *image;
  struct snd_alias_list_t *sound;
  struct SndCurve *sndCurve;
  struct LoadedSound_s* loadedsound;
  struct clipMap_s *clipMap;
  struct ComWorld *comWorld;
  struct GameWorldSp *gameWorldSp;
  struct GameWorldMp *gameWorldMp;
  struct MapEnts *mapEnts;
  struct GfxWorld *gfxWorld;
  struct GfxLightDef *lightDef;
  struct Font_s *font;
  struct MenuList *menuList;
  struct menuDef_t *menu;
  struct LocalizeEntry *localize;
  struct WeaponDef *weapon;
  struct SndDriverGlobals *sndDriverGlobals;
  struct FxEffectDef *fx;
  struct FxImpactTable *impactFx;
  struct RawFile *rawfile;
  struct StringTable *stringTable;
  void *data;
};

struct XAsset
{
  enum XAssetType type;
  union XAssetHeader header;
};

struct XAssetEntry
{
  struct XAsset asset;
  byte zoneIndex;
  bool inuse;
  uint16_t nextHash;
  uint16_t nextOverride;
  uint16_t usageFrame;
};

union XAssetEntryPoolEntry
{
  struct XAssetEntry entry;
  union XAssetEntryPoolEntry *next;
};

extern union XAssetEntryPoolEntry *g_freeAssetEntryHead;
extern union XAssetEntryPoolEntry g_assetEntryPool[32768];

extern const char* DB_GetXAssetName(struct XAsset *asset);

void printXmodels()
{
    int index, sindex;
    unsigned int i;
    union XAssetEntryPoolEntry *listselector, *slistselect;
    enum XAssetType type;
    char sbuf[256];

    Plugin_Cvar_VariableStringBuffer("fs_game", sbuf, sizeof(sbuf));

    strcat(sbuf, "/xmodellist.txt");

    FILE *f = fopen(sbuf, "w");
    if (f == NULL)
    {
        Plugin_Printf("Could not open file\n");
        return;
    }

    for(i = 0; i < ARRAY_COUNT(db_hashTable); ++i)
    {
        for(index = db_hashTable[i]; index; index = listselector->entry.nextHash)
        {
            listselector = &g_assetEntryPool[index];

            if(listselector->entry.asset.type != ASSET_TYPE_XMODEL)
                continue;

            fprintf(f, "%s\n", DB_GetXAssetName(&listselector->entry.asset));
        }
    }

    fclose(f);
}

PCL int OnInit()
{
    Plugin_ScrAddFunction("getXmodels", &printXmodels);
    return 0;
}

PCL void OnInfoRequest(pluginInfo_t *info)
{
        // =====  MANDATORY FIELDS  =====
    info->handlerVersion.major = PLUGIN_HANDLER_VERSION_MAJOR;
    info->handlerVersion.minor = PLUGIN_HANDLER_VERSION_MINOR;    // Requested handler version

    // =====  OPTIONAL  FIELDS  =====
    info->pluginVersion.major = 1;
    info->pluginVersion.minor = 0;    // Plugin version
    strncpy(info->fullName,"Xmodel list", sizeof(info->fullName)); //Full plugin name
    strncpy(info->shortDescription,"Get a list of all xmodels",sizeof(info->shortDescription)); // Short plugin description
    strncpy(info->longDescription, "Get a list of all xmodels", sizeof(info->longDescription));
}



