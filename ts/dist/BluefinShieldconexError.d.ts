import { Context } from './Context';
declare class BluefinShieldconexError extends Error {
    isBluefinShieldconexError: boolean;
    sdk: string;
    code: string;
    ctx: Context;
    status: number;
    get notFound(): boolean;
    constructor(code: string, msg: string, ctx: Context);
}
export { BluefinShieldconexError };
