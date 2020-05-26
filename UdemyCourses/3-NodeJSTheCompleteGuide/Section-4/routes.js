const fs = require('fs');

const requestHandler = (req, res) => {
    const url = req.url;
    const method = req.method;

    if (url === '/') {
        res.write('<html>');
        res.write('<head><title>Enter Message</title></head>');
        res.write('<body><form action="/message" method="POST"><input type="text" name="message"><button type="submit">Save</button></input></form></body>')
        res.write('</html>');
        return res.end();
    }
    if (url === '/message' && method === 'POST') {
        const messageDetails = [];
        req.on('data', (chunk) => {
            messageDetails.push(chunk);
        });
        req.on('end', () => {
            const parsedDetails = Buffer.concat(messageDetails).toString();
            const messageParsed = parsedDetails.split('=')[1];
            fs.writeFileSync('message.txt', messageParsed, err => {
                res.statusCode = 302;
                res.setHeader('Location', '/');
                return res.end();
            });
        });
    }
    res.setHeader('Content-Type', 'text/html');
    res.write('<html>');
    res.write('<head><title>Jeans Test Node Server</title></head>');
    res.write('<body><h1>Welcome to my Test Node JS Server</body>');
    res.write('</html>');


}

module.exports = requestHandler;