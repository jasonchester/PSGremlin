using System.Collections.Generic;
using System.Diagnostics;
using System.Management.Automation;
using System.Threading.Tasks;
using Gremlin.Net.Driver;
using Gremlin.Net.Structure.IO.GraphSON;

namespace PSGremlin
{
    [Cmdlet(VerbsLifecycle.Invoke, "Gremlin")]
    public class InvokeGremlin : PSCmdlet
    {
        [Parameter(Mandatory=true)]
        public string Hostname { get; set; }

        [Parameter]
        public int Port { get; set; } = 443;

        [Parameter]
        public bool EnableSsl { get; set; } = true;

        [Parameter]
        public SwitchParameter Cosmos {get; set; }

        [Parameter]        
        public PSCredential Credential { get; set; }
        // This method will be called once at the end of pipeline execution; if no input is received, this method is not called

        [Parameter(Mandatory=true, ValueFromPipeline=true)]
        public string Query;

        private GremlinClient Client;

        protected override void BeginProcessing()
        {
            WriteVerbose("Connecting GremlinClient");

            var server = new GremlinServer(Hostname, Port, EnableSsl, Credential?.UserName, Credential?.GetNetworkCredential().Password);
            if(Cosmos)
            {
                Client = new GremlinClient(server, new GraphSON2Reader(), new GraphSON2Writer(), GremlinClient.GraphSON2MimeType);
            }
            else 
            {
                Client = new GremlinClient(server);
            }
        }

        protected override void ProcessRecord()
        {
            var sw = new Stopwatch();
            WriteVerbose($"Executing GremlinQuery {Query}");
            sw.Start();
            var output = ExecuteQuery<dynamic>(Query).Result;
            sw.Stop();
            WriteVerbose($"Query Complete. {sw.Elapsed}");
            WriteObject(output, true);
        }

        protected override void EndProcessing()
        {
            WriteVerbose("Disconnecting GremlinClient");            
            Client.Dispose();
        }

        protected async Task<IReadOnlyCollection<T>> ExecuteQuery<T>(string query) => await Client.SubmitAsync<T>(query);
    }
}
