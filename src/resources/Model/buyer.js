const connection = require('../../config/connect_db')
const path = require('path')

const BuyerServices = {
    profile: (req, res) => {
        let user = req.user
        if(!user) return res.render(path.join(__dirname+"../../views/Users/login.ejs"))
        else{
            console.log(user)
            connection.query('select * from buyers where Email = ? and Password = ?',[user.gmail,user.password],async(err,row)=>{
                if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
                if(row.length ==0) res.render(path.join(__dirname+"../../views/Users/login.ejs"))
                else{
                    console.log(row[0])
                    return res.render(path.join(__dirname+"../../views/Buyers/profile.ejs"),{data:row[0]})
                }
            })
        }
    },
    cart: (req, res) => {
        let user = req.user
        if(!user) return res.render(path.join(__dirname+"../../views/Users/login.ejs"))
        else{
            console.log(user)
            connection.query('select c.Quantity as num,cl_t.*,cl.name as cname,pr.name as pname,pr.Seller_id from carts as c INNER JOIN buyers as b ON c.user_id = b.Buyer_id INNER JOIN classify_types as cl_t on c.classify_type_id = cl_t.Classify_type_id INNER JOIN classify as cl on cl_t.classify_id = cl.classify_id INNER JOIN products as pr on pr.Product_id = cl.Product_id WHERE b.Buyer_id = ?;',[user.id],async(err,row)=>{
                if(err) return res.render(path.join(__dirname+"../../views/404.ejs"))
            
                if(row.length ==0) res.render(path.join(__dirname+"../../views/Users/login.ejs"))
                else{
                    console.log(row[0])
                    return res.render(path.join(__dirname+"../../views/Buyers/cart.ejs"),{data:row})
                }
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
}

module.exports = BuyerServices