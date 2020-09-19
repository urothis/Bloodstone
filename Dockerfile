# Build the managed plugins
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
ADD ./src/Services/ /Build
WORKDIR /Build
#bloodstone services
# debug first
RUN cd Bloodstone/Debug && dotnet build -c Release
#
#
#
#

# Build the final NWN server image (Version: 8193.14)
FROM nwnxee/unified:17d1479
LABEL maintainer "urothis@gmail.com"
# install our plugins
# bloodstone
# debug
COPY --from=build /Build/Bloodstone/Debug/bin/Release/Plugins/ /nwn/Dotnet/Plugins
#
#
#
#

# install the unzip package so we can grab the latest managed binaries
RUN apt update && apt upgrade -y && apt install unzip
RUN cd /nwn/Dotnet && wget "https://github.com/nwn-dotnet/NWN.Managed/releases/download/v8193.14.23/NWN.Managed.zip" -O temp.zip && unzip temp.zip && rm temp.zip && ls ./Plugins/debug