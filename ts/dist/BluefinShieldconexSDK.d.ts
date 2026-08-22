import { DetokenizeEntity } from './entity/DetokenizeEntity';
import { TokenizeEntity } from './entity/TokenizeEntity';
import { TokenizeBatchEntity } from './entity/TokenizeBatchEntity';
import { TokenizeReadEntity } from './entity/TokenizeReadEntity';
import { ValidateEntity } from './entity/ValidateEntity';
export type * from './BluefinShieldconexTypes';
import { inspect } from 'node:util';
import type { Context, Feature } from './types';
import { config } from './Config';
import { BluefinShieldconexEntityBase } from './BluefinShieldconexEntityBase';
import { Utility } from './utility/Utility';
import { BaseFeature } from './feature/base/BaseFeature';
declare const stdutil: Utility;
declare class BluefinShieldconexSDK {
    _mode: string;
    _options: any;
    _utility: Utility;
    _features: Feature[];
    _rootctx: Context;
    constructor(options?: any);
    options(): any;
    utility(): any;
    prepare(fetchargs?: any): Promise<any>;
    direct(fetchargs?: any): Promise<Error | {
        ok: boolean;
        status: number;
        headers: any;
        data: any;
        err?: undefined;
    } | {
        ok: boolean;
        err: any;
        status?: undefined;
        headers?: undefined;
        data?: undefined;
    }>;
    _rawRequest(fetchargs?: any): Promise<Error | {
        ok: boolean;
        status: number;
        headers: any;
        data: any;
        err?: undefined;
    } | {
        ok: boolean;
        err: any;
        status?: undefined;
        headers?: undefined;
        data?: undefined;
    }>;
    graphql(query: string, variables?: any, ctrl?: any): Promise<any>;
    Detokenize(entopts?: Record<string, any>): DetokenizeEntity;
    Tokenize(entopts?: Record<string, any>): TokenizeEntity;
    TokenizeBatch(entopts?: Record<string, any>): TokenizeBatchEntity;
    TokenizeRead(entopts?: Record<string, any>): TokenizeReadEntity;
    Validate(entopts?: Record<string, any>): ValidateEntity;
    static test(testoptsarg?: any, sdkoptsarg?: any): BluefinShieldconexSDK;
    tester(testopts?: any, sdkopts?: any): BluefinShieldconexSDK;
    toJSON(): {
        name: string;
    };
    toString(): string;
    [inspect.custom](): string;
}
declare const SDK: typeof BluefinShieldconexSDK;
export { stdutil, config, BaseFeature, BluefinShieldconexEntityBase, BluefinShieldconexSDK, SDK, };
