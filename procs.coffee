forever=require 'forever'
_=require 'underscore'
db=require './db'

refresh=()->
    {projects}=db
    forever.list null,(err,data)->
        procs=if _.isArray data then data else []
        procs.forEach (proc,i)->
            proc.index=i
        projects.forEach (project)->
            [project.proc]=procs.filter (proc)->
                proc.file is project.file
        null

refresh()
setInterval refresh,2000
module.exports.refresh=refresh
