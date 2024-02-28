const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { BusinessPartner, States,Store,Product,Purchase,Sales } = this.entities;

    this.on("READ", BusinessPartner, async (req) => {
        const results = await cds.run(req.query);
        return results;
    });
    this.on("READ", Store, async (req) => {
        const results = await cds.run(req.query);
        return results;
    });
    this.on("READ", Product, async (req) => {
        const results = await cds.run(req.query);
        return results;
    });
    this.on("READ", Purchase, async (req) => {
        const results = await cds.run(req.query);
        return results;
    });
    this.on("READ", Sales, async (req) => {
        const results = await cds.run(req.query);
        return results;
    });
    this.before(["CREATE"],Product,async(req)=>{
        const {ProductCP,ProductSP,ID} =req.data;
        if(ProductSP<ProductCP){
            req.error({
                code:"INVALIDPRICE",
                message:"selling price should be greater than cost price",
                target:"ProductSP",
            });
        }
    });
    this.before(["CREATE"], Purchase, async (req) => {
        const { Items } = req.data;
        for (const item of Items) {
            const product = await cds.read(Product).where({ ID: item.product_id_ID });
            const productCP = parseFloat(product[0].ProductCP);
            const price = parseFloat(item.price);
            if (price > productCP) {
                req.error({
                    code: "INVALIDPRICE",
                    message: "Price should not be greater than cost price for product: " + product[0].productname,
                    target: "Items",
                });
            }
        }
    });
    this.before(["CREATE"], Sales, async (req) => {
        const { Items } = req.data;
        for (const item of Items) {
            const product = await cds.read(Product).where({ ID: item.product_id_ID });
            const productSP = parseFloat(product[0].ProductSP);
            const price = parseFloat(item.price);
            if (price < productSP) {
                req.error({
                    code: "INVALIDPRICE",
                    message: "Price should be greater than sell price for product: " + product[0].productname,
                    target: "Items",
                });
            }
        }
    });
    

    this.before(["CREATE"], BusinessPartner, async (req) => {
        const { gst_registered, gst_no } = req.data;
        if (gst_registered && !gst_no) {
            req.error({
                code: "MISSING_GST_NUM",
                message: "GSTIN number is mandatory when Is_gstn_registered is true",
                target: "gst_no",
            });
        }

        const { bp_no } = req.data;
        const query = SELECT.from(BusinessPartner).where({ bp_no:req.data.bp_no });
        const exists=await cds.run(query)
        if (exists.length > 0) {
            req.error({
                code: "NAMEEXISTS",
                message: "Business Partner already exists",
                target: "bp_no",
            });
        }
    },
    this.before(["UPDATE"],BusinessPartner,async (req)=>{
        const { gst_registered, gst_no,bp_no } = req.data;
        if (gst_registered && !gst_no) {
            req.error({
                code:"GSTERROR",
                message:"gst number required",
                target:"gst_no",
                
            })
            
        }
        // if (bp_no){
        //     const qry=SELECT.from(BusinessPartner).where({bp_no:bp_no}).and({ID:{'!=':ID}});
        //     const result=await cds.run(qry);
        // }

    })
    );

    this.on("READ", States, async (req) => {
        const ses = [
            { "code": "TS", "description": "Telangana" },
            { "code": "AP", "description": "Andhra Pradesh" },
            { "code": "MP", "description": "Madhya Pradesh" }
        ];
        ses.$count = ses.length;
        return ses;
    });
});
