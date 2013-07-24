{reload}=require '../db'
{checkLogin}=require '../middleware.js'
{refresh}=require '../procs.js'

module.exports.apply=(app)->
    app.get '/reload',checkLogin,(res,req)->
        reload()
        refresh()
        req.redirect '/'
