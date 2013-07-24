db=require '../db'
sha1=require 'sha1'

module.exports.apply=(app)->
    app.get '/login',(req,res)->
        res.render 'login.jade',{session:req.session,disablelogin:true}

    app.post '/login',(req,res)->
        {admins}=db
        {username,password}=req.body
        password=sha1 password if password?
        admins.forEach (admin)->
            if admin.username is username and admin.password is password
                req.session.logined=true
                req.session.username=admin.username
                res.redirect '/'
        res.error {reason:'用户名密码验证错误',redirect:'/'},req.session unless req.session.logined
