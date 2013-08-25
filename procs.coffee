forever=require 'forever'
fs=require 'fs'
_=require 'underscore'

module.exports=(app)->
    {db}=app
    {projects}=db
    db.refresh=refresh=()->
        forever.list null,(err,data=[])->
            #Add index to proc
            data.forEach (proc,i)->
                proc.index=i
            #add proc to running project
            projects.forEach (project)->
                [project.proc]=data.filter (proc)->
                    proc.file is project.file
    db.save=()->
        fs.writeFile app.configfile,JSON.stringify db,null,' '
    refresh()
    setInterval refresh,2000
