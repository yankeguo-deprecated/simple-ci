{response}=require 'express'
proto=response.__proto__

proto.error=(data,session)->
    data.session=session
    data.disablelogin=true
    this.render 'error.jade',data
