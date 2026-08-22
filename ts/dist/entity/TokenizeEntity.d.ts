import { BluefinShieldconexEntityBase } from '../BluefinShieldconexEntityBase';
import type { BluefinShieldconexSDK } from '../BluefinShieldconexSDK';
import type { Control } from '../types';
import type { Tokenize, TokenizeListMatch, TokenizeCreateData } from '../BluefinShieldconexTypes';
declare class TokenizeEntity extends BluefinShieldconexEntityBase<Tokenize> {
    constructor(client: BluefinShieldconexSDK, entopts: any);
    make(this: TokenizeEntity): TokenizeEntity;
    list(this: any, reqmatch?: TokenizeListMatch, ctrl?: Control): Promise<TokenizeEntity[]>;
    create(this: any, reqdata?: TokenizeCreateData, ctrl?: Control): Promise<TokenizeEntity>;
}
export { TokenizeEntity };
