import { BluefinShieldconexEntityBase } from '../BluefinShieldconexEntityBase';
import type { BluefinShieldconexSDK } from '../BluefinShieldconexSDK';
import type { Control } from '../types';
import type { Validate, ValidateCreateData } from '../BluefinShieldconexTypes';
declare class ValidateEntity extends BluefinShieldconexEntityBase<Validate> {
    constructor(client: BluefinShieldconexSDK, entopts: any);
    make(this: ValidateEntity): ValidateEntity;
    create(this: any, reqdata?: ValidateCreateData, ctrl?: Control): Promise<ValidateEntity>;
}
export { ValidateEntity };
