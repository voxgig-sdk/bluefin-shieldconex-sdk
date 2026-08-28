package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewAuditFeatureFunc func() Feature

var NewClienttrackFeatureFunc func() Feature

var NewIdempotencyFeatureFunc func() Feature

var NewLogFeatureFunc func() Feature

var NewMetricsFeatureFunc func() Feature

var NewPagingFeatureFunc func() Feature

var NewRatelimitFeatureFunc func() Feature

var NewRetryFeatureFunc func() Feature

var NewTelemetryFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewTimeoutFeatureFunc func() Feature

var NewDetokenizeEntityFunc func(client *BluefinShieldconexSDK, entopts map[string]any) BluefinShieldconexEntity

var NewTokenizeEntityFunc func(client *BluefinShieldconexSDK, entopts map[string]any) BluefinShieldconexEntity

var NewTokenizeBatchEntityFunc func(client *BluefinShieldconexSDK, entopts map[string]any) BluefinShieldconexEntity

var NewTokenizeReadEntityFunc func(client *BluefinShieldconexSDK, entopts map[string]any) BluefinShieldconexEntity

var NewValidateEntityFunc func(client *BluefinShieldconexSDK, entopts map[string]any) BluefinShieldconexEntity

