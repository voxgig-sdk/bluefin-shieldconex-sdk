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

  public record Detokenize(List<Object> batch, String bfid, String message_id, String name, String reference, List<Object> value) {}

  public record DetokenizeListMatch(List<Object> batch, String bfid, String message_id, String name, String reference, List<Object> value) {}

  public record DetokenizeCreateData(List<Object> batch, String bfid, String message_id, String name, String reference, List<Object> value) {}

  public record Tokenize(List<Object> batch, String bfid, String message_id, String name, String reference, String template_ref, List<Object> value) {}

  public record TokenizeListMatch(List<Object> batch, String bfid, String message_id, String name, String reference, String template_ref, List<Object> value) {}

  public record TokenizeCreateData(List<Object> batch, String bfid, String message_id, String name, String reference, String template_ref, List<Object> value) {}

  public record TokenizeBatch(List<Object> batch, String message_id, String reference) {}

  public record TokenizeBatchCreateData(List<Object> batch, String message_id, String reference) {}

  public record TokenizeRead(String bfid, String message_id, String reference, Map<String, Object> state, List<Object> value) {}

  public record TokenizeReadCreateData(String bfid, String message_id, String reference, Map<String, Object> state, List<Object> value) {}

  public record Validate(String message_id, String reference, String template_ref) {}

  public record ValidateCreateData(String message_id, String reference, String template_ref) {}

}
