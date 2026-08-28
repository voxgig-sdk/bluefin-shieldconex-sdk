package voxgig.bluefinshieldconexsdk.core;

// Typed reference models for the BluefinShieldconex SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These records are documentation/DX reference shapes ONLY. The SDK ops take
// and return the loose object model (Map<String, Object> / Object) at runtime,
// so these types are not wired into the op signatures — use them to describe a
// payload before converting it to a map. Every component is a boxed (nullable)
// type, so an optional (req:false) key needs no distinct rendering.

import java.util.List;
import java.util.Map;

public final class BluefinShieldconexTypes {

  private BluefinShieldconexTypes() {}

  public record Detokenize(List<Object> batches, String bfid, String messageId, String name, String reference, String value, List<Object> values) {}

  public record DetokenizeListMatch(String bfid, String field_name, String field_value, String reference) {}

  public record DetokenizeCreateData(List<Object> batches, String bfid, String messageId, String name, String reference, String value, List<Object> values) {}

  public record Tokenize(List<Object> batches, String bfid, String messageId, String name, String reference, String templateRef, String value, List<Object> values) {}

  public record TokenizeListMatch(String field_name, String field_value, String reference, String template_ref) {}

  public record TokenizeCreateData(Double omit, List<Object> batches, String bfid, String messageId, String name, String reference, String templateRef, String value, List<Object> values) {}

  public record TokenizeBatch(List<Object> batches, String messageId, String reference) {}

  public record TokenizeBatchCreateData(List<Object> batches, String messageId, String reference) {}

  public record TokenizeRead(String bfid, String messageId, String reference, Map<String, Object> state, List<Object> values) {}

  public record TokenizeReadCreateData(String bfid, String messageId, String reference, Map<String, Object> state, List<Object> values) {}

  public record Validate(String messageId, String reference, String templateRef) {}

  public record ValidateCreateData(String messageId, String reference, String templateRef) {}

}
