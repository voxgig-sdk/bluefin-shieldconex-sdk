import 'feature/base/BaseFeature.dart';
import 'feature/audit/AuditFeature.dart';
import 'feature/clienttrack/ClienttrackFeature.dart';
import 'feature/idempotency/IdempotencyFeature.dart';
import 'feature/log/LogFeature.dart';
import 'feature/metrics/MetricsFeature.dart';
import 'feature/paging/PagingFeature.dart';
import 'feature/ratelimit/RatelimitFeature.dart';
import 'feature/retry/RetryFeature.dart';
import 'feature/telemetry/TelemetryFeature.dart';
import 'feature/test/TestFeature.dart';
import 'feature/timeout/TimeoutFeature.dart';


// ignore: non_constant_identifier_names
final Map<String, BaseFeature Function()> FEATURE_CLASS = {
    'audit': () => AuditFeature(),
  'clienttrack': () => ClienttrackFeature(),
  'idempotency': () => IdempotencyFeature(),
  'log': () => LogFeature(),
  'metrics': () => MetricsFeature(),
  'paging': () => PagingFeature(),
  'ratelimit': () => RatelimitFeature(),
  'retry': () => RetryFeature(),
  'telemetry': () => TelemetryFeature(),
  'test': () => TestFeature(),
  'timeout': () => TimeoutFeature(),

};

class Config {
  BaseFeature makeFeature(String fn) {
    final fc = FEATURE_CLASS[fn];
    if (null == fc) {
      // TODO: errors etc
      throw StateError('Unknown feature: ' + fn);
    }
    return fc();
  }

  // False for a feature added at runtime via options.extend (station's
  // adopt path) - the constructor uses this to skip makeFeature for names
  // no generated class backs.
  bool hasFeature(String fn) => null != FEATURE_CLASS[fn];

  final Map<String, dynamic> main = <String, dynamic>{
    'name': 'BluefinShieldconex',
        'slug': 'bluefin-shieldconex',
    'version': '0.1.1',
    'target': 'dart',

  };

  final Map<String, dynamic> feature = <String, dynamic>{
        'audit': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'actor': 'anonymous',
        'max': 1000,
      },
      'transport': 'none',
    },
    'clienttrack': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'clientVersion': '0.0.1',
      },
      'transport': 'none',
    },
    'idempotency': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'header': 'Idempotency-Key',
        'methods': <dynamic>[
          'POST',
          'PUT',
          'PATCH',
          'DELETE',
        ],
        'ops': <dynamic>[
          'create',
          'update',
          'remove',
        ],
      },
      'transport': 'none',
    },
    'log': <String, dynamic>{
      'options': <String, dynamic>{
        'active': true,
      },
      'transport': 'none',
    },
    'metrics': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
      },
      'transport': 'none',
    },
    'paging': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'afterVar': 'after',
        'cursorParam': 'cursor',
        'firstVar': 'first',
        'limitParam': 'limit',
        'pageParam': 'page',
        'startPage': 1,
      },
      'transport': 'none',
    },
    'ratelimit': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'burst': 5,
        'rate': 5,
      },
      'transport': 'wrap',
    },
    'retry': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'factor': 2,
        'maxDelay': 2000,
        'minDelay': 50,
        'retries': 2,
        'statuses': <dynamic>[
          408,
          425,
          429,
          500,
          502,
          503,
          504,
        ],
      },
      'transport': 'wrap',
    },
    'telemetry': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
      },
      'transport': 'none',
    },
    'test': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
      },
      'transport': 'base',
    },
    'timeout': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
        'ms': 30000,
      },
      'transport': 'wrap',
    },

  };

  // Rendered whole from the canonical config definition rather than assembled
  // slot by slot. Assembling it here meant `options.server` - the OpenAPI
  // server-variable defaults - was simply absent from this branch, so a
  // templated server URL produced a different config either side of the
  // threshold.
  final Map<String, dynamic> options = <String, dynamic>{
    'base': 'https://secure-cert.shieldconex.com/api',
    'auth': <String, dynamic>{
      'prefix': 'Basic',
      'basic': true,
    },
    'headers': <String, dynamic>{
      'content-type': 'application/json',
    },
    'entity': <String, dynamic>{
      'detokenize': <String, dynamic>{},
      'tokenize': <String, dynamic>{},
      'tokenize_batch': <String, dynamic>{},
      'tokenize_read': <String, dynamic>{},
      'validate': <String, dynamic>{},
    },
  };

  final Map<String, dynamic> entity = <String, dynamic>{
    'detokenize': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'batches',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$ARRAY`',
            },
          },
          'type': '`\$ARRAY`',
        },
        <String, dynamic>{
          'name': 'bfid',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$STRING`',
            },
          },
          'short': 'The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'messageId',
          'short': 'Message Id',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'name',
          'short': 'Field Name.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'reference',
          'short': 'Request Reference.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'value',
          'short': 'Field Value.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'values',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$ARRAY`',
            },
          },
          'type': '`\$ARRAY`',
        },
      ],
      'name': 'detokenize',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/tokenization/batch/detokenize',
              'parts': <dynamic>[
                'tokenization',
                'batch',
                'detokenize',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/tokenization/detokenize',
              'parts': <dynamic>[
                'tokenization',
                'detokenize',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
          ],
        },
        'list': <String, dynamic>{
          'input': 'data',
          'name': 'list',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{
                'query': <dynamic>[
                  <String, dynamic>{
                    'kind': 'query',
                    'name': 'bfid',
                    'orig': 'bfid',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'kind': 'query',
                    'name': 'field_name',
                    'orig': 'field_name',
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'kind': 'query',
                    'name': 'field_value',
                    'orig': 'field_value',
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'kind': 'query',
                    'name': 'reference',
                    'orig': 'reference',
                    'type': '`\$STRING`',
                  },
                ],
              },
              'kind': 'http',
              'method': 'GET',
              'orig': '/healthcheck/detokenize',
              'parts': <dynamic>[
                'healthcheck',
                'detokenize',
              ],
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'bfid',
                  'field_name',
                  'field_value',
                  'reference',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body.values`',
              },
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'tokenize': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'batches',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$ARRAY`',
            },
          },
          'type': '`\$ARRAY`',
        },
        <String, dynamic>{
          'name': 'bfid',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$STRING`',
            },
          },
          'short': 'The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'messageId',
          'short': 'Message Id',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'name',
          'short': 'Field Name.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'reference',
          'short': 'Request Reference.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'templateRef',
          'req': true,
          'short': 'Template Reference',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'value',
          'short': 'Field Value.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'values',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$ARRAY`',
            },
          },
          'type': '`\$ARRAY`',
        },
      ],
      'name': 'tokenize',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{
                'query': <dynamic>[
                  <String, dynamic>{
                    'kind': 'query',
                    'name': 'omit',
                    'orig': 'omit',
                    'type': '`\$NUMBER`',
                  },
                ],
              },
              'kind': 'http',
              'method': 'POST',
              'orig': '/tokenization/batch/tokenize',
              'parts': <dynamic>[
                'tokenization',
                'batch',
                'tokenize',
              ],
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'omit',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{
                'query': <dynamic>[
                  <String, dynamic>{
                    'kind': 'query',
                    'name': 'omit',
                    'orig': 'omit',
                    'type': '`\$NUMBER`',
                  },
                ],
              },
              'kind': 'http',
              'method': 'POST',
              'orig': '/tokenization/tokenize',
              'parts': <dynamic>[
                'tokenization',
                'tokenize',
              ],
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'omit',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/tokenization/delete',
              'parts': <dynamic>[
                'tokenization',
                'delete',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
          ],
        },
        'list': <String, dynamic>{
          'input': 'data',
          'name': 'list',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{
                'query': <dynamic>[
                  <String, dynamic>{
                    'kind': 'query',
                    'name': 'field_name',
                    'orig': 'field_name',
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'kind': 'query',
                    'name': 'field_value',
                    'orig': 'field_value',
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'kind': 'query',
                    'name': 'reference',
                    'orig': 'reference',
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'kind': 'query',
                    'name': 'template_ref',
                    'orig': 'template_ref',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                ],
              },
              'kind': 'http',
              'method': 'GET',
              'orig': '/healthcheck/tokenize',
              'parts': <dynamic>[
                'healthcheck',
                'tokenize',
              ],
              'select': <String, dynamic>{
                'exist': <dynamic>[
                  'field_name',
                  'field_value',
                  'reference',
                  'template_ref',
                ],
              },
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body.values`',
              },
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'tokenize_batch': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'batches',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$ARRAY`',
            },
          },
          'type': '`\$ARRAY`',
        },
        <String, dynamic>{
          'name': 'messageId',
          'short': 'Message Id',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'reference',
          'short': 'Request Reference.',
          'type': '`\$STRING`',
        },
      ],
      'name': 'tokenize_batch',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/tokenization/batch/delete',
              'parts': <dynamic>[
                'tokenization',
                'batch',
                'delete',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/tokenization/batch/read',
              'parts': <dynamic>[
                'tokenization',
                'batch',
                'read',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'tokenize_read': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'bfid',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$STRING`',
            },
          },
          'short': 'The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'messageId',
          'short': 'Message Id',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'reference',
          'short': 'Request Reference.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'state',
          'short': 'Tokenized State Data (if available)',
          'type': '`\$OBJECT`',
        },
        <String, dynamic>{
          'name': 'values',
          'type': '`\$ARRAY`',
        },
      ],
      'name': 'tokenize_read',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/tokenization/read',
              'parts': <dynamic>[
                'tokenization',
                'read',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'validate': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'name': 'messageId',
          'short': 'Message Id',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'reference',
          'short': 'Request Reference.',
          'type': '`\$STRING`',
        },
        <String, dynamic>{
          'name': 'templateRef',
          'req': true,
          'short': 'Template Reference.',
          'type': '`\$STRING`',
        },
      ],
      'name': 'validate',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/partner/validate',
              'parts': <dynamic>[
                'partner',
                'validate',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
            <String, dynamic>{
              'args': <String, dynamic>{},
              'kind': 'http',
              'method': 'POST',
              'orig': '/template/validate',
              'parts': <dynamic>[
                'template',
                'validate',
              ],
              'select': <String, dynamic>{},
              'transform': <String, dynamic>{
                'req': '`reqdata`',
                'res': '`body`',
              },
            },
          ],
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
  };

  // The pipeline context carries the config as a plain map.
  Map<String, dynamic> toMap() => <String, dynamic>{
        'main': main,
        'feature': feature,
        'options': options,
        'entity': entity,
      };
}

final config = Config();
