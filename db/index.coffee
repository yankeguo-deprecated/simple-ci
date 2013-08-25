{admins,projects}=require './db.json'

what=module.exports

Object.defineProperty what,'admins',
    get:->
        admins

Object.defineProperty what,'projects',
    get:->
        projects
