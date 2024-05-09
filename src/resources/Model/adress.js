const connection = require('../../config/connect_db')
const path = require('path')

const AdressServices = {
    city: (req, res) => {
        let {city} = req.body
        console.log(city)
        connection.query('SELECT * FROM district WHERE district.City = ?',[city],async(err,row)=>{
            if(err) return res.json({success:false,data:"Ló lỗi sảy ra"})
        
                console.log(row)
                return res.json({success:true,data:row})
        })
    },
    district: (req, res) => {
        let {district} = req.body
        console.log(district)
        connection.query('SELECT * FROM ward WHERE District = ?',[district],async(err,row)=>{
            if(err) return res.json({success:false,data:"Ló lỗi sảy ra"})
        
                console.log(row)
                return res.json({success:true,data:row})
        })
    },
}

module.exports = AdressServices