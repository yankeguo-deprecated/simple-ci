errdata={reason:'必须登录才能访问此功能',redirect:'/login'}
throttlelimit=5000

what=module.exports

what.checkLogin=(req,res,next)->
    return res.error errdata,req.session unless req.session.logined
    next()

what.throttler=(req,res,next)->
    {project}=req
    newbie=not project.lastrequest?
    if newbie or (Math.abs(project.lastrequest-Date.now())>throttlelimit)
        project.lastrequest=Date.now()
        next()
    else
        res.error {reason:'项目正忙',redirect:"/project/#{project.name}"},req.session
