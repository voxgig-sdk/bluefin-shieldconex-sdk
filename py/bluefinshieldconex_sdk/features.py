# BluefinShieldconex SDK feature factory

from bluefinshieldconex_sdk.feature.base_feature import BluefinShieldconexBaseFeature
from bluefinshieldconex_sdk.feature.test_feature import BluefinShieldconexTestFeature


def _make_feature(name):
    features = {
        "base": lambda: BluefinShieldconexBaseFeature(),
        "test": lambda: BluefinShieldconexTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
