// Generated instance test for the tokenize_batch entity.

#include "ctest.h"

int main(void) {
  BluefinShieldconexSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = bluefinshieldconex_tokenize_batch(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "tokenize_batch", "entity get_name");

  TEST_SUMMARY("tokenize_batch_entity");
}
