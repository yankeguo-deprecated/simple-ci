{configfile,lockfile}=require '../defaults'
{name,content}=configfile

server=require.resolve '../ci-server'

fs=require 'fs'
should=require 'should'

log=console.log.bind console
error=console.log.bind console,'[ERROR]:'

log '\n====== Simple CI Server for Node.js ======\n'

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
            should.exists admin.name
            admin.name.should.be.a 'string'

            should.exists admin.password
            admin.password.should.be.a 'string'

        should.exists config.projects
        config.projects.should.be.an.instanceOf Array

        config.projects.forEach (project)->
            should.exists project

            should.exists project.name
            project.name.should.be.a 'string'

            should.exists project.path
            project.path.should.be.a 'string'

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
    log 'Default password: 123456 \n'

command=process.argv[2]
lockpath="#{home}/#{lockfile}"

if command is 'start'
    log '* Starting ...\n'
    lock=fs.existsSync lockpath
    if lock
        error "~/#{lockfile} found, there should already exist a running instance."
        error "If you are sure this is a fault, remove lockfile manully."
        process.exit 1
    fs.writeFileSync lockpath,'lock'
    log server
else if command is 'stop'
    log '* Stopping ...\n'
    try
        fs.unlinkSync lockpath
    catch ex
        if ex.code is 'ENOENT'
            error "Lockfile ~/#{lockfile} not found."
        else
            error "Failed to remove lockfile ~/#{lockfile}, remove it manully."
        process.exit 1
else
    error 'No command specified, use "simple-ci start" or "simple-ci stop".'
    process.exit 1
