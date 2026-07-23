# ProjectName SDK exists test

import pytest
from bluefinshieldconex_sdk import BluefinShieldconexSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = BluefinShieldconexSDK.test(None, None)
        assert testsdk is not None
