module.exports=
    configfile:
        name:'.simple-ci.json'
        content:
            port:4100
            admins:[
                username:'admin'
                password:'7c4a8d09ca3762af61e59520943dc26494f8941b'
            ]
            projects:[
                name:'Test Project'
                file:'/path/to/you/server.js'
                envs:[
                    key:'key1'
                    value:'value1'
                ]
            ]
