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
    batch: list
    bfid: str
    message_id: str
    name: str
    reference: str
    value: list


class DetokenizeListMatch(TypedDict, total=False):
    batch: list
    bfid: str
    message_id: str
    name: str
    reference: str
    value: list


class DetokenizeCreateData(TypedDict, total=False):
    batch: list
    bfid: str
    message_id: str
    name: str
    reference: str
    value: list


class TokenizeRequired(TypedDict):
    template_ref: str


class Tokenize(TokenizeRequired, total=False):
    batch: list
    bfid: str
    message_id: str
    name: str
    reference: str
    value: list


class TokenizeListMatch(TypedDict, total=False):
    batch: list
    bfid: str
    message_id: str
    name: str
    reference: str
    template_ref: str
    value: list


class TokenizeCreateDataRequired(TypedDict):
    template_ref: str


class TokenizeCreateData(TokenizeCreateDataRequired, total=False):
    batch: list
    bfid: str
    message_id: str
    name: str
    reference: str
    value: list


class TokenizeBatch(TypedDict, total=False):
    batch: list
    message_id: str
    reference: str


class TokenizeBatchCreateData(TypedDict, total=False):
    batch: list
    message_id: str
    reference: str


class TokenizeRead(TypedDict, total=False):
    bfid: str
    message_id: str
    reference: str
    state: dict
    value: list


class TokenizeReadCreateData(TypedDict, total=False):
    bfid: str
    message_id: str
    reference: str
    state: dict
    value: list


class ValidateRequired(TypedDict):
    template_ref: str


class Validate(ValidateRequired, total=False):
    message_id: str
    reference: str


class ValidateCreateDataRequired(TypedDict):
    template_ref: str


class ValidateCreateData(ValidateCreateDataRequired, total=False):
    message_id: str
    reference: str
