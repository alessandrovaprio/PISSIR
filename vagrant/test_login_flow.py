#!/usr/bin/env python

import argparse
from http.server import HTTPServer, BaseHTTPRequestHandler

page = """
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Dimostrazione del flow di login</title>
    </head>
    <body>
        <h2>Flow di login di Aulos</h2>
        <button id="login" type="button">Login</button>
        <button id="logout" type="button">Logout</button>
        <pre id="risultato"></pre>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jwt-decode@3.1.2/build/jwt-decode.min.js"></script>

<script>
function dec2hex (dec) {
    return dec.toString(16).padStart(2, "0")
}

// https://stackoverflow.com/posts/27747377
// generateId :: Integer -> String
function generateId (len) {
    var arr = new Uint8Array((len || 40) / 2)
    window.crypto.getRandomValues(arr)
    return Array.from(arr, dec2hex).join('')
}

function pr(s) {
    $('#risultato').append(s + '\\n\\n')
}

$('#login').click(function() {
    let random_nonce = generateId(16)
    let state = 'qualunque'
    window.location.href = 'http://localhost:8080/auth/realms/Aulos/protocol/openid-connect/auth?client_id=aulos&redirect_uri=http://localhost:8000/&scope=openid&response_type=code&response_mode=fragment&state=' + encodeURIComponent(state) + '&nonce=' + encodeURIComponent(random_nonce)
});

$('#logout').click(function() {
    window.location.href = 'http://localhost:8080/auth/realms/Aulos/protocol/openid-connect/logout?redirect_uri=http://localhost:8000/'
});

function login_successful(data) {
    pr('risposta: ' + JSON.stringify(data, null, 2))
    pr('access_token decodificato: ' + JSON.stringify(jwt_decode(data['access_token']), null, 2))
    pr('id_token decodificato: ' + JSON.stringify(jwt_decode(data['id_token']), null, 2))
}

$(document).ready(function() {
    var hash = window.location.hash
    if (hash) {
        hash = hash.replace('#','')
        pr('code presente, richiedo token...')
        $.ajax({
            type: 'post',
            url:  'http://localhost:8080/auth/realms/Aulos/protocol/openid-connect/token',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            data: 'grant_type=authorization_code&client_id=aulos&redirect_uri=http://localhost:8000/&' + hash,
            success: login_successful,
            dataType: 'json'
        })
    }
});
</script>

    </body>
</html>
""".encode('utf-8')

class Handler(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

    def do_GET(self):
        global page
        self._set_headers()
        self.wfile.write(page)

    def do_HEAD(self):
        self._set_headers()

    def do_POST(self):
        global page
        self._set_headers()
        self.wfile.write(page)


def run(server_class=HTTPServer, addr="localhost", port=8000):
    server_address = (addr, port)
    httpd = server_class(server_address, Handler)

    print(f"Starting httpd server on {addr}:{port}")
    httpd.serve_forever()


if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-l",
        "--listen",
        default="localhost",
    )
    parser.add_argument(
        "-p",
        "--port",
        type=int,
        default=8000,
    )
    args = parser.parse_args()
    run(addr=args.listen, port=args.port)

