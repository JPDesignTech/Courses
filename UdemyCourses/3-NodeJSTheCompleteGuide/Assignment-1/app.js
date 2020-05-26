const http = require('http');

const routes = require('./routes');

const ourServer = http.createServer(routes);

ourServer.listen(3000);