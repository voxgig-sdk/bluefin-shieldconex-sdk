# BluefinShieldconex SDK feature factory

from feature.base_feature import BluefinShieldconexBaseFeature
from feature.test_feature import BluefinShieldconexTestFeature


def _make_feature(name):
    features = {
        "base": lambda: BluefinShieldconexBaseFeature(),
        "test": lambda: BluefinShieldconexTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
