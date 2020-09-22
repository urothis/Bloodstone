using System;
using NLog;
using NWN.API;
using NWN.API.Events;
using NWN.Services;

namespace Bloodstone {
    

    // [ServiceBinding] indicates that this class will be created during server startup.
    [ServiceBinding(typeof(Tracking))]
    public class Tracking {
        private static readonly Logger Log = LogManager.GetCurrentClassLogger();
        public Tracking(EventService eventService) {
            eventService.Subscribe<NwModule, ModuleEvents.OnClientEnter>(NwModule.Instance, OnClientEnter);
            eventService.Subscribe<NwModule, ModuleEvents.OnPlayerLevelUp>(NwModule.Instance, OnPlayerLevelUp);
            eventService.Subscribe<NwModule, ModuleEvents.OnPlayerRespawn>(NwModule.Instance, OnPlayerRespawn);
            eventService.Subscribe<NwModule, ModuleEvents.OnPlayerRest>(NwModule.Instance, OnPlayerRest);
            eventService.Subscribe<NwModule, ModuleEvents.OnClientLeave>(NwModule.Instance, OnClientLeave);
            eventService.Subscribe<NwModule, ModuleEvents.OnPlayerDying>(NwModule.Instance, OnPlayerDying);
            /*
            eventService.Subscribe<NwModule, ModuleEvents.OnAcquireItem>(NwModule.Instance, OnPlayerDying);
            eventService.Subscribe<NwModule, ModuleEvents.OnUnacquireItem>(NwModule.Instance, OnPlayerDying);
            eventService.Subscribe<NwModule, ModuleEvents.OnPlayerDeath>(NwModule.Instance, OnPlayerDying);
            eventService.Subscribe<NwModule, ModuleEvents.OnActivateItem>(NwModule.Instance, OnPlayerDying);
            */
        }

        private void OnClientEnter(ModuleEvents.OnClientEnter onClientEnter) {
            Console.WriteLine(onClientEnter.Player.Name);
        }

        private void OnPlayerLevelUp(ModuleEvents.OnPlayerLevelUp onPlayerLevelUp) {
            Console.WriteLine(onPlayerLevelUp.Player.Name);
        }

        private void OnPlayerRespawn(ModuleEvents.OnPlayerRespawn onPlayerRespawn) {
            Console.WriteLine(onPlayerRespawn.Player.Name);
        }

        private void OnPlayerRest(ModuleEvents.OnPlayerRest onPlayerRest) {
            Console.WriteLine(onPlayerRest.Player.Name);
        }

        private void OnClientLeave(ModuleEvents.OnClientLeave onClientLeave) {
            Console.WriteLine(onClientLeave.Player.Name);
        }

        private void OnPlayerDying(ModuleEvents.OnPlayerDying onPlayerDying) {
            Console.WriteLine(onPlayerDying.Player.Name);
        }
    }
}
