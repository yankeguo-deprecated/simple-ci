{throttler}=require '../middleware.js'
{refresh}=require '../procs.js'
{exec}=require 'child_process'
forever=require 'forever'

module.exports.apply=(app)->
    app.get '/project/:project/start',throttler,(req,res)->
        {project,session}=req
        return res.error {reason:"#{project.name} 已经启动",redirect:"/project/#{project.name}"},req.session if project.proc?
        stdout=''
        stderr=''
        child=exec 'forever start --plain '+project.file,(err)->
            err=err.message if err?
            res.render 'project.jade',{err,stdout,stderr,project,session,redirect:true}
        child.stdout.on 'data',(data)->
            stdout+=data
        child.stderr.on 'data',(data)->
            stderr+=data
