# sample adapted from https://github.com/Azure-Samples/azure-cosmos-db-graph-gremlindotnet-getting-started

# replace variables with values of your own
$hostname = "your-endpoint.gremlin.cosmosdb.azure.com"
$authKey = ConvertTo-SecureString -AsPlainText -Force -String 'your-key'
$database = "your-database"
$collection = "your-collection-or-graph"

$gremlinParams = @{
    Hostname = $hostname
    Credential = New-Object System.Management.Automation.PSCredential "/dbs/$database/colls/$collection", $authKey
}

$queries = [ordered]@{
    Cleanup       = "g.V().drop()"
    AddVertex1    = "g.addV('person').property('id', 'thomas').property('firstName', 'Thomas').property('age', 44)"
    AddVertex2    = "g.addV('person').property('id', 'mary').property('firstName', 'Mary').property('lastName', 'Andersen').property('age', 39)"
    AddVertex3    = "g.addV('person').property('id', 'ben').property('firstName', 'Ben').property('lastName', 'Miller')"
    AddVertex4    = "g.addV('person').property('id', 'robin').property('firstName', 'Robin').property('lastName', 'Wakefield')"
    AddEdge1      = "g.V('thomas').addE('knows').to(g.V('mary'))"
    AddEdge2      = "g.V('thomas').addE('knows').to(g.V('ben'))"
    AddEdge3      = "g.V('ben').addE('knows').to(g.V('robin'))"
    UpdateVertex  = "g.V('thomas').property('age', 44)"
    CountVertices = "g.V().count()"
    FilterRange   = "g.V().hasLabel('person').has('age', gt(40))"
    Project       = "g.V().hasLabel('person').values('firstName')"
    Sort          = "g.V().hasLabel('person').order().by('firstName', decr)"
    Traverse      = "g.V('thomas').out('knows').hasLabel('person')"
    Traverse2x    = "g.V('thomas').out('knows').hasLabel('person').out('knows').hasLabel('person')"
    Loop          = "g.V('thomas').repeat(out()).until(has('id', 'robin')).path()"
    DropEdge      = "g.V('thomas').outE('knows').where(inV().has('id', 'mary')).drop()"
    CountEdges    = "g.E().count()"
    DropVertex    = "g.V('thomas').drop()"
}

$queries.Keys | ForEach-Object { 
    Write-Warning -Message "Executing $_"
    $queries[$_] | Invoke-Gremlin @gremlinParams | ConvertTo-Json -Depth 10
} 