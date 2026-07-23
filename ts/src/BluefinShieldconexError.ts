
import { Context } from './Context'


class BluefinShieldconexError extends Error {

  isBluefinShieldconexError = true

  sdk = 'BluefinShieldconex'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  BluefinShieldconexError
}

