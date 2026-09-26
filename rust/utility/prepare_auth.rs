// prepare_auth utility.
//
// GENERATED, not templated: where the credential goes - header, query or
// cookie, and under what name - is a fact about THIS API, and tm/ can only
// hold one answer. See PrepareAuth_rust.

use std::cell::RefCell;
use std::rc::Rc;

use crate::core::context::Context;
use crate::core::error::BluefinShieldconexError;
use crate::core::helpers::{getp, getpath, setp};
use crate::core::spec::Spec;
use crate::utility::voxgigstruct as vs;
use crate::utility::voxgigstruct::Value;

/// The header this API reads the credential from.
const CRED_NAME: &str = "authorization";
const OPTION_APIKEY: &str = "apikey";
const OPTION_SECRET: &str = "secret";
const NOT_FOUND: &str = "__NOTFOUND__";

pub fn prepare_auth_util(ctx: &Rc<Context>) -> Result<Rc<RefCell<Spec>>, BluefinShieldconexError> {
    let spec = ctx.spec.borrow().clone().ok_or_else(|| {
        ctx.make_error("auth_no_spec", "Expected context spec property to be defined.")
    })?;

    let headers = spec.borrow().headers.clone();
    let options = match ctx.client.borrow().clone() {
        Some(client) => client.options_map(),
        None => ctx.options.borrow().clone(),
    };

    // Public APIs that need no auth omit the options.auth block entirely.
    let auth = getp(&options, "auth");
    if auth.is_noval() || auth.is_null() {
        vs::del_prop(headers, &Value::str(CRED_NAME));
        return Ok(spec);
    }

    let apikey = vs::get_prop(&options, &Value::str(OPTION_APIKEY), Value::str(NOT_FOUND));

    let skip = match &apikey {
        Value::Noval | Value::Null => true,
        Value::Str(s) => s == NOT_FOUND || s.is_empty(),
        _ => false,
    };

    // True HTTP Basic Auth needs TWO credentials, base64-joined - a single
    // token in the header (the branch below) can never authenticate against
    // an API that actually checks `Authorization: Basic base64(user:pass)`.
    if let Value::Bool(true) = getpath(&["auth", "basic"], &options) {
        let secret = vs::get_prop(&options, &Value::str(OPTION_SECRET), Value::str(NOT_FOUND));

        let no_secret = match &secret {
            Value::Noval | Value::Null => true,
            Value::Str(s) => s == NOT_FOUND || s.is_empty(),
            _ => false,
        };

        if skip || no_secret {
            vs::del_prop(headers, &Value::str(CRED_NAME));
        } else {
            let apikey_val = match &apikey {
                Value::Str(s) => s.clone(),
                _ => String::new(),
            };
            let secret_val = match &secret {
                Value::Str(s) => s.clone(),
                _ => String::new(),
            };
            let b64 = base64_encode(format!("{}:{}", apikey_val, secret_val).as_bytes());

            let auth_prefix = match getpath(&["auth", "prefix"], &options) {
                Value::Str(s) => s,
                _ => String::new(),
            };
            // Empty prefix (raw apiKey credential) must not add a leading space.
            if auth_prefix.is_empty() {
                setp(&headers, CRED_NAME, Value::str(b64));
            } else {
                setp(
                    &headers,
                    CRED_NAME,
                    Value::str(format!("{} {}", auth_prefix, b64)),
                );
            }
        }

        return Ok(spec);
    }

    if skip {
        vs::del_prop(headers, &Value::str(CRED_NAME));
    } else {
        let auth_prefix = match getpath(&["auth", "prefix"], &options) {
            Value::Str(s) => s,
            _ => String::new(),
        };
        let apikey_val = match &apikey {
            Value::Str(s) => s.clone(),
            _ => String::new(),
        };
        // Empty prefix (raw apiKey credential) must not add a leading space.
        if auth_prefix.is_empty() {
            setp(&headers, CRED_NAME, Value::str(apikey_val));
        } else {
            setp(
                &headers,
                CRED_NAME,
                Value::str(format!("{} {}", auth_prefix, apikey_val)),
            );
        }
    }

    Ok(spec)
}

/// Standard base64, for the `Authorization: Basic base64(user:pass)` value.
///
/// In-tree because the crate takes no dependency for it: the secrets
/// feature's base64 DECODER lives behind a feature module this utility
/// cannot reach, and adding a crate for twenty lines would put a dependency
/// into every SDK whose API happens to use HTTP Basic.
fn base64_encode(input: &[u8]) -> String {
    const ALPHABET: &[u8] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    let mut out = String::with_capacity((input.len() + 2) / 3 * 4);

    for chunk in input.chunks(3) {
        // `chunks` hands back a 1- or 2-byte tail for input that is not a
        // multiple of three; the missing bytes read as zero and are padded out
        // below.
        let b0 = chunk[0] as usize;
        let b1 = *chunk.get(1).unwrap_or(&0) as usize;
        let b2 = *chunk.get(2).unwrap_or(&0) as usize;

        out.push(ALPHABET[b0 >> 2] as char);
        out.push(ALPHABET[((b0 & 0x03) << 4) | (b1 >> 4)] as char);
        // The tail is padded, never truncated: a decoder that counts groups
        // of four needs the '=' to know how many bytes came back.
        out.push(if 1 < chunk.len() {
            ALPHABET[((b1 & 0x0f) << 2) | (b2 >> 6)] as char
        } else {
            '='
        });
        out.push(if 2 < chunk.len() {
            ALPHABET[b2 & 0x3f] as char
        } else {
            '='
        });
    }

    out
}
