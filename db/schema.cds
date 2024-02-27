namespace com.test.taskdb;
using {cuid} from '@sap/cds/common';
@assert.unique:{
    bp_no:[bp_no]
}
entity BusinessPartner: cuid{
    //key ID:UUID;
    bp_no:String(5);
    @title:'name'
    name:String(10);
    @title:'State'
    state:Association to  States;
    @title:'Pin code'
    pincode : String(10);
    @title:'gst_registered'
    gst_registered : Boolean default false;
    @title:'GST_NO'
    gst_no:String(20);
    

}
@cds.persistence.skip
entity States {
    @title:'code'
    key code: String(3);
    @title:'description'
    description:String(10);
    
}
entity Store :cuid{
    @title:'StoreID'
    storeid:String(3);
    @title:'NAME'
    name:String(10);
    @title:'State'
     state:Association to  States;
     @title:'PINCODE'
     pincode:String(10);
}
entity Product :cuid{
    @title:'ProductID'
    productid:String(3);
    @title:'ProductName'
    productname:String(30);
    @title:'Product Image URL'
    ProductImg:String(30);
    @title:'Product Cost Price'
    ProductCP:String(10);
    @title:'Product Sell Price'
    ProductSP:String(10);
}
entity Stock :cuid{
    @title:'Store_id'
    storeid:Association to Store;
    @title:'Product_id'
    productid:Association to Product;
    @title:'stock_qty'
    stock_qty:String(2);
}
entity Purchase:cuid{
    @title:'PurchaseOrderNumer'
    order_no:String(2);
    @title:'BusinessPartner'
    BusinessPartner:String(10);
    @title:'PurchaseOrderDate'
    order_date:String(10);
     Items:Composition of many{
        key ID:UUID;
        item:Association to Items;
    }
}
entity Items:cuid{
    @title:' product_id'
     product_id:Association  to Product;
     @title:'Quantity'
     qty: Association  to Stock;
     @title:'Price'
     price:String(5);
     @title:'store_id'
     store_id:Association to Store;
}