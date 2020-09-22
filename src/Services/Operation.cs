using NLog;
using NWN.API;
using NWN.API.Events;
using NWN.Services;

namespace Bloodstone {
    private static readonly Logger Log = LogManager.GetCurrentClassLogger();

    // [ServiceBinding] indicates that this class will be created during server startup.
    [ServiceBinding(typeof(Operation))]
    public class Operation {
        private static readonly Logger Log = LogManager.GetCurrentClassLogger();

        public Operation(EventService eventService) {
            eventService.Subscribe<NwModule, ModuleEvents.OnModuleLoad>(NwModule.Instance, OnModuleLoad);
        }

        private void OnModuleLoad(ModuleEvents.OnModuleLoad onModuleLoad) {
            NWNX.API.Administration.DMPassword = "thing";
            Log.Warn("module loaded");
        }
    }
}
