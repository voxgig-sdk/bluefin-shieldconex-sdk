package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewDetokenizeEntityFunc func(client *BluefinShieldconexSDK, entopts map[string]any) BluefinShieldconexEntity

var NewTokenizeEntityFunc func(client *BluefinShieldconexSDK, entopts map[string]any) BluefinShieldconexEntity

var NewTokenizeBatchEntityFunc func(client *BluefinShieldconexSDK, entopts map[string]any) BluefinShieldconexEntity

var NewTokenizeReadEntityFunc func(client *BluefinShieldconexSDK, entopts map[string]any) BluefinShieldconexEntity

var NewValidateEntityFunc func(client *BluefinShieldconexSDK, entopts map[string]any) BluefinShieldconexEntity

