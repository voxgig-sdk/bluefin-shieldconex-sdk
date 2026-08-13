# BluefinShieldconex SDK utility: make_context

from projectname_sdk.core.context import BluefinShieldconexContext


def make_context_util(ctxmap, basectx):
    return BluefinShieldconexContext(ctxmap, basectx)
