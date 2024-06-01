const connection = require('../../config/connect_db')
const path = require('path')

const BuyerServices = {
    get_profile: (req, res) => {
        let user = req.user

        connection.query('select b.* ,w.Name as wname,d.name as district,c.name as city from buyers as b LEFT JOIN ward as w on b.Ward = w.Ward_id LEFT JOIN district as d on w.District = d.District_id LEFT JOIN city as c on c.City_id = d.City WHERE b.Buyer_id =?',[user.id],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
        
            if(row.length ==0) res.render(path.join(__dirname+"../../views/Users/login.ejs"))
            else{
                var checkdate=new Date(row[0].Birth)
                row[0].Birth = checkdate
                // row[0].Birth = {
                //     d:checkdate.getDate(),
                //     m:checkdate.getMonth() +1,
                //     y:checkdate.getFullYear()
                // }
                // console.log(checkdate.getDate(),checkdate.getMonth(),checkdate.getFullYear())
                return res.render(path.join(__dirname+"../../views/Buyers/profile.ejs"),{data:row[0]})
            }
        })
    },
    post_profile: (req, res) => {
        let user = req.user
        const{name,birth,Phone,adress,ward,gender}= req.body || 'NULL'
        console.log(name,birth,Phone,adress,ward,gender)
        connection.query('UPDATE buyers set Name = ?,Gender=?,Birth=?,Phone=?,Address=?,Ward=? where Buyer_id = ?;',[name,gender,birth,Phone,adress,ward,user.id],async(err,row)=>{
            if(err) console.log(err)
                
            return res.redirect('/buyer/profile')
        })
    },
    cart: (req, res) => {
        let user = req.user
        if(!user) return res.render(path.join(__dirname+"../../views/Users/login.ejs"))
        else{
            console.log(user)
            connection.query('select c.cart_id,c.Quantity as num,cl_t.*,cl.name as cname,pr.name as pname,pr.Seller_id from carts as c LEFT JOIN buyers as b ON c.user_id = b.Buyer_id LEFT JOIN classify_types as cl_t on c.classify_type_id = cl_t.Classify_type_id LEFT JOIN classify as cl on cl_t.classify_id = cl.classify_id LEFT JOIN products as pr on pr.Product_id = cl.Product_id WHERE b.Buyer_id = ? and status =0;',[user.id],async(err,row)=>{
                if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
                console.log(row)
                return res.render(path.join(__dirname+"../../views/Buyers/cart.ejs"),{data:row})
            })
        }
    },

    buy: (req, res) => {
        let user = req.user
        if(!user) return res.render(path.join(__dirname+"../../views/Users/login.ejs"))
        else{
            console.log(user)
            let {product,num} = req.body
            connection.query('SELECT * FROM `carts` WHERE user_id = ? and classify_type_id =?',[user.id,product], async(err,row)=>{
                if(err) return res.render(path.json(__dirname+"../../views/404.ejs"))
            
                if(row.length !=0){
                    let num_up = parseInt(num) + row[0].Quantity

                    connection.query('update carts set Quantity = ?  where  user_id = ? and classify_type_id =?;',[num_up,user.id,product], async(err,data)=>{
                        console.log(data)
                        if(err) return res.json({success:false,data:"thêm giỏ hàng thất bại"})
        
                        res.json({success:true,data:"thêm giỏ hàng thành công"})
                        
                    })
                }else{
                    connection.query('INSERT INTO `carts` (`user_id`, `classify_type_id`, `Quantity`) VALUES (?, ?, ?);',[user.id,product,num], async(err,data)=>{
                        console.log(data)
                        if(err) return res.json({success:false,data:"thêm giỏ hàng thất bại"})
        
                        res.json({success:true,data:"thêm giỏ hàng thành công"})
                        
                    })
                }
            })
        }
    },
    get_seller: (req, res) => {
        console.log(req.user,req.role)
        if(req.role==3) return res.redirect("/seller")
        else if(req.role==2) return res.render(path.join(__dirname+"../../views/Buyers/noti.ejs"),{content:"đã đăng ký thành công, vui lòng đợi đội ngũ ad duyệt, thông báo sẽ được gửi về gmail đăng ký"})
        else return res.render(path.join(__dirname+"../../views/Buyers/seller.ejs"),{content:""})
    },
    post_seller: (req, res) => {
        const{name}=req.body
        const user = req.user

        connection.query('SELECT * FROM `sellers` WHERE Shop_name = ?',[name], async(err,row)=>{
            if(err) return res.render(path.json(__dirname+"../../views/404.ejs"))
        
            if(row.length !=0){
                return res.render(path.join(__dirname+"../../views/Buyers/seller.ejs"),{content:"tên shop đã tồn tại"})
            }else{
                connection.query('INSERT into seller_registries(Shop_name,Buyer_id) VALUES(?,?)',[name,user.id], async(err,data)=>{
                    console.log(data)
                    if(err) return res.render(path.join(__dirname+"../../views/Buyers/seller.ejs"),{content:"có lỗi sảy ra, xin thử lại sau"})
    
                    return res.render(path.join(__dirname+"../../views/Buyers/noti.ejs"),{content:"đã đăng ký thành công, vui lòng đợi đội ngũ ad duyệt, thông báo sẽ được gửi về gmail đăng ký"})
                })
            }
        })
    },

    history: (req, res) => {
        let user = req.user
        console.log(user)
        connection.query('SELECT bp.*, spr.name as sname FROM `buyer_purchases` as bp LEFT JOIN status_purchases as spr on spr.Status_id = bp.Status WHERE bp.Buyer_id = ?;',[user.id],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
            console.log(row[0])
            for(i=0;i<row.length;i++){
                let check = JSON.stringify(row[i].Created_at)
                row[i].Created_at = check.substring(1,11)
            }
            // var last_price = (parseInt(row[0].Price) + parseInt(row[0].Transport_fee)) - (parseInt(row[0].Transport_voucher) + parseInt(row[0].Voucher_shop) + parseInt(row[0].Voucher))
            
            // console.log(last_price)
            return res.render(path.join(__dirname+"../../views/Buyers/history.ejs"),{data:row})
        })
    },
    history_detail: (req, res) => {
        let user = req.user
        const index = req.params.id
        connection.query('SELECT spr.name as sname,c.user_id,bp.Price,bp.Created_at,bp.Status, t.Price as price_trans,t.name as trans, cl_t.Name,cl_t.Prices,cl.Name as subcat,pr.name as cat,c.Quantity,c.status FROM `buyer_purchases` as bp LEFT JOIN transports as t on bp.Transport = t.Transports_id LEFT JOIN carts as c on c.Purchase_id = bp.Purchase_id LEFT JOIN classify_types as cl_t on c.classify_type_id = cl_t.Classify_type_id LEFT JOIN classify as cl on cl_t.classify_id = cl.classify_id LEFT JOIN products as pr on pr.Product_id = cl.Product_id LEFT JOIN status_purchases as spr on spr.Status_id = bp.Status WHERE bp.Purchase_id = ?',[index],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
                if(row[0].user_id == user.id){
                    let check = JSON.stringify(row[0].Created_at)
                    row[0].Created_at = check.substring(1,11)
                    console.log(row[0])
                    
                 
                    return res.render(path.join(__dirname+"../../views/Buyers/history_detail.ejs"),{data:row})
                }else{
                    return res.render(path.join(__dirname+"../../views/404.ejs"))
                }
            
        })
    },
    avatar:(req,res) =>{
        let user = req.user

        connection.query('UPDATE buyers SET Avatar= 1 WHERE Buyer_id = ?',[user.id],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
            
            return res.redirect('/buyer/profile')


        })
        
    },
    spending:(req,res) =>{
        let user = req.user
        const currentYear = new Date().getFullYear();
        console.log(currentYear)

        connection.query('SELECT SUM(Price) as Price FROM `buyer_purchases` WHERE Buyer_id = ? and YEAR(Created_at) = ? GROUP by Buyer_id;',[user.id,currentYear],async(err,row)=>{
            if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
            if(row.length ==0) return res.render(path.join(__dirname+"../../views/Buyers/spending.ejs"),{data:{Price:0}})

            return res.render(path.join(__dirname+"../../views/Buyers/spending.ejs"),{data:row[0]})
        })
        
    },
    spendingmonth:(req,res) =>{
        let user = req.user
        const currentYear = new Date().getFullYear();
        console.log(currentYear)
        let {month} = req.body
        connection.query('SELECT SUM(Price) as Price FROM `buyer_purchases` WHERE Buyer_id = ? and YEAR(Created_at) = ? and MONTH(Created_at) =? GROUP by Buyer_id;',[user.id,currentYear,month],async(err,row)=>{
            if(err) return res.json({success:false,data:"có lỗi sảy ra"})
            
            if(row.length ==0) return res.json({success:true,data:0})

            return  res.json({success:true,data:row[0].Price})
        })
        
    },
}

module.exports = BuyerServices