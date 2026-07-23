// ignore_for_file: unused_import, unused_local_variable, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import '../../harness.dart';
import '../../utility.dart';

import '../../../lib/BluefinShieldconexSDK.dart';
import '../../../lib/utility/voxgig_struct.dart' as vs;

void tests() {
  describe('TokenizeReadEntity', () {
    test('instance', (t) async {
      final testsdk = BluefinShieldconexSDK.test();
      final ent = testsdk.TokenizeRead();
      ok(null != ent);
    });



    test('basic', (t) async {

      final live = 'TRUE' == Platform.environment['BLUEFIN_SHIELDCONEX_TEST_LIVE'];
      for (final op in ['create']) {
        if (maybeSkipControl(t, 'entityOp', 'tokenize_read.' + op, live)) {
          return;
        }
      }

      final setup = basicSetup();
      // The basic flow consumes synthetic IDs and field values from the
      // fixture (entity TestData.json). Those don't exist on the live API.
      // Skip live runs unless the user provided a real ENTID env override.
      if (true == setup['syntheticOnly']) {
        t.skip('live entity test uses synthetic IDs from fixture — set BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_READ_ENTID JSON to run live');
        return;
      }
      final client = setup['client'];
      final struct = setup['struct'];

      final isempty = struct.isempty;
      final select = struct.select;


      // CREATE
      final tokenize_read_ref01_ent = client.TokenizeRead();
      dynamic tokenize_read_ref01_data = setup['data']['new']['tokenize_read']['tokenize_read_ref01'];

      tokenize_read_ref01_data = await tokenize_read_ref01_ent.create(tokenize_read_ref01_data);
      ok(null != tokenize_read_ref01_data);


    });
  });
}


Map<String, dynamic> basicSetup([dynamic extra]) {
  final options = <String, dynamic>{};

  final entityDataFile = resolveTestPath(
      '../.sdk/test/entity/tokenize_read/TokenizeReadTestData.json');

  final entityDataSource = File(entityDataFile).readAsStringSync();

  final entityData = jsonDecode(entityDataSource);

  options['entity'] = entityData['existing'];

  var client = BluefinShieldconexSDK.test(options, extra);
  final struct = client.utility().struct;
  final merge = struct.merge;
  final transform = struct.transform;

  dynamic idmap = transform(
      <dynamic>['tokenize_read01', 'tokenize_read02', 'tokenize_read03'],
      <String, dynamic>{
        '`\$PACK`': <dynamic>[
          '',
          <String, dynamic>{
            '`\$KEY`': '`\$COPY`',
            '`\$VAL`': <dynamic>['`\$FORMAT`', 'upper', '`\$COPY`'],
          }
        ]
      });

  // Detect whether the user provided a real ENTID JSON via env var. The
  // basic flow consumes synthetic IDs from the fixture file; without an
  // override those synthetic IDs reach the live API and 4xx. Surface this
  // to the test so it can skip rather than fail.
  final idmapEnvVal =
      Platform.environment['BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_READ_ENTID'];
  final idmapOverridden =
      null != idmapEnvVal && idmapEnvVal.trim().startsWith('{');

  final env = envOverride({
    'BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_READ_ENTID': idmap,
    'BLUEFIN_SHIELDCONEX_TEST_LIVE': 'FALSE',
    'BLUEFIN_SHIELDCONEX_TEST_EXPLAIN': 'FALSE',
    'BLUEFIN_SHIELDCONEX_APIKEY': 'NONE',
  });

  idmap = env['BLUEFIN_SHIELDCONEX_TEST_TOKENIZE_READ_ENTID'];

  final live = 'TRUE' == env['BLUEFIN_SHIELDCONEX_TEST_LIVE'];

  if (live) {
    client = BluefinShieldconexSDK(merge([
      <String, dynamic>{
        'apikey': env['BLUEFIN_SHIELDCONEX_APIKEY'],
      },
      extra
    ]));
  }

  final setup = <String, dynamic>{
    'idmap': idmap,
    'env': env,
    'options': options,
    'client': client,
    'struct': struct,
    'data': entityData,
    'explain': 'TRUE' == env['BLUEFIN_SHIELDCONEX_TEST_EXPLAIN'],
    'live': live,
    'syntheticOnly': live && !idmapOverridden,
    'now': DateTime.now().millisecondsSinceEpoch,
  };

  return setup;
}

