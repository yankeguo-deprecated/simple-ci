db=require '../db'

console.log '''
=== JSON-Based Database Reload Test ===

*  Edit & Save ../db/db.confg at will

'''

setInterval ()->
    db.reload()
    console.log db.admins
    console.log db.projects
,5000
