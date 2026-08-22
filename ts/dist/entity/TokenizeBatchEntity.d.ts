import { BluefinShieldconexEntityBase } from '../BluefinShieldconexEntityBase';
import type { BluefinShieldconexSDK } from '../BluefinShieldconexSDK';
import type { Control } from '../types';
import type { TokenizeBatch, TokenizeBatchCreateData } from '../BluefinShieldconexTypes';
declare class TokenizeBatchEntity extends BluefinShieldconexEntityBase<TokenizeBatch> {
    constructor(client: BluefinShieldconexSDK, entopts: any);
    make(this: TokenizeBatchEntity): TokenizeBatchEntity;
    create(this: any, reqdata?: TokenizeBatchCreateData, ctrl?: Control): Promise<TokenizeBatchEntity>;
}
export { TokenizeBatchEntity };
