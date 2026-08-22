import { BluefinShieldconexEntityBase } from '../BluefinShieldconexEntityBase';
import type { BluefinShieldconexSDK } from '../BluefinShieldconexSDK';
import type { Control } from '../types';
import type { Detokenize, DetokenizeListMatch, DetokenizeCreateData } from '../BluefinShieldconexTypes';
declare class DetokenizeEntity extends BluefinShieldconexEntityBase<Detokenize> {
    constructor(client: BluefinShieldconexSDK, entopts: any);
    make(this: DetokenizeEntity): DetokenizeEntity;
    list(this: any, reqmatch?: DetokenizeListMatch, ctrl?: Control): Promise<DetokenizeEntity[]>;
    create(this: any, reqdata?: DetokenizeCreateData, ctrl?: Control): Promise<DetokenizeEntity>;
}
export { DetokenizeEntity };
