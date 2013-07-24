{admins,projects}=require './db.json'

what=module.exports

what.reload=()->
    delete require.cache[require.resolve './db']
    {admins,projects}=require './db.json'

Object.defineProperty what,'admins',
    get:->
        admins

Object.defineProperty what,'projects',
    get:->
        projects
