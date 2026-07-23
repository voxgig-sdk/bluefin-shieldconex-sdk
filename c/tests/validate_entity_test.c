// Generated instance test for the validate entity.

#include "ctest.h"

int main(void) {
  BluefinShieldconexSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = bluefinshieldconex_validate(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "validate", "entity get_name");

  TEST_SUMMARY("validate_entity");
}
