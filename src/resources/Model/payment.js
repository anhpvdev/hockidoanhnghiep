const connection = require('../../config/connect_db')
const path = require('path')

const Payment = {
    home: (req, res) => {
        let user = req.user
        console.log(user)
        var message= req.query.message
        var amount= req.query.amount
        var extraData= JSON.parse(req.query.extraData)
        console.log(extraData)
        // var message = "Thành công."
        // var amount = 477000
        // var extraData = ["3","2","4"]
        if(message == "Thành công."){
            
        
            connection.query('INSERT INTO buyer_purchases (Buyer_id,Price, Transport, Status) VALUES(?, ?, ?,5);',[user.id,amount,extraData[0]],async(err,row)=>{
                if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                    
                console.log(row.insertId)
                var query = `UPDATE carts SET status = 1,Purchase_id = ${row.insertId} WHERE cart_id = `+ extraData[1]
                if(extraData.length >2){
                    for(let i=2;i<extraData.length;i++){
                        query +=` or cart_id = ${extraData[i]}`
                    }
                   }
                   console.log(query)
                   connection.query(query,async(err,row2)=>{
                    if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                        
                        return res.render(path.join(__dirname+"../../views/Payment/home.ejs"))
            
                })

            })
        }
        
        // return res.render(path.join(__dirname+"../../views/Payment/home.ejs"))
    },

    payment: (req, res) => {
       
        var listcart = req.body.name.split(',')
        var query = "select c.cart_id,c.Quantity as num,cl_t.*,cl.name as cname,pr.name as pname,pr.Seller_id from carts as c LEFT JOIN buyers as b ON c.user_id = b.Buyer_id LEFT JOIN classify_types as cl_t on c.classify_type_id = cl_t.Classify_type_id LEFT JOIN classify as cl on cl_t.classify_id = cl.classify_id LEFT JOIN products as pr on pr.Product_id = cl.Product_id WHERE c.cart_id ="+ listcart[0]
        // console.log(listcart)
       if(listcart.length >1){
        for(let i=1;i<listcart.length;i++){
            query +=` or c.cart_id = ${listcart[i]}`
        }
       }
       console.log(query)
       connection.query(query,async(err,row)=>{
        if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
            connection.query('SELECT * FROM transports',async(err,trans)=>{
                if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
                    
                console.log(row)
                return res.render(path.join(__dirname+"../../views/Buyers/payment.ejs"),{data:row,trans:trans})
            })

    })
        // return res.render(path.join(__dirname+"../../views/Payment/home.ejs"))
    },

    test: (request, response) => {
        const {money,name} = request.body

        console.log(money,name)
        //https://developers.momo.vn/#/docs/en/aiov2/?id=payment-method
        //parameters
        var accessKey = 'F8BBA842ECF85';
        var secretKey = 'K951B6PE1waDMi640xX08PD3vg6EkVlz';
        var orderInfo = 'thanh toan don hang';
        var partnerCode = 'MOMO';
        var redirectUrl = 'http://localhost:8081/pay/home';
        var ipnUrl = 'http://localhost:8081/pay/home';
        var requestType = "payWithMethod";
        var amount = money;
        var orderId = partnerCode + new Date().getTime();
        var requestId = orderId;
        var extraData = JSON.stringify(name);
        var paymentCode = 'T8Qii53fAXyUftPV3m9ysyRhEanUs9KlOPfHgpMR0ON50U10Bh+vZdpJU7VY4z+Z2y77fJHkoDc69scwwzLuW5MzeUKTwPo3ZMaB29imm6YulqnWfTkgzqRaion+EuD7FN9wZ4aXE1+mRt0gHsU193y+yxtRgpmY7SDMU9hCKoQtYyHsfFR5FUAOAKMdw2fzQqpToei3rnaYvZuYaxolprm9+/+WIETnPUDlxCYOiw7vPeaaYQQH0BF0TxyU3zu36ODx980rJvPAgtJzH1gUrlxcSS1HQeQ9ZaVM1eOK/jl8KJm6ijOwErHGbgf/hVymUQG65rHU2MWz9U8QUjvDWA==';
        var orderGroupId = '';
        var autoCapture =true;
        var lang = 'vi';

        //before sign HMAC SHA256 with format
        //accessKey=$accessKey&amount=$amount&extraData=$extraData&ipnUrl=$ipnUrl&orderId=$orderId&orderInfo=$orderInfo&partnerCode=$partnerCode&redirectUrl=$redirectUrl&requestId=$requestId&requestType=$requestType
        var rawSignature = "accessKey=" + accessKey + "&amount=" + amount + "&extraData=" + extraData + "&ipnUrl=" + ipnUrl + "&orderId=" + orderId + "&orderInfo=" + orderInfo + "&partnerCode=" + partnerCode + "&redirectUrl=" + redirectUrl + "&requestId=" + requestId + "&requestType=" + requestType;
        //puts raw signature
        // console.log("--------------------RAW SIGNATURE----------------")
        // console.log(rawSignature)
        //signature
        const crypto = require('crypto');
        var signature = crypto.createHmac('sha256', secretKey)
            .update(rawSignature)
            .digest('hex');
        // console.log("--------------------SIGNATURE----------------")
        // console.log(signature)

        //json object send to MoMo endpoint
        var requestBody = JSON.stringify({
            partnerCode : partnerCode,
            partnerName : "Test",
            storeId : "MomoTestStore",
            requestId : requestId,
            amount : amount,
            orderId : orderId,
            orderInfo : orderInfo,
            redirectUrl : redirectUrl,
            ipnUrl : ipnUrl,
            lang : lang,
            requestType: requestType,
            autoCapture: autoCapture,
            extraData : extraData,
            orderGroupId: orderGroupId,
            signature : signature
        });
        //Create the HTTPS objects
        const https = require('https');
        const options = {
            hostname: 'test-payment.momo.vn',
            port: 443,
            path: '/v2/gateway/api/create',
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Content-Length': Buffer.byteLength(requestBody)
            }
        }
        //Send the request and get the response
        const req = https.request(options, res => {
            // console.log(`Status: ${res.statusCode}`);
            // console.log(`Headers: ${JSON.stringify(res.headers)}`);
            res.setEncoding('utf8');
            res.on('data', (body) => {
                console.log('Body: ');
                var data = JSON.parse(body)
                console.log(data.payUrl);
                response.redirect(data.payUrl)

            });
            res.on('end', () => {
                console.log('No more data in response.');
            });
        })

        req.on('error', (e) => {
            console.log(`problem with request: ${e.message}`);
        });
        // write data to request body

        console.log("Sending....")
        req.write(requestBody);
        req.end();
        
        },

}

module.exports = Payment