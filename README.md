# PSGremlin
Powershell wrapper for executing gremlin queries using ![Gremlin.Net](http://tinkerpop.apache.org/docs/current/reference/#gremlin-DotNet)

![PSGremlin Logo](https://github.com/jasonchester/PSGremlin/blob/master/docs/psgremlin-logo.png "PSGremloin Logo")

## Using PSGremlin to connect to Cosmos DB
Sample adapted from https://github.com/Azure-Samples/azure-cosmos-db-graph-gremlindotnet-getting-started
```powershell
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
```

Output
```
WARNING: Executing Cleanup
WARNING: Executing AddVertex1
{
  "id": "thomas",
  "label": "person",
  "type": "vertex",
  "properties": {
    "firstName": [
      {
        "id": "7e0eb8dc-1cb3-4546-b305-b8d0ac1f7578",
        "value": "Thomas"
      }
    ],
    "age": [
      {
        "id": "f5cc0b22-064f-4be5-844e-a0c2f67e808f",
        "value": 44
      }
    ]
  }
}
WARNING: Executing AddVertex2
{
  "id": "mary",
  "label": "person",
  "type": "vertex",
  "properties": {
    "firstName": [
      {
        "id": "334d5421-5584-48e1-aff2-aea6fbb76713",
        "value": "Mary"
      }
    ],
    "lastName": [
      {
        "id": "75b3f500-f10b-4105-acda-89582db1cb67",
        "value": "Andersen"
      }
    ],
    "age": [
      {
        "id": "fc5634f8-0558-4a27-a908-dc1f54bdfc50",
        "value": 39
      }
    ]
  }
}
WARNING: Executing AddVertex3
{
  "id": "ben",
  "label": "person",
  "type": "vertex",
  "properties": {
    "firstName": [
      {
        "id": "f305f929-424b-4c1e-941b-2cc1397804b9",
        "value": "Ben"
      }
    ],
    "lastName": [
      {
        "id": "47f5ed53-d048-456c-9cf5-dcbd8a839ad0",
        "value": "Miller"
      }
    ]
  }
}
WARNING: Executing AddVertex4
{
  "id": "robin",
  "label": "person",
  "type": "vertex",
  "properties": {
    "firstName": [
      {
        "id": "c483ba3b-88d3-49b5-8224-fa06b82fac6e",
        "value": "Robin"
      }
    ],
    "lastName": [
      {
        "id": "61173e84-0b5c-45a4-b263-508296d387c2",
        "value": "Wakefield"
      }
    ]
  }
}
WARNING: Executing AddEdge1
{
  "id": "d41cf40a-fb2e-4b5e-bbde-768dd2292cfc",
  "label": "knows",
  "type": "edge",
  "inVLabel": "person",
  "outVLabel": "person",
  "inV": "mary",
  "outV": "thomas"
}
WARNING: Executing AddEdge2
{
  "id": "be6e9971-9cdf-4825-8875-a30d6c4e70d2",
  "label": "knows",
  "type": "edge",
  "inVLabel": "person",
  "outVLabel": "person",
  "inV": "ben",
  "outV": "thomas"
}
WARNING: Executing AddEdge3
{
  "id": "df4a02a9-b8fb-4bf3-ab75-94862da06f97",
  "label": "knows",
  "type": "edge",
  "inVLabel": "person",
  "outVLabel": "person",
  "inV": "robin",
  "outV": "ben"
}
WARNING: Executing UpdateVertex
{
  "id": "thomas",
  "label": "person",
  "type": "vertex",
  "properties": {
    "firstName": [
      {
        "id": "7e0eb8dc-1cb3-4546-b305-b8d0ac1f7578",
        "value": "Thomas"
      }
    ],
    "age": [
      {
        "id": "985e2d02-85f3-4a71-bf6d-c472d6226dca",
        "value": 44
      }
    ]
  }
}
WARNING: Executing CountVertices
4
WARNING: Executing FilterRange
{
  "id": "thomas",
  "label": "person",
  "type": "vertex",
  "properties": {
    "firstName": [
      {
        "id": "7e0eb8dc-1cb3-4546-b305-b8d0ac1f7578",
        "value": "Thomas"
      }
    ],
    "age": [
      {
        "id": "985e2d02-85f3-4a71-bf6d-c472d6226dca",
        "value": 44
      }
    ]
  }
}
WARNING: Executing Project
[
  "Thomas",
  "Mary",
  "Ben",
  "Robin"
]
WARNING: Executing Sort
[
  {
    "id": "thomas",
    "label": "person",
    "type": "vertex",
    "properties": {
      "firstName": [
        {
          "id": "7e0eb8dc-1cb3-4546-b305-b8d0ac1f7578",
          "value": "Thomas"
        }
      ],
      "age": [
        {
          "id": "985e2d02-85f3-4a71-bf6d-c472d6226dca",
          "value": 44
        }
      ]
    }
  },
  {
    "id": "robin",
    "label": "person",
    "type": "vertex",
    "properties": {
      "firstName": [
        {
          "id": "c483ba3b-88d3-49b5-8224-fa06b82fac6e",
          "value": "Robin"
        }
      ],
      "lastName": [
        {
          "id": "61173e84-0b5c-45a4-b263-508296d387c2",
          "value": "Wakefield"
        }
      ]
    }
  },
  {
    "id": "mary",
    "label": "person",
    "type": "vertex",
    "properties": {
      "firstName": [
        {
          "id": "334d5421-5584-48e1-aff2-aea6fbb76713",
          "value": "Mary"
        }
      ],
      "lastName": [
        {
          "id": "75b3f500-f10b-4105-acda-89582db1cb67",
          "value": "Andersen"
        }
      ],
      "age": [
        {
          "id": "fc5634f8-0558-4a27-a908-dc1f54bdfc50",
          "value": 39
        }
      ]
    }
  },
  {
    "id": "ben",
    "label": "person",
    "type": "vertex",
    "properties": {
      "firstName": [
        {
          "id": "f305f929-424b-4c1e-941b-2cc1397804b9",
          "value": "Ben"
        }
      ],
      "lastName": [
        {
          "id": "47f5ed53-d048-456c-9cf5-dcbd8a839ad0",
          "value": "Miller"
        }
      ]
    }
  }
]
WARNING: Executing Traverse
[
  {
    "id": "mary",
    "label": "person",
    "type": "vertex",
    "properties": {
      "firstName": [
        {
          "id": "334d5421-5584-48e1-aff2-aea6fbb76713",
          "value": "Mary"
        }
      ],
      "lastName": [
        {
          "id": "75b3f500-f10b-4105-acda-89582db1cb67",
          "value": "Andersen"
        }
      ],
      "age": [
        {
          "id": "fc5634f8-0558-4a27-a908-dc1f54bdfc50",
          "value": 39
        }
      ]
    }
  },
  {
    "id": "ben",
    "label": "person",
    "type": "vertex",
    "properties": {
      "firstName": [
        {
          "id": "f305f929-424b-4c1e-941b-2cc1397804b9",
          "value": "Ben"
        }
      ],
      "lastName": [
        {
          "id": "47f5ed53-d048-456c-9cf5-dcbd8a839ad0",
          "value": "Miller"
        }
      ]
    }
  }
]
WARNING: Executing Traverse2x
{
  "id": "robin",
  "label": "person",
  "type": "vertex",
  "properties": {
    "firstName": [
      {
        "id": "c483ba3b-88d3-49b5-8224-fa06b82fac6e",
        "value": "Robin"
      }
    ],
    "lastName": [
      {
        "id": "61173e84-0b5c-45a4-b263-508296d387c2",
        "value": "Wakefield"
      }
    ]
  }
}
WARNING: Executing Loop
{
  "labels": [
    [],
    [],
    []
  ],
  "objects": [
    {
      "id": "thomas",
      "label": "person",
      "type": "vertex",
      "properties": {
        "firstName": [
          {
            "id": "7e0eb8dc-1cb3-4546-b305-b8d0ac1f7578",
            "value": "Thomas"
          }
        ],
        "age": [
          {
            "id": "985e2d02-85f3-4a71-bf6d-c472d6226dca",
            "value": 44
          }
        ]
      }
    },
    {
      "id": "ben",
      "label": "person",
      "type": "vertex",
      "properties": {
        "firstName": [
          {
            "id": "f305f929-424b-4c1e-941b-2cc1397804b9",
            "value": "Ben"
          }
        ],
        "lastName": [
          {
            "id": "47f5ed53-d048-456c-9cf5-dcbd8a839ad0",
            "value": "Miller"
          }
        ]
      }
    },
    {
      "id": "robin",
      "label": "person",
      "type": "vertex",
      "properties": {
        "firstName": [
          {
            "id": "c483ba3b-88d3-49b5-8224-fa06b82fac6e",
            "value": "Robin"
          }
        ],
        "lastName": [
          {
            "id": "61173e84-0b5c-45a4-b263-508296d387c2",
            "value": "Wakefield"
          }
        ]
      }
    }
  ]
}
WARNING: Executing DropEdge
WARNING: Executing CountEdges
2
WARNING: Executing DropVertex
```