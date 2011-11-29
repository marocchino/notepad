# GET home page.
exports.index = (req, res) ->
  res.render 'index',
    title: 'Express'
    env: process.env.NODE_ENV || "development"
