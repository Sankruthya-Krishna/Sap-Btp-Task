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
    ProductImg:String default 'https://i.pinimg.com/236x/3e/a9/47/3ea947c7c2ae57d763a9442fee8f1f2a.jpg';
    @title:'Product Cost Price'
    ProductCP:String(10);
    @title:'Product Sell Price'
    ProductSP:String(10);
    
};

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
    BusinessPartner:Association to BusinessPartner;
    @title:'PurchaseOrderDate'
    order_date:Date;
    @title:' Store_id'
      Store_id:Association to Store;
    Items:Composition of many {
    @title:' product_id'
     product_id:Association  to Product;
     @title:'Quantity'
     qty: String(4);
     @title:'Price'
     price:String(5);
      
    }
    //  Items:Composition of many{
    //     key ID:UUID;
    //     item:Association to Items;
    // }
}
entity Sales:cuid{
    @title:'Sales Order Number'
    order_no:String(3);
    @title:'BusinessPartner'
    bp:Association to BusinessPartner;
    @title:'SalesDate'
    date:Date;
        
    //  Items:Composition of many{
    //     key ID:UUID;
    //     item:Association to Items;
    // }
     @title:' Store_id'
      Store_id:Association to Store;
    Items:Composition of many {
    @title:' product_id'
     product_id:Association  to Product;
     @title:'Quantity'
     qty: Integer;
     @title:'Price'
     price:String(5);

    }
}
