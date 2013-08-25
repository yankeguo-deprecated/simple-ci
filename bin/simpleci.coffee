{configfile}=require '../defaults'
{name,content}=configfile

server=require.resolve '../ci-server'

fs=require 'fs'
should=require 'should'
{exec}=require 'child_process'
forever=require 'forever'

check=(callback)->
    forever.list null,(err,data=[])->
        callback data.some (proc)->
            proc.file is server

log=console.log.bind console
error=console.log.bind console,'[ERROR]:'

log '\n====== Simple CI Server for Node.js ======\n'

checkenv=()->

    log '* Checking environment ...'
    home=process.env.HOME
    unless home?
        error 'Where is your home folder ? Check your $HOME varable.'
        process.exit 1
    log "   Your $HOME is #{home} "
    log '√ Done.\n'

    path="#{home}/#{name}"
    bol=fs.existsSync path

    if bol
        log "* Config file ~/#{name} found, checking ..."
        try
            config=require path
            should.exists config

            should.exists config.port
            config.port.should.be.a 'number'

            should.exists config.admins
            config.admins.should.be.an.instanceOf Array
            config.admins.forEach (admin)->
                should.exists admin
                should.exists admin.username
                admin.username.should.be.a 'string'
                should.exists admin.password
                admin.password.should.be.a 'string'

            should.exists config.projects
            config.projects.should.be.an.instanceOf Array
            config.projects.forEach (project)->
                should.exists project
                should.exists project.name
                project.name.should.be.a 'string'
                should.exists project.file
                project.file.should.be.a 'string'
                should.exists project.envs
                project.envs.should.be.an.instanceOf Array
                project.envs.forEach (env)->
                    should.exists env
                    should.exists env.key
                    env.key.should.be.a 'string'
                    should.exists env.value
            log '√ Done.\n'
        catch ex
            error "Cannot open ~/#{name} as a valid json config file."
            error ex
            process.exit 1
    else
        log "! Config file ~/#{name} not found, creating ..."
        err=fs.writeFileSync path,JSON.stringify content,null,' '
        if err?
            error "Cannot create defult config file."
            error err
            process.exit 1
        log '√ Done.\n'
        log 'Default username: admin '
        log 'Default password: 123456'
        log 'Default port:     4100 \n'

command=process.argv[2]

if command is 'start'
    checkenv()
    log '* Starting ...\n'
    check (lock)->
        if lock
            error "There exists already a running instance."
        else
            child=exec "forever start --minUptime 1000 --spinSleepTime 1000 --plain #{server}",{env:process.env},(err)->
                process.exit 1 if err?
                log '√ Done.'
            child.stderr.on 'data',error
            child.stdout.on 'data',log

else if command is 'stop'
    log '* Stopping ...\n'
    check (lock)->
        unless lock
            error 'There is no running instance.'
        else
            child=exec "forever stop --plain #{server}",{env:process.env},(err)->
                process.exit 1 if err?
                log '√ Done.'
            child.stderr.on 'data',error
            child.stdout.on 'data',log

else if command is 'status'
    check (bol)->
        log if bol then '* Running ...' else '* Stopped .'
        log()
else
    checkenv()
    log 'Running in foreground ...'
    check (bol)->
        if bol
            error 'There exists already a running instance.'
        else
            child=exec "forever --minUptime 1000 --spinSleepTime 1000 --plain #{server}",{env:process.env}
            child.stderr.on 'data',error
            child.stdout.on 'data',log
