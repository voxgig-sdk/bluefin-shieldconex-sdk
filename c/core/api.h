// BluefinShieldconex SDK public API (generated).

#ifndef BLUEFIN_SHIELDCONEX_API_H
#define BLUEFIN_SHIELDCONEX_API_H

#include "sdk.h"

// Detokenize entity.
Entity* detokenize_entity_new(BluefinShieldconexSDK* client, voxgig_value* entopts);
Entity* bluefin_shieldconex_detokenize(BluefinShieldconexSDK* client, voxgig_value* entopts);
voxgig_value* detokenize_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Tokenize entity.
Entity* tokenize_entity_new(BluefinShieldconexSDK* client, voxgig_value* entopts);
Entity* bluefin_shieldconex_tokenize(BluefinShieldconexSDK* client, voxgig_value* entopts);
voxgig_value* tokenize_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// TokenizeBatch entity.
Entity* tokenize_batch_entity_new(BluefinShieldconexSDK* client, voxgig_value* entopts);
Entity* bluefin_shieldconex_tokenize_batch(BluefinShieldconexSDK* client, voxgig_value* entopts);
voxgig_value* tokenize_batch_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// TokenizeRead entity.
Entity* tokenize_read_entity_new(BluefinShieldconexSDK* client, voxgig_value* entopts);
Entity* bluefin_shieldconex_tokenize_read(BluefinShieldconexSDK* client, voxgig_value* entopts);
voxgig_value* tokenize_read_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);
// Validate entity.
Entity* validate_entity_new(BluefinShieldconexSDK* client, voxgig_value* entopts);
Entity* bluefin_shieldconex_validate(BluefinShieldconexSDK* client, voxgig_value* entopts);
voxgig_value* validate_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);

#endif // BLUEFIN_SHIELDCONEX_API_H
