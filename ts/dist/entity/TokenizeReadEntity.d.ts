import { BluefinShieldconexEntityBase } from '../BluefinShieldconexEntityBase';
import type { BluefinShieldconexSDK } from '../BluefinShieldconexSDK';
import type { Control } from '../types';
import type { TokenizeRead, TokenizeReadCreateData } from '../BluefinShieldconexTypes';
declare class TokenizeReadEntity extends BluefinShieldconexEntityBase<TokenizeRead> {
    constructor(client: BluefinShieldconexSDK, entopts: any);
    make(this: TokenizeReadEntity): TokenizeReadEntity;
    create(this: any, reqdata?: TokenizeReadCreateData, ctrl?: Control): Promise<TokenizeReadEntity>;
}
export { TokenizeReadEntity };
