import 'feature/base/BaseFeature.dart';
import 'feature/test/TestFeature.dart';


// ignore: non_constant_identifier_names
final Map<String, BaseFeature Function()> FEATURE_CLASS = {
    'test': () => TestFeature(),

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

  final Map<String, dynamic> main = <String, dynamic>{
    'name': 'ProjectName',
  };

  final Map<String, dynamic> feature = <String, dynamic>{
        'test': <String, dynamic>{
      'options': <String, dynamic>{
        'active': false,
      },
    },

  };

  final Map<String, dynamic> options = <String, dynamic>{
    'base': 'https://secure-cert.shieldconex.com/api',

    'auth': <String, dynamic>{
      'prefix': 'Basic',
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

    }
  };

  final Map<String, dynamic> entity = <String, dynamic>{
    'detokenize': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'active': true,
          'name': 'batch',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$ARRAY`',
            },
          },
          'req': false,
          'type': '`\$ARRAY`',
          'index\$': 0,
        },
        <String, dynamic>{
          'active': true,
          'name': 'bfid',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$STRING`',
            },
          },
          'req': false,
          'type': '`\$STRING`',
          'index\$': 1,
        },
        <String, dynamic>{
          'active': true,
          'name': 'message_id',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 2,
        },
        <String, dynamic>{
          'active': true,
          'name': 'name',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 3,
        },
        <String, dynamic>{
          'active': true,
          'name': 'reference',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 4,
        },
        <String, dynamic>{
          'active': true,
          'name': 'value',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$ARRAY`',
            },
          },
          'req': false,
          'type': '`\$ARRAY`',
          'index\$': 5,
        },
      ],
      'name': 'detokenize',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 0,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 1,
            },
          ],
          'key\$': 'create',
        },
        'list': <String, dynamic>{
          'input': 'data',
          'name': 'list',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{
                'query': <dynamic>[
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'bfid',
                    'orig': 'bfid',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'field_name',
                    'orig': 'field_name',
                    'reqd': false,
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'field_value',
                    'orig': 'field_value',
                    'reqd': false,
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'reference',
                    'orig': 'reference',
                    'reqd': false,
                    'type': '`\$STRING`',
                  },
                ],
              },
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
                'res': '`body`',
              },
              'index\$': 0,
            },
          ],
          'key\$': 'list',
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'tokenize': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'active': true,
          'name': 'batch',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$ARRAY`',
            },
          },
          'req': false,
          'type': '`\$ARRAY`',
          'index\$': 0,
        },
        <String, dynamic>{
          'active': true,
          'name': 'bfid',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$STRING`',
            },
          },
          'req': false,
          'type': '`\$STRING`',
          'index\$': 1,
        },
        <String, dynamic>{
          'active': true,
          'name': 'message_id',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 2,
        },
        <String, dynamic>{
          'active': true,
          'name': 'name',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 3,
        },
        <String, dynamic>{
          'active': true,
          'name': 'reference',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 4,
        },
        <String, dynamic>{
          'active': true,
          'name': 'template_ref',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 5,
        },
        <String, dynamic>{
          'active': true,
          'name': 'value',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$ARRAY`',
            },
          },
          'req': false,
          'type': '`\$ARRAY`',
          'index\$': 6,
        },
      ],
      'name': 'tokenize',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{
                'query': <dynamic>[
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'omit',
                    'orig': 'omit',
                    'reqd': false,
                    'type': '`\$NUMBER`',
                  },
                ],
              },
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
              'index\$': 0,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{
                'query': <dynamic>[
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'omit',
                    'orig': 'omit',
                    'reqd': false,
                    'type': '`\$NUMBER`',
                  },
                ],
              },
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
              'index\$': 1,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 2,
            },
          ],
          'key\$': 'create',
        },
        'list': <String, dynamic>{
          'input': 'data',
          'name': 'list',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{
                'query': <dynamic>[
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'field_name',
                    'orig': 'field_name',
                    'reqd': false,
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'field_value',
                    'orig': 'field_value',
                    'reqd': false,
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'reference',
                    'orig': 'reference',
                    'reqd': false,
                    'type': '`\$STRING`',
                  },
                  <String, dynamic>{
                    'active': true,
                    'kind': 'query',
                    'name': 'template_ref',
                    'orig': 'template_ref',
                    'reqd': true,
                    'type': '`\$STRING`',
                  },
                ],
              },
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
                'res': '`body`',
              },
              'index\$': 0,
            },
          ],
          'key\$': 'list',
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'tokenize_batch': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'active': true,
          'name': 'batch',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$ARRAY`',
            },
          },
          'req': false,
          'type': '`\$ARRAY`',
          'index\$': 0,
        },
        <String, dynamic>{
          'active': true,
          'name': 'message_id',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 1,
        },
        <String, dynamic>{
          'active': true,
          'name': 'reference',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 2,
        },
      ],
      'name': 'tokenize_batch',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 0,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 1,
            },
          ],
          'key\$': 'create',
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'tokenize_read': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'active': true,
          'name': 'bfid',
          'op': <String, dynamic>{
            'create': <String, dynamic>{
              'req': true,
              'type': '`\$STRING`',
            },
          },
          'req': false,
          'type': '`\$STRING`',
          'index\$': 0,
        },
        <String, dynamic>{
          'active': true,
          'name': 'message_id',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 1,
        },
        <String, dynamic>{
          'active': true,
          'name': 'reference',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 2,
        },
        <String, dynamic>{
          'active': true,
          'name': 'state',
          'req': false,
          'type': '`\$OBJECT`',
          'index\$': 3,
        },
        <String, dynamic>{
          'active': true,
          'name': 'value',
          'req': false,
          'type': '`\$ARRAY`',
          'index\$': 4,
        },
      ],
      'name': 'tokenize_read',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 0,
            },
          ],
          'key\$': 'create',
        },
      },
      'relations': <String, dynamic>{
        'ancestors': <dynamic>[],
      },
    },
    'validate': <String, dynamic>{
      'fields': <dynamic>[
        <String, dynamic>{
          'active': true,
          'name': 'message_id',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 0,
        },
        <String, dynamic>{
          'active': true,
          'name': 'reference',
          'req': false,
          'type': '`\$STRING`',
          'index\$': 1,
        },
        <String, dynamic>{
          'active': true,
          'name': 'template_ref',
          'req': true,
          'type': '`\$STRING`',
          'index\$': 2,
        },
      ],
      'name': 'validate',
      'op': <String, dynamic>{
        'create': <String, dynamic>{
          'input': 'data',
          'name': 'create',
          'points': <dynamic>[
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 0,
            },
            <String, dynamic>{
              'active': true,
              'args': <String, dynamic>{},
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
              'index\$': 1,
            },
          ],
          'key\$': 'create',
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
