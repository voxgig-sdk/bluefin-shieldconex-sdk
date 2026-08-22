export interface Detokenize {
    batches?: any[];
    bfid?: string;
    messageId?: string;
    name?: string;
    reference?: string;
    value?: string;
    values?: any[];
}
export interface DetokenizeListMatch {
    batches?: any[];
    bfid?: string;
    messageId?: string;
    name?: string;
    reference?: string;
    value?: string;
    values?: any[];
}
export interface DetokenizeCreateData {
    batches?: any[];
    bfid?: string;
    messageId?: string;
    name?: string;
    reference?: string;
    value?: string;
    values?: any[];
}
export interface Tokenize {
    batches?: any[];
    bfid?: string;
    messageId?: string;
    name?: string;
    reference?: string;
    templateRef: string;
    value?: string;
    values?: any[];
}
export interface TokenizeListMatch {
    batches?: any[];
    bfid?: string;
    messageId?: string;
    name?: string;
    reference?: string;
    templateRef?: string;
    value?: string;
    values?: any[];
}
export interface TokenizeCreateData {
    batches?: any[];
    bfid?: string;
    messageId?: string;
    name?: string;
    reference?: string;
    templateRef: string;
    value?: string;
    values?: any[];
}
export interface TokenizeBatch {
    batches?: any[];
    messageId?: string;
    reference?: string;
}
export interface TokenizeBatchCreateData {
    batches?: any[];
    messageId?: string;
    reference?: string;
}
export interface TokenizeRead {
    bfid?: string;
    messageId?: string;
    reference?: string;
    state?: Record<string, any>;
    values?: any[];
}
export interface TokenizeReadCreateData {
    bfid?: string;
    messageId?: string;
    reference?: string;
    state?: Record<string, any>;
    values?: any[];
}
export interface Validate {
    messageId?: string;
    reference?: string;
    templateRef: string;
}
export interface ValidateCreateData {
    messageId?: string;
    reference?: string;
    templateRef: string;
}
