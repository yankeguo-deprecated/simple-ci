{hostinfo}=require '../misc.js'

module.exports.apply=(app)->
    {db}=app
    app.get '/',(req,res)->
        res.render 'index.jade',{session:req.session,hostinfo:hostinfo()}
