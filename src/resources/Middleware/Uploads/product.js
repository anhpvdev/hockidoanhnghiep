
const multer = require("multer")
    
const storage = multer.diskStorage({
  destination:(req,file,res)=>{
      let path = './src/public/images/Products'
      res(null,path)
  },
  filename:(req,file,res)=>{
   const product_id = req.body.product_id
    let filename = product_id+"_"+file.originalname
    res(null,filename)

  }
})

const product =multer({storage:storage})
    



module.exports = product