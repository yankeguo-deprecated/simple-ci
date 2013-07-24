forever=require 'forever'
length=50

module.exports.apply=(app)->
    app.get '/project/:project',(req,res)->
        {project,session}=req
        stdout=''
        if req.project.proc?
            forever.tail project.proc.file,{length,stream:false},(err,log)->
                stdout+=log.line if log.line?
                stdout+='\n'
        setTimeout ()->
            res.render 'project.jade',{project,session,stdout}
        ,1000
