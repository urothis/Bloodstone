using System;
using NWN.API;
using NWN.API.Events;
using NWN.Services;

namespace Bloodstone {
    // [ServiceBinding] indicates that this class will be created during server startup.
    [ServiceBinding(typeof(Debug))]
    public class Debug {
        // Called at startup. NWN.Managed resolves EventService for us.
        public Debug(EventService eventService) {
            // Subscribe to the OnClientEnter event, and call our OnClientEnter function when someone connects.
            eventService.Subscribe<NwModule, ModuleEvents.OnModuleLoad>(NwModule.Instance, OnModuleLoad);
        }

        private void OnModuleLoad(ModuleEvents.OnModuleLoad onModuleLoad) {
            Console.WriteLine("module loaded");
        }
    }
}
