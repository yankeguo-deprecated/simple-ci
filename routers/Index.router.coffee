db=require '../db'
{hostinfo}=require '../misc.js'

module.exports.apply=(app)->
    app.get '/',(req,res)->
        res.render 'index.jade',{projects:db.projects,session:req.session,hostinfo:hostinfo()}
