const express = require('express')
const compression = require('compression')
const path = require('path')
const cache = require('apicache').middleware
const app = express()

// 路由
const mainRouter = require('./router/main.js');

let publicPath = path.resolve(__dirname, 'public');

app.use(compression())

app.use(express.static(publicPath))

// cache
app.use(cache('5 minutes'));

app.use('/', mainRouter);

app.use(function(req, res) {
    res.statusCode = 404;
    res.end("404");
})

app.listen(8001, () => {
    console.log('listen on 8001');
})
