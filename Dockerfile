# build the module file
FROM nwntools/nasher:latest AS moduleBuild
ADD . /src/moduleBuild/
WORKDIR /src/moduleBuild
RUN nasher pack

# Pull Dotnet image to build the project
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
RUN apt-get update && apt-get clean && rm -rf /var/lib/apt/lists/*
ADD ./src /Build
WORKDIR /Build
RUN dotnet publish -c Release

# Build the final NWN server image (Version: 8193.16 Date: 10/1)
FROM index.docker.io/nwnxee/unified:c7392de
LABEL maintainer="urothis"
RUN apt-get update && apt-get clean && rm -rf /var/lib/apt/lists/*
# copy our module over
COPY --from=moduleBuild /src/moduleBuild/Bloodstone.mod /nwn/data/data/mod
# install our services
COPY --from=build /Build/bin/Release/Plugins/Bloodstone/ /nwn/Dotnet/Plugins
# install the unzip package so we can grab the latest managed binaries
RUN apt update && apt upgrade -y && apt install unzip libc6-dev libgdiplus -y
RUN cd /nwn/Dotnet && wget "https://github.com/nwn-dotnet/NWN.Managed/releases/download/v8193.16.1/NWN.Managed.zip" -O temp.zip && unzip temp.zip && rm temp.zip
ENV NWN_SERVERNAME=Bloodstone \
    NWN_MODULE=Bloodstone \
    NWN_PUBLICSERVER=0 \
    NWN_AUTOSAVEINTERVAL=0 \
    NWN_DIFFICULTY=3 \
    NWN_ELC=1 \
    NWN_GAMETYPE=0 \
    NWN_ILR=1 \
    NWN_MAXCLIENTS=255 \
    NWN_MINLEVEL=1 \
    NWN_MAXLEVEL=40 \
    NWN_ONEPARTY=0 \
    NWN_PAUSEANDPLAY=0 \
    NWN_PORT=5121 \
    NWN_PVP=2 \
    NWN_RELOADWHENEMPTY=0 \
    NWN_SERVERVAULT=1 \
    NWN_DMPASSWORD=test \
    # managed required
    NWNX_DOTNET_ASSEMBLY=/nwn/Dotnet/NWN.Managed \
    NWM_NLOG_CONFIG=/nwn/home/nlog.config \
    # nwnx env
    NWNX_ADMINISTRATION_SKIP=n \
    NWNX_APPEARANCE_SKIP=n \
    NWNX_AREA_SKIP=n \
    NWNX_CHAT_SKIP=n \
    NWNX_CREATURE_SKIP=n \
    NWNX_DAMAGE_SKIP=n \
    NWNX_DIALOG_SKIP=n \
    NWNX_DOTNET_SKIP=n \
    NWNX_ELC_SKIP=n \
    NWNX_ENCOUNTER_SKIP=n \
    NWNX_EVENTS_SKIP=n \
    NWNX_FEEDBACK_SKIP=n \
    NWNX_ITEM_SKIP=n \
    NWNX_ITEMPROPERTY_SKIP=n \
    NWNX_OBJECT_SKIP=n \
    NWNX_PLAYER_SKIP=n \
    NWNX_QUICKBARSLOT_SKIP=n \
    NWNX_RACE_SKIP=n \
    NWNX_RENAME_SKIP=n \
    NWNX_REVEAL_SKIP=n \
    NWNX_SKILLRANKS_SKIP=n \
    NWNX_UTIL_SKIP=n \
    NWNX_VISIBILITY_SKIP=n \
    NWNX_WEAPON_SKIP=n \
    NWNX_COMBATMODES_SKIP=n \
    NWNX_TWEAKS_SKIP=n \
    NWNX_TWEAKS_DISABLE_PAUSE=true \
    NWNX_TWEAKS_DISABLE_QUICKSAVE=true \
    NWNX_TWEAKS_PARRY_ALL_ATTACKS=true \
    NWNX_TWEAKS_FIX_GREATER_SANCTUARY_BUG=true \
    NWNX_TWEAKS_HIDE_CLASSES_ON_CHAR_LIST=true \
    NWNX_TWEAKS_PRESERVE_ACTIONS_ON_DM_POSSESS=true \
    NWNX_TWEAKS_DISABLE_MONK_ABILITIES_WHEN_POLYMORPHED=true \
    NWNX_TWEAKS_FIX_UNLIMITED_POTIONS_BUG=true \
    NWNX_TWEAKS_BLOCK_DM_SPAWNITEM=true
