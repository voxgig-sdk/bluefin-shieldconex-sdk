# Typed models for the BluefinShieldconex SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.
#
# These are TypedDicts, not dataclasses: the SDK ops return/accept plain dicts
# at runtime, and a TypedDict IS a dict shape, so the types match the runtime.
# Optional (req:false) keys are modelled as TypedDict key-optionality
# (total=False), split into a required base + total=False subclass when a type
# has both required and optional keys.

from __future__ import annotations

from typing import TypedDict, Any


class Detokenize(TypedDict, total=False):
    batches: list
    bfid: str
    messageId: str
    name: str
    reference: str
    value: str
    values: list


class DetokenizeListMatchRequired(TypedDict):
    bfid: str


class DetokenizeListMatch(DetokenizeListMatchRequired, total=False):
    field_name: str
    field_value: str
    reference: str


class DetokenizeCreateData(TypedDict, total=False):
    batches: list
    bfid: str
    messageId: str
    name: str
    reference: str
    value: str
    values: list


class TokenizeRequired(TypedDict):
    templateRef: str


class Tokenize(TokenizeRequired, total=False):
    batches: list
    bfid: str
    messageId: str
    name: str
    reference: str
    value: str
    values: list


class TokenizeListMatchRequired(TypedDict):
    template_ref: str


class TokenizeListMatch(TokenizeListMatchRequired, total=False):
    field_name: str
    field_value: str
    reference: str


class TokenizeCreateDataRequired(TypedDict):
    templateRef: str


class TokenizeCreateData(TokenizeCreateDataRequired, total=False):
    omit: float
    batches: list
    bfid: str
    messageId: str
    name: str
    reference: str
    value: str
    values: list


class TokenizeBatch(TypedDict, total=False):
    batches: list
    messageId: str
    reference: str


class TokenizeBatchCreateData(TypedDict, total=False):
    batches: list
    messageId: str
    reference: str


class TokenizeRead(TypedDict, total=False):
    bfid: str
    messageId: str
    reference: str
    state: dict
    values: list


class TokenizeReadCreateData(TypedDict, total=False):
    bfid: str
    messageId: str
    reference: str
    state: dict
    values: list


class ValidateRequired(TypedDict):
    templateRef: str


class Validate(ValidateRequired, total=False):
    messageId: str
    reference: str


class ValidateCreateDataRequired(TypedDict):
    templateRef: str


class ValidateCreateData(ValidateCreateDataRequired, total=False):
    messageId: str
    reference: str
