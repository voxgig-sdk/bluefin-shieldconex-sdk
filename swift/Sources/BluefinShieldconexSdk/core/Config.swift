// BluefinShieldconex SDK - generated model configuration and feature
// factory. GENERATED from the API model - do not edit by hand.

import Foundation

public enum SdkConfig {
  public static func makeConfig() -> VMap {
    let json = #"""
{"main":{"name":"BluefinShieldconex","slug":"bluefin-shieldconex","version":"0.1.1","target":"swift"},"feature":{"audit":{"options":{"active":false,"actor":"anonymous","max":1000},"transport":"none"},"clienttrack":{"options":{"active":false,"clientVersion":"0.0.1"},"transport":"none"},"idempotency":{"options":{"active":false,"header":"Idempotency-Key","methods":["POST","PUT","PATCH","DELETE"],"ops":["create","update","remove"]},"transport":"none"},"log":{"options":{"active":true},"transport":"none"},"metrics":{"options":{"active":false},"transport":"none"},"paging":{"options":{"active":false,"afterVar":"after","cursorParam":"cursor","firstVar":"first","limitParam":"limit","pageParam":"page","startPage":1},"transport":"none"},"ratelimit":{"options":{"active":false,"burst":5,"rate":5},"transport":"wrap"},"retry":{"options":{"active":false,"factor":2,"maxDelay":2000,"minDelay":50,"retries":2,"statuses":[408,425,429,500,502,503,504]},"transport":"wrap"},"telemetry":{"options":{"active":false},"transport":"none"},"test":{"options":{"active":false},"transport":"base"},"timeout":{"options":{"active":false,"ms":30000},"transport":"wrap"}},"options":{"base":"https://secure-cert.shieldconex.com/api","auth":{"prefix":"Basic","basic":true},"headers":{"content-type":"application/json"},"entity":{"detokenize":{},"tokenize":{},"tokenize_batch":{},"tokenize_read":{},"validate":{}}},"entity":{"detokenize":{"fields":[{"name":"batches","op":{"create":{"req":true,"type":"`$ARRAY`"}},"type":"`$ARRAY`"},{"name":"bfid","op":{"create":{"req":true,"type":"`$STRING`"}},"short":"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).","type":"`$STRING`"},{"name":"messageId","short":"Message Id","type":"`$STRING`"},{"name":"name","short":"Field Name.","type":"`$STRING`"},{"name":"reference","short":"Request Reference.","type":"`$STRING`"},{"name":"value","short":"Field Value.","type":"`$STRING`"},{"name":"values","op":{"create":{"req":true,"type":"`$ARRAY`"}},"type":"`$ARRAY`"}],"name":"detokenize","op":{"create":{"input":"data","name":"create","points":[{"args":{},"kind":"http","method":"POST","orig":"/tokenization/batch/detokenize","parts":["tokenization","batch","detokenize"],"select":{},"transform":{"req":"`reqdata`","res":"`body`"}},{"args":{},"kind":"http","method":"POST","orig":"/tokenization/detokenize","parts":["tokenization","detokenize"],"select":{},"transform":{"req":"`reqdata`","res":"`body`"}}]},"list":{"input":"data","name":"list","points":[{"args":{"query":[{"kind":"query","name":"bfid","orig":"bfid","reqd":true,"type":"`$STRING`"},{"kind":"query","name":"field_name","orig":"field_name","type":"`$STRING`"},{"kind":"query","name":"field_value","orig":"field_value","type":"`$STRING`"},{"kind":"query","name":"reference","orig":"reference","type":"`$STRING`"}]},"kind":"http","method":"GET","orig":"/healthcheck/detokenize","parts":["healthcheck","detokenize"],"select":{"exist":["bfid","field_name","field_value","reference"]},"transform":{"req":"`reqdata`","res":"`body.values`"}}]}},"relations":{"ancestors":[]}},"tokenize":{"fields":[{"name":"batches","op":{"create":{"req":true,"type":"`$ARRAY`"}},"type":"`$ARRAY`"},{"name":"bfid","op":{"create":{"req":true,"type":"`$STRING`"}},"short":"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).","type":"`$STRING`"},{"name":"messageId","short":"Message Id","type":"`$STRING`"},{"name":"name","short":"Field Name.","type":"`$STRING`"},{"name":"reference","short":"Request Reference.","type":"`$STRING`"},{"name":"templateRef","req":true,"short":"Template Reference","type":"`$STRING`"},{"name":"value","short":"Field Value.","type":"`$STRING`"},{"name":"values","op":{"create":{"req":true,"type":"`$ARRAY`"}},"type":"`$ARRAY`"}],"name":"tokenize","op":{"create":{"input":"data","name":"create","points":[{"args":{"query":[{"kind":"query","name":"omit","orig":"omit","type":"`$NUMBER`"}]},"kind":"http","method":"POST","orig":"/tokenization/batch/tokenize","parts":["tokenization","batch","tokenize"],"select":{"exist":["omit"]},"transform":{"req":"`reqdata`","res":"`body`"}},{"args":{"query":[{"kind":"query","name":"omit","orig":"omit","type":"`$NUMBER`"}]},"kind":"http","method":"POST","orig":"/tokenization/tokenize","parts":["tokenization","tokenize"],"select":{"exist":["omit"]},"transform":{"req":"`reqdata`","res":"`body`"}},{"args":{},"kind":"http","method":"POST","orig":"/tokenization/delete","parts":["tokenization","delete"],"select":{},"transform":{"req":"`reqdata`","res":"`body`"}}]},"list":{"input":"data","name":"list","points":[{"args":{"query":[{"kind":"query","name":"field_name","orig":"field_name","type":"`$STRING`"},{"kind":"query","name":"field_value","orig":"field_value","type":"`$STRING`"},{"kind":"query","name":"reference","orig":"reference","type":"`$STRING`"},{"kind":"query","name":"template_ref","orig":"template_ref","reqd":true,"type":"`$STRING`"}]},"kind":"http","method":"GET","orig":"/healthcheck/tokenize","parts":["healthcheck","tokenize"],"select":{"exist":["field_name","field_value","reference","template_ref"]},"transform":{"req":"`reqdata`","res":"`body.values`"}}]}},"relations":{"ancestors":[]}},"tokenize_batch":{"fields":[{"name":"batches","op":{"create":{"req":true,"type":"`$ARRAY`"}},"type":"`$ARRAY`"},{"name":"messageId","short":"Message Id","type":"`$STRING`"},{"name":"reference","short":"Request Reference.","type":"`$STRING`"}],"name":"tokenize_batch","op":{"create":{"input":"data","name":"create","points":[{"args":{},"kind":"http","method":"POST","orig":"/tokenization/batch/delete","parts":["tokenization","batch","delete"],"select":{},"transform":{"req":"`reqdata`","res":"`body`"}},{"args":{},"kind":"http","method":"POST","orig":"/tokenization/batch/read","parts":["tokenization","batch","read"],"select":{},"transform":{"req":"`reqdata`","res":"`body`"}}]}},"relations":{"ancestors":[]}},"tokenize_read":{"fields":[{"name":"bfid","op":{"create":{"req":true,"type":"`$STRING`"}},"short":"The BFID, or Bluefin ID, is the value that is created when a tokenization request is made (i.e., it is the value retrieved from an iFrame transaction, or a /tokenization/tokenize request).","type":"`$STRING`"},{"name":"messageId","short":"Message Id","type":"`$STRING`"},{"name":"reference","short":"Request Reference.","type":"`$STRING`"},{"name":"state","short":"Tokenized State Data (if available)","type":"`$OBJECT`"},{"name":"values","type":"`$ARRAY`"}],"name":"tokenize_read","op":{"create":{"input":"data","name":"create","points":[{"args":{},"kind":"http","method":"POST","orig":"/tokenization/read","parts":["tokenization","read"],"select":{},"transform":{"req":"`reqdata`","res":"`body`"}}]}},"relations":{"ancestors":[]}},"validate":{"fields":[{"name":"messageId","short":"Message Id","type":"`$STRING`"},{"name":"reference","short":"Request Reference.","type":"`$STRING`"},{"name":"templateRef","req":true,"short":"Template Reference.","type":"`$STRING`"}],"name":"validate","op":{"create":{"input":"data","name":"create","points":[{"args":{},"kind":"http","method":"POST","orig":"/partner/validate","parts":["partner","validate"],"select":{},"transform":{"req":"`reqdata`","res":"`body`"}},{"args":{},"kind":"http","method":"POST","orig":"/template/validate","parts":["template","validate"],"select":{},"transform":{"req":"`reqdata`","res":"`body`"}}]}},"relations":{"ancestors":[]}}}}
"""#
    return (try? JSON.parse(json))?.asMap ?? VMap()
  }

  // SHARED CONFIG (sdkgen rung L2).
  //
  // The SDK reads the config on every request and never writes to it, so one
  // instance is shared by every client rather than rebuilt per client - the
  // difference between parsing the embedded JSON once and once per client.
  //
  // A static let in an enum is lazy and initialised exactly once, thread-safe
  // via swift_once.
  //
  // The result is SHARED: treat it as read-only. Callers that need to mutate
  // should use makeConfig, which always parses a fresh copy.
  private static let sharedConfigVal: VMap = makeConfig()

  public static func sharedConfig() -> VMap {
    return sharedConfigVal
  }

  public static func makeFeature(_ name: String) -> BaseFeature {
    switch name {
    case "audit": return AuditFeature()
    case "clienttrack": return ClienttrackFeature()
    case "idempotency": return IdempotencyFeature()
    case "log": return LogFeature()
    case "metrics": return MetricsFeature()
    case "paging": return PagingFeature()
    case "ratelimit": return RatelimitFeature()
    case "retry": return RetryFeature()
    case "telemetry": return TelemetryFeature()
    case "test": return TestFeature()
    case "timeout": return TimeoutFeature()
    default: return BaseFeature()
    }
  }
}
