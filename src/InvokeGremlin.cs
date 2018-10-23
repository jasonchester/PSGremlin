using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Management.Automation;
using System.Threading.Tasks;
using Gremlin.Net.Driver;
using Gremlin.Net.Structure.IO.GraphSON;
using Newtonsoft.Json.Linq;

namespace PSGremlin
{
    [Cmdlet(VerbsLifecycle.Invoke, "Gremlin")]
    public class InvokeGremlin : PSCmdlet
    {
        [Parameter(Mandatory = true)]
        public string Hostname { get; set; }

        [Parameter]
        public int Port { get; set; } = 443;

        [Parameter]
        public SwitchParameter EnableSsl { get; set; } = true;

        [Parameter(Mandatory = true)]
        public PSCredential Credential { get; set; }
        // This method will be called once at the end of pipeline execution; if no input is received, this method is not called

        [Parameter(Mandatory = true, ValueFromPipeline = true)]
        public string Query;

        private GremlinClient Client;

        protected override void BeginProcessing()
        {
            WriteVerbose("Connecting GremlinClient");

            var server = new GremlinServer(Hostname, Port, EnableSsl, Credential.UserName, Credential.GetNetworkCredential().Password);

            Client = new GremlinClient(server, new GraphSON2Reader(), new GraphSON2Writer(), GremlinClient.GraphSON2MimeType);
        }

        protected override void ProcessRecord()
        {
            var sw = new Stopwatch();
            WriteVerbose($"Executing GremlinQuery {Query}");
            sw.Start();
            var results = ExecuteQuery<dynamic>(Query).Result;
            sw.Stop();
            WriteVerbose($"Query Complete. {sw.Elapsed}");

            foreach (var result in results)
            {
                PSObject output;

                // for my own reference
                // https://docs.microsoft.com/en-us/dotnet/csharp/pattern-matching#using-pattern-matching-switch-statements
                switch (result)
                {
                    // case Dictionary<string, object> resultDict:
                    //     WriteVerbose($"Processing type case 1: {result.GetType()}");

                    //     output = new PSObject();

                    //     output.Properties.Add(new PSNoteProperty("id", resultDict["id"]));
                    //     output.Properties.Add(new PSNoteProperty("type", resultDict["type"]));
                    //     output.Properties.Add(new PSNoteProperty("label", resultDict["label"]));

                    //     var properties = resultDict["properties"] as Dictionary<string,object>;
                    //     if(null != properties)
                    //     foreach(var name in properties.Keys)
                    //     {
                    //         output.Properties.Add(new PSNoteProperty(name, properties[name]));
                    //     }
                    //     break;

                    default:
                        WriteVerbose($"Processing default case: {result.GetType()}");

                        output = new PSObject(result);
                        break;
                }

                WriteObject(output, true);
            }
        }

        protected override void EndProcessing()
        {
            WriteVerbose("Disconnecting GremlinClient");
            Client.Dispose();
        }

        protected async Task<IReadOnlyCollection<T>> ExecuteQuery<T>(string query) => await Client.SubmitAsync<T>(query);
    }
}
