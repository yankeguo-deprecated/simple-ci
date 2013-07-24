fs=require 'fs'

#Load Routers
routers=[]
files=fs.readdirSync __dirname
files.forEach (file)->
    routers.push require "./#{file}" if file.match /\.router\.js$/

module.exports=(app)->
    #Apply Middlewares
    routers.forEach (router)->
        func=router.apply
        func app if typeof func is 'function'
