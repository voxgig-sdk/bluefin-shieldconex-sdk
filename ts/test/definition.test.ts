import { describe, test } from 'node:test'
import { SDK } from '..'
import { runDefinitionPoint } from './definition-runner'
import { isControlSkipped } from './utility'


// Generated from the API definition, not from the model this SDK was built
// from: the route, the declared query parameters, the credential the security
// scheme names, and the definition's own response example.
const PLAN: any[] = [
  {
    "entity": "detokenize",
    "accessor": "Detokenize",
    "op": "list",
    "method": "GET",
    "path": "/healthcheck/detokenize",
    "args": [],
    "select": {
      "bfid": "v1",
      "field_name": "v1",
      "field_value": "v1",
      "reference": "v1"
    },
    "headers": [],
    "cookies": [],
    "responseMedia": [
      "application/json"
    ],
    "query": [
      "bfid",
      "reference",
      "fieldNames",
      "fieldValues"
    ],
    "queryArgs": [
      {
        "name": "bfid",
        "wire": "bfid"
      },
      {
        "name": "field_name",
        "wire": "fieldNames"
      },
      {
        "name": "field_value",
        "wire": "fieldValues"
      },
      {
        "name": "reference",
        "wire": "reference"
      }
    ],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "basic"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "messageId": "x",
      "bfid": "x",
      "values": [
        {
          "name": "x",
          "value": "x"
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "tokenize",
    "accessor": "Tokenize",
    "op": "list",
    "method": "GET",
    "path": "/healthcheck/tokenize",
    "args": [],
    "select": {
      "template_ref": "v1",
      "field_name": "v1",
      "field_value": "v1",
      "reference": "v1"
    },
    "headers": [],
    "cookies": [],
    "responseMedia": [
      "application/json"
    ],
    "query": [
      "templateRef",
      "reference",
      "fieldNames",
      "fieldValues"
    ],
    "queryArgs": [
      {
        "name": "field_name",
        "wire": "fieldNames"
      },
      {
        "name": "field_value",
        "wire": "fieldValues"
      },
      {
        "name": "reference",
        "wire": "reference"
      },
      {
        "name": "template_ref",
        "wire": "templateRef"
      }
    ],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "basic"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "messageId": "x",
      "bfid": "x",
      "values": [
        {
          "name": "x",
          "value": "x"
        }
      ]
    },
    "idField": "id"
  },
  {
    "entity": "tokenize_read",
    "accessor": "TokenizeRead",
    "op": "create",
    "method": "POST",
    "path": "/tokenization/read",
    "args": [],
    "select": {},
    "headers": [],
    "cookies": [],
    "responseMedia": [
      "application/json"
    ],
    "query": [],
    "queryArgs": [],
    "auth": [
      [
        {
          "in": "header",
          "name": "authorization",
          "scheme": "basic"
        }
      ]
    ],
    "status": 200,
    "sample": {
      "messageId": "x",
      "bfid": "x",
      "values": [
        {
          "name": "x",
          "value": "x"
        }
      ],
      "state": {
        "threeDs": {
          "acsTransId": "x",
          "dsTransId": "x",
          "authenticationType": "x",
          "authenticationValue": "x",
          "eci": "x",
          "status": "x",
          "protocolVersion": "x",
          "scaIndicator": "x"
        }
      }
    },
    "idField": "id"
  }
]


describe('definition', () => {
  for (const point of PLAN) {
    test(point.entity + '.' + point.op + ' ' + point.method + ' ' + point.path, async (t) => {
      const control = isControlSkipped('entityOp', point.entity + '.' + point.op, 'definition')
      if (control.skip) {
        t.skip(control.reason || 'skipped via sdk-test-control.json')
        return
      }
      await runDefinitionPoint(SDK, point)
    })
  }
})
