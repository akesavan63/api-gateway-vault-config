tenents = (process.argv.slice(2)[0])
// console.log(tenents)
tenentList = tenents.split(/,/);
// 22302fb5-cdae-4612-b14f-8a4a866dea5b"

const https = require('https');
const fs = require('fs')
var jwkToPem = require('jwk-to-pem');
var keyData=[];

function getPromise(tenentId){
    return new Promise((resolve, reject) => {
        https.get('https://login.microsoftonline.com/' + tenentId + '/discovery/v2.0/keys', (resp) => {
            let data = '';
            resp.on('data', (chunk) => {
                data += chunk;
            });

            resp.on('end', () => {
                resolve(data);
            });

        }).on("error", (err) => {
            reject(err)
        });
    })
}

async function loadData(){
    for(var tIndex in tenentList) {
        let tenentId = tenentList[tIndex]
        let http_body = await getPromise(tenentId);
        result = JSON.parse(http_body).keys
        for (var index in result) {
            var jwkData = result[index];
            var kid = result[index]['kid']
            var pem = jwkToPem(jwkData);
            // console.log(kid)
            var dir = 'keys';
            if (!fs.existsSync(dir)){
                fs.mkdirSync(dir);
            }
            fs.writeFileSync(dir + '/' + kid, pem);
            keyData[kid]=pem
        }
    }
    return keyData;
}

(async () => {
    const keyData = await loadData()
    console.log(keyData)
})();
