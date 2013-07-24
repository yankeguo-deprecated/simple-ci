{throttler}=require '../middleware.js'
{refresh}=require '../procs.js'
{exec}=require 'child_process'
forever=require 'forever'

module.exports.apply=(app)->
    app.get '/project/:project/pull',throttler,(req,res)->
        {project,session}=req
        cwd=(project.file.match /(.*\/).*$/)[1]
        stdout=''
        stderr=''
        child=exec 'pwd && git status -v && git pull -v && npm install --color=false ',{cwd},(err)->
            err=err.message if err?
            res.render 'project.jade',{err,stdout,stderr,project,session,redirect:true}
        child.stdout.on 'data',(data)->
            stdout+=data
        child.stderr.on 'data',(data)->
            stderr+=data
