// Generated by CoffeeScript 1.6.3
(function() {
  var checkLogin, db;

  db = require('./db');

  checkLogin = require('./middleware.js').checkLogin;

  module.exports = function(app) {
    return app.param('project', checkLogin, function(req, res, next, id) {
      var projects;
      projects = db.projects;
      req.project = projects.filter(function(project) {
        return project.name === id;
      })[0];
      if (req.project == null) {
        res.error({
          reason: "项目 " + id + " 不存在",
          redirect: '/'
        }, req.session);
      }
      return next();
    });
  };

}).call(this);
