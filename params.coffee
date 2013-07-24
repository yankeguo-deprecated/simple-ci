db=require './db'
{checkLogin}=require './middleware.js'

module.exports=(app)->
    app.param 'project',checkLogin,(req,res,next,id)->
        {projects}=db
        [req.project]=projects.filter (project)->
            project.name is id
        res.error {reason:"项目 #{id} 不存在",redirect:'/'},req.session unless req.project?
        next()
