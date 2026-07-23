package voxgigbluefinshieldconexsdk

import (
	"github.com/voxgig-sdk/bluefin-shieldconex-sdk/go/core"
	"github.com/voxgig-sdk/bluefin-shieldconex-sdk/go/entity"
	"github.com/voxgig-sdk/bluefin-shieldconex-sdk/go/feature"
	_ "github.com/voxgig-sdk/bluefin-shieldconex-sdk/go/utility"
)

// Type aliases preserve external API.
type BluefinShieldconexSDK = core.BluefinShieldconexSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type BluefinShieldconexEntity = core.BluefinShieldconexEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type BluefinShieldconexError = core.BluefinShieldconexError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewDetokenizeEntityFunc = func(client *core.BluefinShieldconexSDK, entopts map[string]any) core.BluefinShieldconexEntity {
		return entity.NewDetokenizeEntity(client, entopts)
	}
	core.NewTokenizeEntityFunc = func(client *core.BluefinShieldconexSDK, entopts map[string]any) core.BluefinShieldconexEntity {
		return entity.NewTokenizeEntity(client, entopts)
	}
	core.NewTokenizeBatchEntityFunc = func(client *core.BluefinShieldconexSDK, entopts map[string]any) core.BluefinShieldconexEntity {
		return entity.NewTokenizeBatchEntity(client, entopts)
	}
	core.NewTokenizeReadEntityFunc = func(client *core.BluefinShieldconexSDK, entopts map[string]any) core.BluefinShieldconexEntity {
		return entity.NewTokenizeReadEntity(client, entopts)
	}
	core.NewValidateEntityFunc = func(client *core.BluefinShieldconexSDK, entopts map[string]any) core.BluefinShieldconexEntity {
		return entity.NewValidateEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewBluefinShieldconexSDK = core.NewBluefinShieldconexSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig

// No-arg convenience constructors. Go has no default-argument syntax,
// so these aliases let callers write `sdk.New()` / `sdk.Test()`
// instead of `sdk.NewBluefinShieldconexSDK(nil)` / `sdk.TestSDK(nil, nil)`
// for the common no-options case.
func New() *BluefinShieldconexSDK  { return NewBluefinShieldconexSDK(nil) }
func Test() *BluefinShieldconexSDK { return TestSDK(nil, nil) }
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
