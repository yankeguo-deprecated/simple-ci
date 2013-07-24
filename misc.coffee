os=require 'os'

module.exports.hostinfo=()->
    la=os.loadavg()
    las=(data.toFixed(2) for data in la).join ' , '
    utime=os.uptime()
    utimes=(utime/(24*3600)).toFixed()+'天'+((utime%(24*3600))/3600).toFixed()+'小时'+((utime%3600)/60).toFixed()+'分钟'+Math.round(utime%60)+'秒'
    memusage=(process.memoryUsage().heapUsed/1000000).toFixed(2)+' MB';
    return [
        [
            '主机名',os.hostname(),
            '系统类型',os.type()
        ],
        [
            '平台',os.platform(),
            '构架',os.arch()
        ],
        [
            '版本',os.release(),
            '负载',las
        ],
        [
            '总内存',(os.totalmem()/1000000).toFixed()+' MB',
            '可用内存',(os.freemem()/1000000).toFixed()+' MB'
        ],
        [
            '启动时间',utimes,'V8 Heap',memusage
        ]
    ]
